Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130389AbRAOKaL>; Mon, 15 Jan 2001 05:30:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130400AbRAOKaB>; Mon, 15 Jan 2001 05:30:01 -0500
Received: from big-relay-1.ftel.co.uk ([192.65.220.123]:9867 "EHLO
	old-callisto.ftel.co.uk") by vger.kernel.org with ESMTP
	id <S130389AbRAOK3n>; Mon, 15 Jan 2001 05:29:43 -0500
Date: Mon, 15 Jan 2001 10:29:18 GMT
Message-Id: <200101151029.f0FATI714630@old-callisto.ftel.co.uk>
From: Paul Flinders <P.Flinders@ftel.co.uk>
To: "David D.W. Downey" <pgpkeys@hislinuxbox.com>
Cc: Tony Parsons <mpsons@cix.compulink.co.uk>, linux-kernel@vger.kernel.org
Subject: Re: ide.2.4.1-p3.01112001.patch
In-Reply-To: <Pine.LNX.4.21.0101140010470.17798-100000@ns-01.hislinuxbox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


"David D.W. Downey" <pgpkeys@hislinuxbox.com> writes:

> Good! I'm not the only ome getting this error! Mine is also a VT82C686
> though mine is a VT82C686A (352 BGA). This is on an MSI Model 694D Pro
> motherboard running dual PIII-733 FC-PGA 133MHz Coppermines. RAM is 4
> 256MB PC133 unbuffered 7ns non mixed-cell DIMMs. I bring up the RAM and
> CPU info because this board is also giving me random SIG11 errors even
> though all equipment passes lab testing.
>
> ..... 
>
> Anyone else out there with troubles with either of these 3 items?

I've got two 694D Pro's (the AIR variant) and at the moment I'm not
especially happy with them - whether it's Linux, the boards or a
combination of both I don't know. Problems so far have been

  - With disks on the Promise controller I have to disable the
    M/B sound or Linux (everything from 2.2.14(RH 6.2) up to
    2.4.0-ac4) hangs when probing the IDE interfaces. The sound
    shares the PCI IRO line with the Promise.

    With no disks on the Promise I can leave the sound enabled

  - I get the same CRC errors when I move the disks (Maxtor 33073H3's)
    to the VIA interfaces (ATA/66).

  - 2.4.0-ac8 gives errors on /dev/md1 (S/W RAID-1 pair) on boot (and
    then panics as /dev/md1 is the root fs), 2.2.x is happy with the 
    mirror. I'm not sure whether this is a 2.4.0 problem, one
    introduced by Alan or hardware because I'm lucky to get a kernel
    compile without the thing OOPSing on me.

My set-up is similar to David's except that I have 2x866 PIII FC-PGAs,
If I can figure out whether some of the problems are hardware (we have
4 of these boards two were to have Linux, one one of the BSDs and one
W2k so we should be able to spot problems that are common to all the
OSes) I'll send some better bug reports.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
