Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932420AbWBBKkB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932420AbWBBKkB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 05:40:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932430AbWBBKkB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 05:40:01 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:62378 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932420AbWBBKkB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 05:40:01 -0500
Date: Thu, 2 Feb 2006 11:39:47 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <nigel@suspend2.net>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Pekka Enberg <penberg@cs.helsinki.fi>,
       linux-kernel@vger.kernel.org
Subject: Re: [ 01/10] [Suspend2] kernel/power/modules.h
Message-ID: <20060202103947.GB1884@elf.ucw.cz>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602021922.11100.nigel@suspend2.net> <20060202101626.GD1981@elf.ucw.cz> <200602022029.32524.nigel@suspend2.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602022029.32524.nigel@suspend2.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > I'm more concerned about the security implications. I'll freely admit
> > > that I haven't spent any real time looking at your code, but I'm
> > > concerned that the additional functionality made available could be used
> > > by viruses and the like. I'm sure you'd have to be root to do anything,
> > > but how could the interfaces be misused?
> >
> > In vanilla kernel userland suspend has no security implications: root
> > can just do what he wants in /dev/mem, anyway.
> 
> Ok.
> 
> > In fedora kernel, userland suspend can be [miss]used to snapshot an
> > image, modify it, and write it back. Fortunately, this is going to
> > take *long* time so people will notice. [Interface changed on DaveJ's
> > request, now we have separate device, we no longer mess with
> > /dev/mem]. And similar problem exists in suspend2 -- malicious
> > graphical progress bar could probably modify memory image on disk.
> 
> How? It's just an ordinary process with no special permissions or access to 
> memory. The communication between the userspace process and the kernel is in 
> the form of a netlink socket, with the only messages sent back and forth 
> being what should be displayed or what actions the user requested. Everything 
> related to preparing the image and performing the I/O is done in the kernel. 
> There's no way I can see that a malicious userspace program could modify 
> anything but its own memory.

Fedora people have some "interesting" ideas about security. They want
to prevent userland to modify kernel memory, root or not. AFAICS
progress bar helper could access kernel memory  while it is on disk,
then wait for resume to pick up the modifications.
								Pavel
-- 
Thanks, Sharp!
