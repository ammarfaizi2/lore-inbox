Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319006AbSHMRyr>; Tue, 13 Aug 2002 13:54:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319004AbSHMRyr>; Tue, 13 Aug 2002 13:54:47 -0400
Received: from air-2.osdl.org ([65.172.181.6]:29451 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S319005AbSHMRyq>;
	Tue, 13 Aug 2002 13:54:46 -0400
Date: Tue, 13 Aug 2002 10:55:25 -0700 (PDT)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: "H. Peter Anvin" <hpa@zytor.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: klibc and logging
In-Reply-To: <ajbgbf$7e7$1@cesium.transmeta.com>
Message-ID: <Pine.LNX.4.33L2.0208131054020.5175-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 13 Aug 2002, H. Peter Anvin wrote:

| > H. Peter Anvin <hpa@zytor.com> wrote:
| > >However, I'm wondering what to do about logging.  Kernel log messages
| > >get stored away until klogd gets started, but early userspace may need
| > >some way to log messages -- and syslog is obviously not running.  The
| > >easiest way to do this would probably be to be able to write to
| > >/proc/kmsg (which probably really should be /dev/kmsg) and push messages
| > >onto the kernel's message queue; but we could also have a dedicated
| > >location in the initramfs for writing logs, and do it all in userspace.
|
| Andrew Morton sent me a proposed patch last night which adds a klogctl
| (a.k.a. sys_syslog) which does a printk() from userspace.  It was less
| than 10 lines; i.e. probably worth it.  I have hooked this up to
| syslog(3) in klibc, although the code is not checked in yet.

Hey, that's the same idea as my "how to add a syscall" example!!
  http://www.xenotime.net/linux/syscall_ex/addasyscall-2418.patch

-- 
~Randy

