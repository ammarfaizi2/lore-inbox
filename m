Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261320AbTC0UQY>; Thu, 27 Mar 2003 15:16:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261326AbTC0UQY>; Thu, 27 Mar 2003 15:16:24 -0500
Received: from hera.cwi.nl ([192.16.191.8]:59354 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S261320AbTC0UQY>;
	Thu, 27 Mar 2003 15:16:24 -0500
From: Andries.Brouwer@cwi.nl
Date: Thu, 27 Mar 2003 21:27:37 +0100 (MET)
Message-Id: <UTC200303272027.h2RKRbf27546.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, zippel@linux-m68k.org
Subject: Re: 64-bit kdev_t - just for playing
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It would really help, if you would explain how a larger dev_t
> will work during 2.6.

> How is backward compatibility done, so that I can still boot a 2.4 kernel?

Old device numbers remain valid, so all changes are completely
transparent.

> How have user space utilities to be changed, which know about
> dev_t (e.g. ls or fdisk)?

If you do not use mknod to create device nodes with large device numbers,
then no new utilities are needed. If you really want to use large
device numbers, you need a new glibc; some utilities will require
recompilation because of the use of sysmacros.h.

Andries
