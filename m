Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130126AbRBCPBq>; Sat, 3 Feb 2001 10:01:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130003AbRBCPBi>; Sat, 3 Feb 2001 10:01:38 -0500
Received: from zooty.lancs.ac.uk ([148.88.16.231]:15548 "EHLO
	zooty.lancs.ac.uk") by vger.kernel.org with ESMTP
	id <S130126AbRBCPBU>; Sat, 3 Feb 2001 10:01:20 -0500
Message-Id: <l03130314b6a1cabb7b6b@[192.168.239.105]>
In-Reply-To: <Pine.LNX.4.30.0102031246490.13570-200000@cola.teststation.com>
In-Reply-To: <3A7B599F.18307.47A4F1@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Sat, 3 Feb 2001 14:59:08 +0000
To: Urban Widmark <urban@teststation.com>, <linux-kernel@vger.kernel.org>
From: Jonathan Morton <chromi@cyberspace.org>
Subject: Re: DFE-530TX with no mac address
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>The attached patch for the via-daig program plays with a few registers.
>
>Run it as 'via-diag -aaeemm -I' then do a 'ifconfig eth0 down; ifconfig
>eth0 up' and see if anything happens.

OK, after a little trouble applying the patch, here's what I found:

Starting with the card in working condition, I tried "via-diag -aaeemm -I"
and there was no change in functionality.  Running the ifconfig toggle also
had no overall effect.  Then I tried "via-diag -aaeemm -i" (running a
pinger in another  console) and noted that the pinger stopped working when
the command was run.  However, running "via-diag -aaeemm -I" did not change
that situation.  The ifconfig toggle did correctly restart operation.

Examining the system log after the above showed that at some point during
the sequence the kernel emitted a series of "transmit timed out" log-entry
pairs as shown in my last mail.  Also, I noticed that while running -i the
receive status was listed as "unicast/hashed multicast" and while running
-I the receive status was "unknown/invalid".

Do you want me to try this again, after first setting the card into
non-working condition?

--------------------------------------------------------------
from:     Jonathan "Chromatix" Morton
mail:     chromi@cyberspace.org  (not for attachments)
big-mail: chromatix@penguinpowered.com
uni-mail: j.d.morton@lancaster.ac.uk

The key to knowledge is not to rely on people to teach you it.

Get VNC Server for Macintosh from http://www.chromatix.uklinux.net/vnc/

-----BEGIN GEEK CODE BLOCK-----
Version 3.12
GCS$/E/S dpu(!) s:- a20 C+++ UL++ P L+++ E W+ N- o? K? w--- O-- M++$ V? PS
PE- Y+ PGP++ t- 5- X- R !tv b++ DI+++ D G e+ h+ r- y+
-----END GEEK CODE BLOCK-----


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
