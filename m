Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264264AbUBHWqO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Feb 2004 17:46:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264283AbUBHWqO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Feb 2004 17:46:14 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:46556 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264264AbUBHWqL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Feb 2004 17:46:11 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Andre Tomt <andre@tomt.net>
Subject: Re: Linux 2.6.3-rc1
Date: Sun, 8 Feb 2004 23:51:48 +0100
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0402061823040.30672@home.osdl.org> <200402082234.22043.bzolnier@elka.pw.edu.pl> <4026B064.5080900@tomt.net>
In-Reply-To: <4026B064.5080900@tomt.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402082351.48958.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> >>EIP is at ide_pci_register_host_proc+0x27/0x40 [ide_core]
> >
> > Can you disassemble ide_pci_register_host_proc using gdb?
>
> I'd need a walkthrough, not very familiar with gdb other than getting a
> backtrace out of it

Make sure to enable following options in kernel config:
CONFIG_DEBUG_KERNEL ("Kernel hacking"->"Kernel debugging" ) and
CONFIG_DEBUG_INFO ("Kernel debugging"->"Compile the kernel with debug info").

Recompile kernel.

$ gdb /usr/src/linux/vmlinux
(gdb) disassemble ide_pci_register_host_proc

That's all :-).

