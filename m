Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262503AbVA0QMt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262503AbVA0QMt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 11:12:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262491AbVA0QMj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 11:12:39 -0500
Received: from rev.193.226.232.37.euroweb.hu ([193.226.232.37]:2468 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S262361AbVA0QMh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 11:12:37 -0500
To: s.b.wielinga@student.utwente.nl
CC: davidsen@tmr.com, akpm@osdl.org, linux-kernel@vger.kernel.org
In-reply-to: <20050127155634.GA6476@speedy.student.utwente.nl> (message from
	Sytse Wielinga on Thu, 27 Jan 2005 16:56:34 +0100)
Subject: Re: 2.6.11-rc2-mm1: fuse patch needs new libs
References: <20050125000339.GA610@speedy.student.utwente.nl> <41F90C85.5090705@tmr.com> <20050127155634.GA6476@speedy.student.utwente.nl>
Message-Id: <E1CuCFP-0003Oz-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 27 Jan 2005 17:11:55 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > >As I personally like for my ls to keep on working, and I assume
> > >others will, too, I would appreciate it if you could add a
> > >warning to your announcements the following one or two weeks or
> > >so, so that people can remove this patch if they don't want to
> > >update their libs.
> > 
> > By any chance would this also break perl programs which readdir?
> 
> Of course; I haven't tested it, but the actual ioctls aren't working
> anymore, so it's not even _possible_ to get them to work with this
> patch and an old version of the fuse libs, even with perl bindings,
> which go through the fuse libs anyway.

First, a little clarification: FUSE doesn't use ioctl() for
communication between the kernel and userspace.  It uses read() and
write().

That aside, you are right, that this change breaks any kind of FUSE
based filesystem.  However the fix is trivial: install FUSE version
2.2-pre5 or later.  The filesystems themselves don't need to be
rebuilt, since the fix in the shared library will automatically get
used.

Thanks,
Miklos

