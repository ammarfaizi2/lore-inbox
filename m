Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751961AbWHNInr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751961AbWHNInr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 04:43:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751959AbWHNInr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 04:43:47 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:62617 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751945AbWHNInq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 04:43:46 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@suse.cz>
Subject: Re: 2.6.18-rc4 (and earlier): CMOS clock corruption during suspend to disk on i386
Date: Mon, 14 Aug 2006 10:41:59 +0200
User-Agent: KMail/1.9.3
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Linux ACPI <linux-acpi@vger.kernel.org>
References: <200608091426.31762.rjw@sisk.pl> <200608102251.20707.rjw@sisk.pl> <20060813223354.GF6231@elf.ucw.cz>
In-Reply-To: <20060813223354.GF6231@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608141041.59410.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 14 August 2006 00:33, Pavel Machek wrote:
> On Thu 2006-08-10 22:51:20, Rafael J. Wysocki wrote:
]--snip--[
> > > > > BTW, it's a dangerous setting, because some drivers get mad if the time after
> > > > > the resume appears to be earlier than the time before the suspend.  Also the
> > > > > timer .suspend/.resume routines aren't prepared for that.
> > > > 
> > > > Its config option should just go away. People comfortable using *that*
> > > > should just edit some header file. Rafael, could you do patch doing
> > > > something like that?
> > > 
> > > Just remove the option from Kconfig or the whole setting?
> > > 
> > > Shouldn't we also change the timer .resume() routines to check if the time
> > > after the resume is later than (or at least the same as) the time before the
> > > suspend and set the "sleep length" to 0 if not?
> > 
> > Hm, I'm thinking it may actually be useful to have in Kconfig and if we change
> > the timer resume to detect the dangerous situation and prevent it from
> > happening, that should be sufficient.
> 
> Well, it is still too easy to shoot yourself in the foot. Your time
> will be wrong if you enable innocent-sounding option.

We can add DANGEROUS to it. :-)

Rafael
