Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262465AbSJVMQr>; Tue, 22 Oct 2002 08:16:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262475AbSJVMQr>; Tue, 22 Oct 2002 08:16:47 -0400
Received: from sentry.gw.tislabs.com ([192.94.214.100]:10627 "EHLO
	sentry.gw.tislabs.com") by vger.kernel.org with ESMTP
	id <S262465AbSJVMQr>; Tue, 22 Oct 2002 08:16:47 -0400
Date: Tue, 22 Oct 2002 08:22:26 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
X-X-Sender: <sds@raven>
To: Crispin Cowan <crispin@wirex.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Greg KH <greg@kroah.com>,
       Christoph Hellwig <hch@infradead.org>,
       Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <linux-security-module@wirex.com>
Subject: Re: [PATCH] remove sys_security
In-Reply-To: <3DB46DD2.8030007@wirex.com>
Message-ID: <Pine.GSO.4.33.0210220806040.22890-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 21 Oct 2002, Crispin Cowan wrote:

> Therefore, the sys_security syscall has been removed. LSM-aware
> applications that want to talk to security modules can do so through a
> file system interface. This will work for WireX, and Smalley says it
> will work for SELinux. I hope it will work for others.

Actually, with regard to using a pseudo filesystem interface, I said that
we could investigate it, but I have doubts about cleanly supporting the
extended forms of existing calls (e.g. execve_secure, mkdir_secure,
msgrcv_secure, recvmsg_secure, etc) using such an interface.  I
raised the same issue when sys_security was originally discussed on
the lsm list long ago.  SELinux extends the POSIX API to incorporate
security (specifically flexible mandatory access control) as a first class
notion.

However, I understand Christoph's objection to sys_security and am not
trying to revive that debate.  We can hopefully have a dialogue about the
SELinux API with the kernel developers at a later time and come to some
consensus on a set of specific system calls that can be added to the
kernel to support equivalent functionality to the SELinux API.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com



