Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273369AbRINSUO>; Fri, 14 Sep 2001 14:20:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273370AbRINSUF>; Fri, 14 Sep 2001 14:20:05 -0400
Received: from winds.org ([209.115.81.9]:39433 "EHLO winds.org")
	by vger.kernel.org with ESMTP id <S273369AbRINST6>;
	Fri, 14 Sep 2001 14:19:58 -0400
Date: Fri, 14 Sep 2001 14:19:57 -0400 (EDT)
From: Byron Stanoszek <gandalf@winds.org>
To: Roberto Jung Drebes <drebes@inf.ufrgs.br>
cc: "Eric W. Biederman" <ebiederm@xmission.com>,
        Chris Vandomelen <chrisv@b0rked.dhs.org>,
        <linux-kernel@vger.kernel.org>,
        VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
Subject: Re: Athlon: Try this (was: Re: Athlon bug stomping #2)
In-Reply-To: <Pine.GSO.4.21.0109140523060.3130-100000@jacui>
Message-ID: <Pine.LNX.4.33.0109141414430.29038-100000@winds.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Sep 2001, Roberto Jung Drebes wrote:

> +/* Fixes some oopses on fast_copy_page when it uses 'movntq's
> + * instead of 'movq's on Athlon/Duron optimized kernels.
> + * Bit 7 at offset 0x55 seems to be responsible.
> + * > Device 0 Offset 55 - Debug (RW)
> + * > 7-0 Reserved (do not program). default = 0
> + * > *** ABIT KT7A 3R BIOS: non-zero!? (oopses)
> + * > *** ABIT KT7A YH BIOS: zero. (works)
> + */

I'm using the ZT bios with ABIT KT7A and I have not encountered any OOPSes or
anything with Athlon/Duron optimized kernels. I've been using the -ac kernels
since 2.4.0, upgrading regularly. I'm running a 1200 MHz TBird.  I'm reluctant
to try later BIOSes because #1: Mine works as it is now, and #2: I'm afraid of
'increased memory stability' changes that would decrease performance or raise
CPU temperature (as one BIOS changelog had mentioned).

Output of /proc/bus/pci/00/00.0:

000:  06 11 05 03 06 00 10 22  03 00 00 06 00 08 00 00         "
010:  08 00 00 d8 00 00 00 00  00 00 00 00 00 00 00 00
020:  00 00 00 00 00 00 00 00  00 00 00 00 7b 14 01 a4              {
030:  00 00 00 00 a0 00 00 00  00 00 00 00 00 00 00 00
040:  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
050:  18 a3 ec b4 47 89 10 10  08 80 00 00 08 08 0c 10      G
060:  3c 2a 00 20 52 52 52 c6  45 0c 43 0f 08 5f 00 00  <*  RRR E C  _
070:  dc 88 cc 0c 0e 80 d2 00  01 b4 19 02 00 00 00 00
080:  0f 40 00 00 c0 00 00 00  02 00 00 00 00 00 00 00   @
090:  00 00 00 00 00 00 00 00  00 00 00 00 00 32 00 00               2
0A0:  02 c0 20 00 17 02 00 1f  00 00 00 00 2f 12 14 00              /
0B0:  49 da 88 58 31 ff 80 05  67 00 00 00 00 00 00 00  I  X1   g
0C0:  01 00 02 00 00 00 00 00  00 00 00 00 00 00 00 00
0D0:  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
*
0F0:  00 00 00 00 00 03 03 00  22 00 00 00 00 00 91 06          "

The ZT bios has bit 7 of offset 0x55 set, too.

This is an unmodified 2.4.8-ac7.

 -Byron

-- 
Byron Stanoszek                         Ph: (330) 644-3059
Systems Programmer                      Fax: (330) 644-8110
Commercial Timesharing Inc.             Email: byron@comtime.com

