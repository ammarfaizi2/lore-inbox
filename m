Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317465AbSFKSN7>; Tue, 11 Jun 2002 14:13:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317466AbSFKSN6>; Tue, 11 Jun 2002 14:13:58 -0400
Received: from air-2.osdl.org ([65.201.151.6]:30219 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S317465AbSFKSN5>;
	Tue, 11 Jun 2002 14:13:57 -0400
Date: Tue, 11 Jun 2002 11:09:35 -0700 (PDT)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Robert Love <rml@tech9.net>
cc: <linux-kernel@vger.kernel.org>, <akpm@zip.com.au>
Subject: Re: [PATCH] CONFIG_NR_CPUS, redux
In-Reply-To: <1023817936.21176.232.camel@sinai>
Message-ID: <Pine.LNX.4.33L2.0206111102110.2449-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11 Jun 2002, Robert Love wrote:

| Here are the defaults I picked:
|
| CONFIG_NR_CPUS=32: i386, mips, parisc, ppc, sparc

I don't know what is "typical" for non-x86, but for x86, why not
use something more like a 'typical' NR_CPUS for SMP, like 8 (?)...
why still waste all of that memory?

| CONFIG_NR_CPUS=64: alpha, ia64, mips64, ppc64, s390, s390x, sparc64, x86-64
|
| No CONFIG_NR_CPUS: arm, cris, sh
|
| Andrew has pointed out some architectures may need minor tweaks to work
| with NR_CPUS < 32.  He discovered and fixed a minor issue on i386...

What was this problem?  I missed it but would like to see it.
(or do you know what the Subject: was?)

One spello (typo) below.

| diff -urN linux-2.5.21/arch/i386/Config.help linux/arch/i386/Config.help
| --- linux-2.5.21/arch/i386/Config.help	Sat Jun  8 22:27:21 2002
| +++ linux/arch/i386/Config.help	Sun Jun  9 13:13:02 2002
| @@ -25,6 +25,14 @@
|
|    If you don't know what to do here, say N.
|
| +CONFIG_NR_CPUS
| +  This allows you to specify the maximum number of CPUs which this
| +  kernel will support.  The maximum supported value is 32 and the
| +  mimimum value which makes sense is 2.
---  minimum
| +
| +  This is purely to save memory - each supported CPU adds
| +  approximately eight kilobytes to the kernel image.

Thanks,
-- 
~Randy

