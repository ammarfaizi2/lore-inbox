Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261393AbVECEsi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261393AbVECEsi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 00:48:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261389AbVECEsh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 00:48:37 -0400
Received: from mail.kroah.org ([69.55.234.183]:15814 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261388AbVECEsd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 00:48:33 -0400
Date: Mon, 2 May 2005 21:48:05 -0700
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>, B.Zolnierkiewicz@elka.pw.edu.pl
Cc: juhl-lkml@dif.dk, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: 2.6.12-rc3-mm2 - /proc/ide/sr0/model: No such file or directory
Message-ID: <20050503044805.GA14750@kroah.com>
References: <20050430164303.6538f47c.akpm@osdl.org> <Pine.LNX.4.62.0505010429050.2491@dragon.hyggekrogen.localhost> <20050503031158.GA6917@kroah.com> <20050502201823.0ab02e96.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050502201823.0ab02e96.akpm@osdl.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 02, 2005 at 08:18:23PM -0700, Andrew Morton wrote:
> Greg KH <greg@kroah.com> wrote:
> >
> > On Sun, May 01, 2005 at 04:32:45AM +0200, Jesper Juhl wrote:
> > > On Sat, 30 Apr 2005, Andrew Morton wrote:
> > > 
> > > > 
> > > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc3/2.6.12-rc3-mm2/
> > > > 
> > > 
> > > I see one small change in behaviour with this kernel.
> > > 
> > > During boot when initializing udev I see 
> > > 
> > > Initializing udev dynamic device directory.
> > > grep: /proc/ide/sr0/model: No such file or directory
> > > grep: /proc/ide/sr1/model: No such file or directory
> > > 
> > > With previous kernels I only see
> > > 
> > > Initializing udev dynamic device directory.
> > 
> > That is because you have a udev script that is expecting to see ide
> > stuff in proc.  That has now been moved to sysfs, so you should not need
> > to run external scripts to detect ide devices now.  I suggest you go bug
> > your distro, or whoever set up those rules about it.
> 
> err, we don't want to break existing userspace setups, please.

I agree.  Bart, want to put the /proc stuff back, mark it depreciated in
the Documentation/feature-removal-schedule.txt as going away in 6 months
or so, and then remove it after that time has gone by?

thanks,

greg k-h
