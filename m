Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317586AbSGEVTO>; Fri, 5 Jul 2002 17:19:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317582AbSGEVTM>; Fri, 5 Jul 2002 17:19:12 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:45060 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S317586AbSGEVTI>; Fri, 5 Jul 2002 17:19:08 -0400
Subject: Re: prevent breaking a chroot() jail?
To: spotter@cs.columbia.edu (Shaya Potter)
Date: Fri, 5 Jul 2002 22:35:06 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1025877004.11004.59.camel@zaphod> from "Shaya Potter" at Jul 05, 2002 09:50:02 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17QajK-0004I3-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> work (most likely only for a subset of processes, i.e. processes that
> are run in the jail end up getting a marker which is passed down to all
> their children that causes the syscalls to behave differently).
> 
> What should I be aware of?  I figure devices (no need to run mknod in
> this jail) and chroot (as per man page), is there any other way of
> breaking the chroot jail (at a syscall level or otherwise)?
> 
> or is this 100% impossible?

Its hairy. You need to avoid devices, root, fd passing from untrusted agents
outside the chroot world and shared uid (ptrace) attacks. If you are outside the
USA you can do this with NSA SE Linux although in the US you may hit the
type enforcement patents.

Alan
