Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135310AbRDZQle>; Thu, 26 Apr 2001 12:41:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135323AbRDZQlZ>; Thu, 26 Apr 2001 12:41:25 -0400
Received: from www.teaparty.net ([216.235.253.180]:39178 "EHLO
	www.teaparty.net") by vger.kernel.org with ESMTP id <S135310AbRDZQlL>;
	Thu, 26 Apr 2001 12:41:11 -0400
Date: Thu, 26 Apr 2001 17:41:07 +0100 (BST)
From: Vivek Dasmohapatra <vivek@etla.org>
To: Yiping Chen <YipingChen@via.com.tw>
cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: About rebuild 2.4.x kernel to support SMP.
In-Reply-To: <611C3E2A972ED41196EF0050DA92E0760265D56C@EXCHANGE2>
Message-ID: <Pine.LNX.4.10.10104261729050.3902-100000@www.teaparty.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Apr 2001, Yiping Chen wrote:

> Where the uname command extract the kernel version information(eg:
> 2.4.2-2smp or 2.2.16)?

uname [the shell command] is a wrapper around the uname  system call:

man 1 uname
man 2 uname

> I means from which file, or use which system call?

>From a strace -v of uname:

uname({sysname="Linux", 
       nodename="arachne", 
       release="2.2.18-00",
       version="#9 Wed Jan 3 13:48:37 GMT 2001", 
       machine="i686"}) = 0

> I don't know where to get the kernel_version information. I need some help.
> Thanks!!
> may I use uname? I worry that the driver will install to incorrect path, and
> user will complain it.

You can [and may] use uname to get the kernel version string. I am less
certain about the exact layout of the module tree under 2.4.3.

-- 
I dunno about the Big Bang. The Big Kludge I can believe in.

