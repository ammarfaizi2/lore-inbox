Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264414AbUENBsK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264414AbUENBsK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 21:48:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264512AbUENBsJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 21:48:09 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:2730 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S264414AbUENBrt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 21:47:49 -0400
Date: Fri, 14 May 2004 10:48:38 +0900
From: "Y.Ishikawa" <y.ishikawa@soft.fujitsu.com>
Subject: Re: [rft] testing BSD accounting format on different archs
To: tim@physik3.uni-rostock.de
Cc: linux-kernel@vger.kernel.org, y.ishikawa@soft.fujitsu.com
Message-id: <20040514104838.7e052881.y.ishikawa@soft.fujitsu.com>
MIME-version: 1.0
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Content-type: MULTIPART/MIXED; BOUNDARY="Boundary_(ID_n6dFki5Z4JaFsbkA48nMYA)"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Boundary_(ID_n6dFki5Z4JaFsbkA48nMYA)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT

Hello,

>Date Sat, 24 Apr 2004 13:46:54 +0200 (CEST)
>From Tim Schmielau <>
>Subject [rft] testing BSD accounting format on different archs
>
>I intend to modify the format of the BSD accounting file in a way that
>
>  a) allows cross-platform compatibility using patched acct tools and
 >  b) is fully binary compatible with the current format.
>
>To make sure these goals are met on all platforms, I'd like to see the
>output of the attached program on all linux ports *except* x86
>(I want to keep my Inbox manageable:).

Please see the attachment for details of the result of acct after applying
your patch.

My machine is:
  2 SMP of Itanium 2 (1.2GHz)
  Memory: 8 Gbytes
  Kernel: 2.6.6

BTW. how is your development for "version2" that you posted in this Mar.19.
I have been interested in your V2 format. The account data is very 
useful for performance analysis of processes. It would be more convenient 
if acct datainclude pid and ppid.
Naturally I understood V2 would have some incompatibility against current
acct structure. However I'm sure the value of acct data would become larger
in V2.
I hope V2 structure would be included in 2.7 successfully.
I also found tgid is useful in multithread environment, especially NPTL, to
identify the thread and process of a work-unit. Could you add a tgid field
in your V2 structure?

Regards,
Y.Ishikawa

===< program message >================================================

ia64 ia64 ia64 GNU/Linux

             v0  v1  v2
ac_flag       0   0   0
ac_version        1   1
ac_uid16      2   2   2
ac_gid16      4   4   4
 ac_tty        6   6   6
ac_btime      8   8   8
ac_utime     12  12  12
ac_stime     14  14  14
ac_etime     16  16  16
ac_mem       18  18  18
ac_io        20  20  20
ac_rw        22  22  22
ac_minflt    24  24  24
ac_majflt    26  26  26
ac_swaps     28  28  28
ac_ahz           30  36
ac_exitcode  32  32  32
ac_comm      36  36  38
ac_etime_hi      53  55
ac_etime_lo      54  56
ac_uid           56  60
ac_gid           60  64
sizeof(struct acct)
             64  64  68

    01 00 04 03  06 05 08 07  0c 0b 0a 09  0e 0d 10 0f
    12 11 14 13  16 15 18 17  1a 19 1c 1b  1e 1d 00 00
    24 23 22 21  25 26 27 28  29 2a 2b 2c  2d 2e 2f 30
    31 32 33 34  35 f0 f1 f2  f3 f4 f5 f6  f7 f8 f9 00

    01 02 04 03  06 05 08 07  0c 0b 0a 09  0e 0d 10 0f
    12 11 14 13  16 15 18 17  1a 19 1c 1b  1e 1d 20 1f
    24 23 22 21  25 26 27 28  29 2a 2b 2c  2d 2e 2f 30
    31 32 33 34  35 36 38 37  3c 3b 3a 39  40 3f 3e 3d

    01 02 04 03  06 05 08 07  0c 0b 0a 09  0e 0d 10 0f
    12 11 14 13  16 15 18 17  1a 19 1c 1b  1e 1d 00 00
    24 23 22 21  20 1f 25 26  27 28 29 2a  2b 2c 2d 2e
    2f 30 31 32  33 34 35 36  38 37 00 00  3c 3b 3a 39

--Boundary_(ID_n6dFki5Z4JaFsbkA48nMYA)
Content-type: application/octet-stream; name=acct_test_nQPpjh
Content-disposition: attachment; filename=acct_test_nQPpjh
Content-transfer-encoding: base64

AQAEAwYFCAcMCwoJDg0QDxIRFBMWFRgXGhkcGx4dAAAkIyIhJSYnKCkqKywtLi8wMTIzNDXw8fLz
9PX29/j5AAECBAMGBQgHDAsKCQ4NEA8SERQTFhUYFxoZHBseHSAfJCMiISUmJygpKissLS4vMDEy
MzQ1Njg3PDs6OUA/Pj0BAgQDBgUIBwwLCgkODRAPEhEUExYVGBcaGRwbHh0AACQjIiEgHyUmJygp
KissLS4vMDEyMzQ1Njg3AAA8Ozo5

--Boundary_(ID_n6dFki5Z4JaFsbkA48nMYA)--
