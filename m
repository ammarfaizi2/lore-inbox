Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269979AbRHEQvA>; Sun, 5 Aug 2001 12:51:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269977AbRHEQuu>; Sun, 5 Aug 2001 12:50:50 -0400
Received: from [24.93.67.52] ([24.93.67.52]:11791 "EHLO mail5.nc.rr.com")
	by vger.kernel.org with ESMTP id <S269976AbRHEQuh>;
	Sun, 5 Aug 2001 12:50:37 -0400
From: "C. Linus Hicks" <lhicks@nc.rr.com>
To: <Remy.Card@linux.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: PROBLEM: mkfs wrote to wrong partition
Date: Sun, 5 Aug 2001 12:50:16 -0400
Message-ID: <006a01c11dce$b4338bb0$0a0a0a0a@k-6_iii-400.mindspring.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_006B_01C11DAD.2D21EBB0"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook 8.5, Build 4.71.2377.0
X-MimeOLE: Produced By Microsoft MimeOLE V4.72.3110.3
Importance: Normal
X-MS-TNEF-Correlator: 00000000730E8182FE67D31183650080AE00000164B7FB01
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_006B_01C11DAD.2D21EBB0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

I am running Redhat 7.1 with the following:

Software:

kernel                 2.4.6 smp
Gnu C                  2.91.66      (It's a Redhat system but I use kgcc)
Gnu make               3.79.1
binutils               2.10.91.0.2
util-linux             2.10s
mount                  2.10r
modutils               2.4.2
e2fsprogs              1.19
reiserfsprogs          3.x.0j
Linux C Library        2.2.2
Dynamic linker (ldd)   2.2.2
Procps                 2.0.7
Net-tools              1.57
Console-tools          0.3.3
Sh-utils               2.0

Hardware:

Asus P2B-DS with 2 600Mhz P III Intel
1gb memory
3 SCSI disks using the new AIC7XXX driver

The point of the following exercise was to move from a single CPU 400Mhz
system to a dual 600Mhz and from an IDE disk to SCSI. I already had Redhat
7.1 with a 2.4.6 kernel running on the dual 600 and was replacing it with
the system from the 400Mhz IDE system. All operations were performed on the
dual 600.

While running the system booted with root=/dev/sda2 I made partitions on
/dev/sdb just like on /dev/sda, then copied all files over. I modified the
lilo.conf in /etc on /dev/sda2 to have boot=/dev/sdb and set the
root=/dev/sdb2 for each image. I ran lilo then booted the system.

The system looked like I expected it to: mount showed /dev/sdb2 mounted as
the root filesystem.

Next I did mkfs on the partitions on /dev/sda, starting with the higher
partitions and working down, and copied data from hda. By the way, the
P2B-DS BIOS allows me to choose whether IDE or SCSI comes first, therefore I
can boot from SCSI even though an IDE disk is attached. Current setting was
SCSI first. When I got to /dev/sda2 I tried to format it reiserfs, but it
complained about the filesystem being mounted. Not quite realizing what was
going on yet, I tried mkfs -t ext2 and it worked. Shortly after that, I
noticed that df showed /dev/sdb2 as looking nearly empty. I looked with ls
and no files showed up. And I started having problems running most commands,
as you can imagine.

The system seemed to be getting /dev/sda2 confused with /dev/sdb2. This
seems like a bug to me, and I wonder if I tried to do something that isn't
supported.

Keywords: filesystem ext2 reiserfs

I've been using Linux for several years now, but have never submitted a bug
report before.

If you need additional information, please let me know.

Linus Hicks
lhicks@nc.rr.com


------=_NextPart_000_006B_01C11DAD.2D21EBB0
Content-Type: application/ms-tnef;
	name="winmail.dat"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="winmail.dat"

eJ8+IhAQAQaQCAAEAAAAAAABAAEAAQeQBgAIAAAA5AQAAAAAAADoAAEIgAcAGAAAAElQTS5NaWNy
b3NvZnQgTWFpbC5Ob3RlADEIAQ2ABAACAAAAAgACAAEGgAMADgAAANEHCAAFAAwAMgAAAAAAIwEB
A5AGAMQKAAAnAAAACwACAAEAAAALACMAAAAAAAMAJgAAAAAACwApAAAAAAADADYAAAAAAB4AcAAB
AAAAJwAAAFBST0JMRU06IG1rZnMgd3JvdGUgdG8gd3JvbmcgcGFydGl0aW9uAAACAXEAAQAAABYA
AAABwR3OtAIhxmeHfukR1YP1AJAnEzMCAAACAR0MAQAAABYAAABTTVRQOkxISUNLU0BOQy5SUi5D
T00AAAALAAEOAAAAAEAABg4A7EGqzh3BAQIBCg4BAAAAGAAAAAAAAABzDoGC/mfTEYNlAICuAAAB
woAAAAsAHw4BAAAAAwAGELc1OfsDAAcQ3AYAAB4ACBABAAAAZQAAAElBTVJVTk5JTkdSRURIQVQ3
MVdJVEhUSEVGT0xMT1dJTkc6U09GVFdBUkU6S0VSTkVMMjQ2U01QR05VQzI5MTY2KElUU0FSRURI
QVRTWVNURU1CVVRJVVNFS0dDQylHTlVNQUsAAAAAAgEJEAEAAABMBgAASAYAAL0KAABMWkZ10alg
Yv8ACgEDAfcCpARlCFUHsgKDJwBQA9QCAGNoCsBzZdh0MCAHEwKAfQqECzCBC2BuZzEwMzMLpgAg
SSBhbSBydX5uAwASsAfwCYAREAVAN4guMSAD8HRoIBVAdGUgAhBsCQAD8BKwOqcKogqECoBTbwGA
dwrAamUWS2sEkWUDIBjOMgAuNC42IHNtcHEWVEdudQ9QGM8ZwTkOMRoAGhAbIyhJdCcFBCBhFGZz
eXN0ZVkT0GJ1BUAToHURQCDga2djYykaaADAGGBhGy0zLjc5FPAWVGL/C4AecAMQBCAY/hLQHEIj
gKYyFlQiEi1sIfF4Io9/ENAWYwRgFAAFQCbfI1JynSYmZCIfGaUj9WUyA9CacANgZykdHGAxORZU
XwlwBAAEkCrvISB4I8BqnRZUTCTDGwAvAGJyCsCOeRlYMHEWVER5bhPAOGljICSxGGEc8GxklGQp
MExQA2BjcCkeGxmyI4A3FlQHwHQtdPZvBvArTzU09QhQAIAG8D5lNZ4jgCEgEwAWxGgtNyjfNIQW
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

------=_NextPart_000_006B_01C11DAD.2D21EBB0--

