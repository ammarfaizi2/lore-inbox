Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263363AbTDCMSk>; Thu, 3 Apr 2003 07:18:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263364AbTDCMSk>; Thu, 3 Apr 2003 07:18:40 -0500
Received: from cc78409-a.hnglo1.ov.home.nl ([212.120.97.185]:42690 "EHLO
	dexter.hensema.net") by vger.kernel.org with ESMTP
	id <S263363AbTDCMSj>; Thu, 3 Apr 2003 07:18:39 -0500
From: Erik Hensema <erik@hensema.net>
Subject: Re: How to fix the ptrace flaw without rebooting
Date: Thu, 3 Apr 2003 12:30:05 +0000 (UTC)
Message-ID: <slrnb8oaad.j0h.erik@bender.home.hensema.net>
References: <200304030708_MC3-1-32C2-5A8A@compuserve.com>
Reply-To: erik@hensema.net
User-Agent: slrn/0.9.7.4 (Linux)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck Ebbert (76306.1226@compuserve.com) wrote:
> 	Author: Chuck Ebbert
> 	Adapted from: Phrack Inc., Volume 0x0b, Issue 0x3a, Phile #0x07
> 	Directions: Run this program as root on an x86 machine.
> 		It will disable the ptrace system call, thus
> 		fixing the Linux 'ptrace flaw'.  (It will also
> 		break strace, debugging tools and User Mode Linux.)
> 	WARNING: Your computer may crash or do other strange things
> 		if you run this program as root.  No warranty.

If you can't reboot to apply a security fix, you've got a serious problem.

A better fix in a running system is to simply disable dynamic module
loading: echo /no/such/file > /proc/sys/kernel/modprobe
At the very least you can be sure your machine won't crash this way ;-)

-- 
Erik Hensema <erik@hensema.net>
