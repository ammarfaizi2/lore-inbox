Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317522AbSGESN0>; Fri, 5 Jul 2002 14:13:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317525AbSGESNZ>; Fri, 5 Jul 2002 14:13:25 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:49419 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317522AbSGESNY>; Fri, 5 Jul 2002 14:13:24 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: prevent breaking a chroot() jail?
Date: 5 Jul 2002 11:15:39 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <ag4nob$sgq$1@cesium.transmeta.com>
References: <1025877004.11004.59.camel@zaphod>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <1025877004.11004.59.camel@zaphod>
By author:    Shaya Potter <spotter@cs.columbia.edu>
In newsgroup: linux.dev.kernel
>
> I'm trying to develop a way to ensure that one can't break out of a
> chroot() jail, even as root.  I'm willing to change the way the syscalls
> work (most likely only for a subset of processes, i.e. processes that
> are run in the jail end up getting a marker which is passed down to all
> their children that causes the syscalls to behave differently).
> 
> What should I be aware of?  I figure devices (no need to run mknod in
> this jail) and chroot (as per man page), is there any other way of
> breaking the chroot jail (at a syscall level or otherwise)?
> 
> or is this 100% impossible?
> 

This sounds like a job for [dum de dum dum] capabilities... remember,
on Linux root hasn't been almighty for a very long time, it's just a
matter of which capabilities you retain.  Of course, if you really
want to be safe, you might end up with a rather castrated root inside
the chroot shell.

If you really want to jail something, use UML.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
