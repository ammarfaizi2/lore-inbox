Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262634AbRFQSoN>; Sun, 17 Jun 2001 14:44:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262622AbRFQSoD>; Sun, 17 Jun 2001 14:44:03 -0400
Received: from p1.nas4.is5.u-net.net ([195.102.201.129]:46832 "EHLO
	keston.u-net.com") by vger.kernel.org with ESMTP id <S262616AbRFQSnp>;
	Sun, 17 Jun 2001 14:43:45 -0400
Message-ID: <017601c0f75d$454c6e70$1901a8c0@node0.idium.eu.org>
From: "David Flynn" <Dave@keston.u-net.com>
To: "David Flynn" <Dave@keston.u-net.com>,
        "linux kernel mailinglist" <linux-kernel@vger.kernel.org>
In-Reply-To: <00f501c0f74e$defac4e0$1901a8c0@node0.idium.eu.org>
Subject: Re: [slightly OT] IDE problems ? or just a dead disk ?
Date: Sun, 17 Jun 2001 19:42:33 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
X-MDRemoteIP: 192.168.0.50
X-Return-Path: Dave@keston.u-net.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> hi guys,
>         Since its relativley quiet at the moment, please excuse me for
> asking for some advice about the following problem.
>

i dont usually like following up my own sensless ramblings, but here is an
interesting twist (probabally caused by my ill understanding of the issues
involved)

ive done the badblock test, and compiled a list of 2302 bad blocks on this
disk ... however, when running mke2fs -l badblocfile /dev/hdc1

i got this interesting errormessage for every one of the bad blocks :

Bad block 1006290 out of range; ignored.

mke2fs said my disk was my disk would be 132480 inodes, 264592 blocks in
size ...

some bits in proc (well this capacity one i dont know what it measures)

root:/root# cat /proc/ide/hdc/capacity
2116800

root:/root# cat /proc/ide/hdc/geometry
physical     2100/16/63
logical      525/64/63

is there a geometry problem ? whats causing bad blocks to give apparently
excessivly large bad blocks ...?

any ideas ?

Thanks,

Dave

> for a while now ive had a disk that causes errors to occur during reads,
> however, ive finally got round to doing a
>
> # badblocks -c 32 -o mybadblocks  -w -v -s /dev/hdc
>
> so after one part of the test its found 2048 bad blocks, and dumped alot
of
> error messages, which look like this:
>
> kernel: hdc: read_intr: status=0x59 { DriveReady SeekComplete DataRequest
> Error }
> kernel: hdc: read_intr: error=0x01 { AddrMarkNotFound }, LBAsect=2116604,
> sector=2116604
> kernel: hdc: read_intr: status=0x59 { DriveReady SeekComplete DataRequest
> Error }
> kernel: hdc: read_intr: error=0x01 { AddrMarkNotFound }, LBAsect=2116604,
> sector=2116604
> kernel: hdc: read_intr: status=0x59 { DriveReady SeekComplete DataRequest
> Error }
> kernel: hdc: read_intr: error=0x01 { AddrMarkNotFound }, LBAsect=2116604,
> sector=2116604
> kernel: ide1: reset: success
> kernel: hdc: read_intr: status=0x59 { DriveReady SeekComplete DataRequest
> Error }
> kernel: hdc: read_intr: error=0x01 { AddrMarkNotFound }, LBAsect=2116604,
> sector=2116604
> kernel: end_request: I/O error, dev 16:00 (hdc), sector 2116604
> kernel: hdc: read_intr: status=0x59 { DriveReady SeekComplete DataRequest
> Error }
> kernel: hdc: read_intr: error=0x40 { UncorrectableError },
LBAsect=2116607,
> sector=2116607
> kernel: end_request: I/O error, dev 16:00 (hdc), sector 2116607
> kernel: hdc: read_intr: status=0x59 { DriveReady SeekComplete DataRequest
> Error }
> kernel: hdc: read_intr: error=0x40 { UncorrectableError },
LBAsect=2116608,
> sector=2116608
> kernel: end_request: I/O error, dev 16:00 (hdc), sector 2116608
> kernel: hdc: read_intr: status=0x59 { DriveReady SeekComplete DataRequest
> Error }
> kernel: hdc: read_intr: error=0x40 { UncorrectableError },
LBAsect=2116610,
> sector=2116610
>
> i have tried the disk in 2 systems, one Socket7 pentium and a PII /w a BX
> chipset ... the only thing i can think this is is either a geometry
problem
> ?? or a hard disk failiure ...
>
> anyone got any ideas ?
>
> Thanks.
>
> Dave
>


