Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161071AbWBHI2i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161071AbWBHI2i (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 03:28:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161075AbWBHI2h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 03:28:37 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:14223 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1161071AbWBHI2h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 03:28:37 -0500
Date: Wed, 8 Feb 2006 09:28:10 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Nigel Cunningham <nigel@suspend2.net>, Lee Revell <rlrevell@joe-job.com>,
       Jim Crilly <jim@why.dont.jablowme.net>,
       suspend2-devel@lists.suspend2.net, linux-kernel@vger.kernel.org
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Message-ID: <20060208082810.GB10961@elf.ucw.cz>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602080027.09305.rjw@sisk.pl> <20060207235011.GB10520@elf.ucw.cz> <200602080116.12992.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602080116.12992.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Suspend-to-disk HOWTO
> > ~~~~~~~~~~~~~~~~~~~~
> > Copyright (C) 2006 Pavel Machek <pavel@suse.cz>
> > 
> > 
> > You'll need /dev/snapshot for these to work:
> > 
> > crw-r--r--  1 root root 10, 231 Jan 13 21:21 /dev/snapshot


> > Then compile userspace tools in usual way. You'll need an -mm kernel
> > for now. To suspend-to-disk, run

I actually added -mm warning here.

> > ./suspend /dev/<your_swap_partition>
> > 
> > . (There should be just one, for now.) Suspend is easy, resume is
> > slightly harder. Resume application has to be ran without any
> > filesystems mounted rw, and without any journalling filesystems
> > mounted at all, preferably from initrd (but read-only ext2 should do
> > the trick, too). Resume is then as easy as running
> > 
> > ./resume /dev/<your_swap_partition>
> > 
> > . You probably want to create script that attempts to resume with
> > above command, and if that fails, fall back to init.
> 
> If it's run fron an initrd, it'll fall back automatically.  Also you can set
> the name of the resume partition in the header file swsusp.h and
> you'll be able to use the tools without any command line
> parameters (useful if you want to start resume from an initrd).

I know a little about initrd. I've just commited HOWTO file, can you
edit it to describe that?
								Pavel

-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
