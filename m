Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264076AbUEXHSz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264076AbUEXHSz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 03:18:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264085AbUEXHSd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 03:18:33 -0400
Received: from mail023.syd.optusnet.com.au ([211.29.132.101]:26856 "EHLO
	mail023.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S264076AbUEXHRo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 03:17:44 -0400
From: "Cef (LKML)" <cef-lkml@optusnet.com.au>
To: linux-kernel@vger.kernel.org
Subject: Re: [announce/OT] kerneltop ver. 0.7
Date: Mon, 24 May 2004 17:18:42 +1000
User-Agent: KMail/1.6.2
Cc: William Lee Irwin III <wli@holomorphy.com>,
       "Randy.Dunlap" <rddunlap@osdl.org>
References: <20040523215027.5dc99711.rddunlap@osdl.org> <200405241553.44114.cef-lkml@optusnet.com.au> <20040524060007.GN1833@holomorphy.com>
In-Reply-To: <20040524060007.GN1833@holomorphy.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200405241718.43010.cef-lkml@optusnet.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 May 2004 16:00, William Lee Irwin III wrote:
> On Mon, May 24, 2004 at 03:53:42PM +1000, Cef (LKML) wrote:
> > Looks good! A few suggestions....
> > Might want to add support for /boot/System.map containing the version
> > number (eg: /boot/System.map-`uname -r` ), if /boot/System.map doesn't
> > exist, before just dropping out with an error.
> > For clarity, you might want to invert the "address  function ....." line
> > to separate the header from the actual displayed data (like top does).
> > Having the total up in the header instead of at the end of the data might
> > also be useful (eg: next to ticks perhaps?) as it's really a waste of a
> > display line for 1 number.
> > Also a little more verbosity in the error messages would be good.
> > eg:
> >  /proc/profile not found:
> >  You need to enable profiling support in your kernel to use kerneltop
> >  /proc/profile Permission Denied:
> >  You need to be root to run kerneltop
> > Hope these comments are useful.
>
> Please try the patch I just posted which eliminates the need to be root.

Works well, but there is one notable side effect.

First time you read /proc/profile, you get everything instead of the last 
difference, so the first display is huge (and total_ticks is just right off 
the scale). Probably a good idea to read the values once first, just throw 
them away, and use that as the starting point.

-- 
 Stuart Young (aka Cef)
 cef-lkml@optusnet.com.au is for LKML and related email only
