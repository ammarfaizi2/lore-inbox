Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129157AbQKJDST>; Thu, 9 Nov 2000 22:18:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129152AbQKJDR7>; Thu, 9 Nov 2000 22:17:59 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:37393 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129157AbQKJDRw>; Thu, 9 Nov 2000 22:17:52 -0500
Message-ID: <3A0B68D0.EB344C71@transmeta.com>
Date: Thu, 09 Nov 2000 19:17:36 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test10-pre3 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: CPU detection revamp (Request for comments)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

I wanted to give you a preview of the CPUID revision patch; it is not
100% ready yet in that (a) it still has a bunch of debugging printk() and
(b) I haven't ported over mtrr.c yet.

This code took a lot longer to write than I had expected, mostly because
I kept running into various forms of bugs with the *old* code.  In fact,
it looks like some of the bugs involving CPUID feature flags in the past
have been due to the inconsistent handling of these flags in Linux.  I
believe the new code should be a lot better in this aspect, and should
avoid bugs as much as possible.

I would very much like this code to be tested and get success/fail
reports on various CPUs, *especially* AMD (Athlon especially) and Cyrix
chips.

As I mentioned, you will have to compile without MTRR support in this
version.  I should have that fixed soon.

The patch is at:

ftp://ftp.kernel.org/pub/linux/kernel/people/hpa/cpuid-2.4.0-test11-pre2-1.diff

In case of success, please send me the output of the new /proc/cpuinfo on
your system.  In case of failure, please compile and run the following
program and send me the output, as well as /proc/cpuinfo from an
unpatched kernel version:

ftp://ftp.kernel.org/pub/linux/kernel/people/hpa/cpuid.c

Many thanks,

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
