Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271385AbTHDFtw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 01:49:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271386AbTHDFtw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 01:49:52 -0400
Received: from [203.53.213.67] ([203.53.213.67]:49161 "EHLO exchange.world.net")
	by vger.kernel.org with ESMTP id S271385AbTHDFtv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 01:49:51 -0400
Message-ID: <6416776FCC55D511BC4E0090274EFEF5080024AC@exchange.world.net>
From: Steven Micallef <steven.micallef@world.net>
To: "'Ben Collins'" <bcollins@debian.org>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: chroot() breaks syslog() ?
Date: Mon, 4 Aug 2003 15:49:48 +1000 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You're right - my mistake, it doesn't actually work on 2.4.8 either, I think
I was looking at the wrong thing when I thought it was actually working.

Is it worth considering (optionally) making /dev available to chroot()'ed
environments, or would that just defeat the whole purpose of chroot()?

Regards,

Steve.

> -----Original Message-----
> From: Ben Collins [mailto:bcollins@debian.org]
> Sent: Monday, 4 August 2003 3:19 PM
> To: Steven Micallef
> Cc: 'linux-kernel@vger.kernel.org'
> Subject: Re: chroot() breaks syslog() ?
> 
> 
> > connect(3, {sin_family=AF_UNIX, path="/dev/log"}, 16) = -1 
> ENOENT (No such
> > file or directory)
> > 
> > Is this intentional? If so, is there a work-around? I 
> discovered this when
> > debugging 'rwhod', but I imagine there are many more utils 
> that would be
> > affected too.
> 
> I don't know how it ever did work, if in fact it did for you. /dev/log
> is not a kernel device, it's just a normal socket created by syslogd.
> 
> Now, if you use devfs, and mount devfs under the chroot, it magically
> propogates /dev/log. But that's not the normal thing.
> 
> -- 
> Debian     - http://www.debian.org/
> Linux 1394 - http://www.linux1394.org/
> Subversion - http://subversion.tigris.org/
> WatchGuard - http://www.watchguard.com/
> __________ Information from NOD32 1.449 (20030630) __________
> 
> This message was checked by NOD32 for Exchange e-mail monitor.
> http://www.nod32.com
> 
> 
> 
> 
