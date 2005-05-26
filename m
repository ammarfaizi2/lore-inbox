Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261306AbVEZLJ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261306AbVEZLJ6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 07:09:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261308AbVEZLJ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 07:09:58 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:35785 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S261306AbVEZLJ5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 07:09:57 -0400
Date: Thu, 26 May 2005 13:09:39 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Andrew Morton <akpm@osdl.org>
cc: "Martin J. Bligh" <mbligh@mbligh.org>, linux-kernel@vger.kernel.org,
       christoph@lameter.com
Subject: Re: 2.6.12-rc5-mm1
In-Reply-To: <20050526002459.320abe65.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0505261306340.996@scrub.home>
References: <175590000.1117089446@[10.10.2.4]> <20050525234717.261beb48.akpm@osdl.org>
 <191140000.1117091133@[10.10.2.4]> <195320000.1117091674@[10.10.2.4]>
 <20050526002459.320abe65.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 26 May 2005, Andrew Morton wrote:

> "Martin J. Bligh" <mbligh@mbligh.org> wrote:
> >
> > source kernel/Kconfig.hz is under:
> >  menu "APM (Advanced Power Management) BIOS Support"
> >  depends on PM && !X86_VISWS
> > 
> >  So it's screwed if you don't have PM defined, it seems.
> 
> Ah, OK.  Something like this:

Only i386 has this problem, the others put it into the "Processor type and 
features" menu, where it doesn't get the extra dependencies, so the 
easiest solution might to move it for i386 there as well.

bye, Roman
