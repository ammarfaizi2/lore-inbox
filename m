Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281827AbRK0RmZ>; Tue, 27 Nov 2001 12:42:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282178AbRK0RmQ>; Tue, 27 Nov 2001 12:42:16 -0500
Received: from nydalah028.sn.umu.se ([130.239.118.227]:5504 "EHLO
	x-files.giron.wox.org") by vger.kernel.org with ESMTP
	id <S281827AbRK0RmI>; Tue, 27 Nov 2001 12:42:08 -0500
Message-ID: <007d01c1776a$d11d4680$0201a8c0@HOMER>
From: "Martin Eriksson" <nitrax@giron.wox.org>
To: "Matthias Andree" <matthias.andree@stud.uni-dortmund.de>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <tgpu68gw34.fsf@mercury.rus.uni-stuttgart.de> <20011125221418.A9672@weta.f00f.org> <0111261159080F.02001@localhost.localdomain> <20011127173904.C13416@emma1.emma.line.org>
Subject: Re: Journaling pointless with today's hard disks?
Date: Tue, 27 Nov 2001 18:42:00 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message -----
From: "Matthias Andree" <matthias.andree@stud.uni-dortmund.de>
To: <linux-kernel@vger.kernel.org>
Sent: Tuesday, November 27, 2001 5:39 PM
Subject: Re: Journaling pointless with today's hard disks?


<snip>
>
> Two things:
>
> 1- power loss. Fixing things to write to disk is bound to fail in
>    adverse conditions. If the drive suffers from write problems and the
>    write    takes longer than the charge of your capacitor lasts, your
>    data is still toasted. nonvolatile memory with finite write time
>    (like NVRAM/Flash) will help to save the Cache. I don't think vendors
>    will do that soon.
>
> 2- error handling with good power: with automatic remapping turned on,
>    there's no problem, the drive can re-write a block it has taken
>    responsibility of, IBM DTLA drives will automatically switch off the
>    write cache when the number of spare block gets low.
>
>    with automatic remapping turned off, write errors with enabled write
>    cache get a real problem because the way it is now, when the drive
>    reports the problem, the block has already expired from the write
>    queue and is no longer available to be rescheduled. That may mean
>    that although fsync() completed OK your block is gone.

I think we have gotten away from the original subject. The problem (as I
understood it) wasn't that we don't have time to write the whole cache...
the problem is that the hard disk stops in the middle of a write, not
updating the CRC of the sector, thus making it report as a bad sector when
trying to recover from the failure. No?

I think most people here are convinced that there is not time to write a
several-MB (worst case) cache to the platters in case of a power failure.
Special drives for this case could of course be manufactured, and here's for
a theory of mine: Wouldn't a battery backed-up SRAM cache do the thing?

Anyway, maybe it is just me who have been thrown off-track? Are we
discussing something else now maybe?

<snap>

_____________________________________________________
|  Martin Eriksson <nitrax@giron.wox.org>
|  MSc CSE student, department of Computing Science
|  Umeå University, Sweden


