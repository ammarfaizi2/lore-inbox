Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289789AbSAJXx0>; Thu, 10 Jan 2002 18:53:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289791AbSAJXxQ>; Thu, 10 Jan 2002 18:53:16 -0500
Received: from nick.dcs.qmul.ac.uk ([138.37.88.61]:14034 "EHLO
	nick.dcs.qmul.ac.uk") by vger.kernel.org with ESMTP
	id <S289789AbSAJXxG>; Thu, 10 Jan 2002 18:53:06 -0500
Date: Thu, 10 Jan 2002 23:53:05 +0000 (GMT)
From: Matt Bernstein <matt@theBachChoir.org.uk>
To: Andrew Morton <akpm@zip.com.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: oops with 2.4.17 + mini-ll patch
In-Reply-To: <3C3DFF76.2DA2F5BD@zip.com.au>
Message-ID: <Pine.LNX.4.43.0201102337330.28463-100000@nick.dcs.qmul.ac.uk>
X-URL: http://www.theBachChoir.org.uk/
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 12:54 -0800 Andrew Morton wrote:

>> Dual PIII 1GHz, modular everything inc. ATA/IDE (VIA); SCSI (gdth.o);
>> NFSv3 (udp, client only); autofs4; ext2 only for local fs. Debian woody.
>
>It could be a timer deletion race.  There are still zillions of these,
>but nobody ever encounters them

This was the second oops the kernel produced--it wasn't syncing so I
copied it from the screen. The first one I didn't record as I'd thought it
might be related to a power surge we had.

>What was the system doing at the time?  Do you think a module could
>have been in the process of unloading?  autofs unmount, something
>like that?

Hmm.. I don't think modules were unloading, though it's very possible that
usage counts were going down for exactly that sort of reason. The first
oops occurred within minutes of system boot; the second was a few hours. I
think the common element might have been mildly high system load--this
machine is used by a PhD student running models on a mysql database on
the SCSI system.

Anyway, it's gone back to 2.4.9-ac18 now which it was running happily
until the power problems. I do have two other machines with the exact same
2.4.17 build (but different initrds) which both auto{,u}mount a lot more
than the problem box, but they have other differences (no SCSI, different
VIA IDE chipset..)

Cheers though,

Matt

