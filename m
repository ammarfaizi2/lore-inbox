Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751011AbWBXNUT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751011AbWBXNUT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 08:20:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750919AbWBXNUT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 08:20:19 -0500
Received: from ns2.suse.de ([195.135.220.15]:4522 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750807AbWBXNUS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 08:20:18 -0500
From: Andi Kleen <ak@suse.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] x86_64 stack trace cleanup
Date: Fri, 24 Feb 2006 14:20:13 +0100
User-Agent: KMail/1.9.1
Cc: dilinger@debian.org, linux-kernel@vger.kernel.org
References: <1140777679.5073.17.camel@localhost.localdomain> <200602241400.42432.ak@suse.de> <20060224051303.64ff912b.akpm@osdl.org>
In-Reply-To: <20060224051303.64ff912b.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602241420.13980.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 24 February 2006 14:13, Andrew Morton wrote:


> 
> > > Problem is, scrollback doesn't work after panic().  I don't know why..
> > 
> > Someone claimed it was related to the panic keyboard blinking.
> >
> 
> Strange.  It looks pretty harmless.

[just speculation, haven't examined the code in detail]

One credible theory also was that the keyboard or console driver does too much
work in workqueues, which need the scheduler and scheduling doesn't work anymore
after panic. I remember hacking around a problem with this long ago on 2.4
The hack was to just check after_panic and call the function directly.

-Andi

