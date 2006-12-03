Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759967AbWLCXme@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759967AbWLCXme (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 18:42:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759969AbWLCXme
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 18:42:34 -0500
Received: from hummeroutlaws.com ([12.161.0.3]:20485 "EHLO atpro.com")
	by vger.kernel.org with ESMTP id S1759967AbWLCXmd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 18:42:33 -0500
Date: Sun, 3 Dec 2006 18:42:02 -0500
From: Jim Crilly <jim@why.dont.jablowme.net>
To: Tomasz Chmielewski <mangoo@wpkg.org>
Cc: Ross Vandegrift <ross@kallisti.us>, Andreas Schwab <schwab@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: why can't I remove a kernel module (or: what uses a given module)?
Message-ID: <20061203234202.GL7114@grifter.jdc.home>
Mail-Followup-To: Tomasz Chmielewski <mangoo@wpkg.org>,
	Ross Vandegrift <ross@kallisti.us>, Andreas Schwab <schwab@suse.de>,
	linux-kernel@vger.kernel.org
References: <4572B30F.9020605@wpkg.org> <jewt592oxf.fsf@sykes.suse.de> <4572BBE0.4010801@wpkg.org> <20061203154936.GB26669@kallisti.us> <45732C8E.4060801@wpkg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45732C8E.4060801@wpkg.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/03/06 08:59:10PM +0100, Tomasz Chmielewski wrote:
> Ross Vandegrift wrote:
> >On Sun, Dec 03, 2006 at 12:58:24PM +0100, Tomasz Chmielewski wrote:
> >>You mean the "Used by" column? No, it's not used by any other module 
> >>according to lsmod output.
> >>
> >>Any other methods of checking what uses /dev/sda*?
> >
> >There's a good chance that if it was loaded at system boot, hald or
> >udev may be doing something with it.
> 
> This machine doesn't have hal; when I kill udevd still doesn't help.
> 
> Yes, something's using that drive, be it a program, a module (unlikely), 
> or something that is compiled directly in the kernel (for example, 
> md/raid1).
> But what is it?
> 
> Kernel knows it, as it refuses to remove the module (via rmmod), but how 
> to tell kernel to share this knowledge with me?
> 

Have you checked to make sure there's no swap partitions on it being
automatically activated at boot? Also, have you checked the output of lsof?

Jim.
