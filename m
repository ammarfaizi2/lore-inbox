Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131091AbRA2S57>; Mon, 29 Jan 2001 13:57:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131525AbRA2S5t>; Mon, 29 Jan 2001 13:57:49 -0500
Received: from www.topmail.de ([212.255.16.226]:3559 "HELO www.topmail.de")
	by vger.kernel.org with SMTP id <S131091AbRA2S5g> convert rfc822-to-8bit;
	Mon, 29 Jan 2001 13:57:36 -0500
Message-ID: <016501c08a25$527d2490$0100a8c0@homeip.net>
From: "mirabilos" <eccesys@topmail.de>
To: "Linux-Kernel ML" <linux-kernel@vger.kernel.org>,
        "Andreas Huppert" <Andreas.Huppert@philosys.de>
In-Reply-To: <200101291827.TAA21302@mail.philosys.de>
Subject: Re: dos-partition mount bug
Date: Mon, 29 Jan 2001 18:54:00 -0000
Organization: eccesys.net Linux Distribution Development
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas,

I've checked the bootsector (aka superblock) [i hate od...]
and found no problems. It even gives the right info about
start sector and length (same as fdisk).

Your filesystem seems to be intact, but I'd suggest running
sp^Hcandisk although. Maybe there are other things like a
corrupt FAT the driver complains about.
AFAIK it only ought to complain if the bootsector (BPB and
55AA magic) is corrupt. (Or did so in 2.0.33)

Sorry can't help, seems to be a fs-driver flaw.

-mirabilos

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12+(proprietary extensions) # Updated:20010129 nick=mirabilos
GO/S d@ s--: a--- C++ UL++++ P--- L++$(-^lang) E----(joe) W+(++) loc=.de
N? o K? w-(+$) O+>+++ M-- V- PS+++@ PE(--) Y+ PGP t+ 5? X+ R+ !tv(silly)
b++++* DI- D+ G(>++) e(^age) h! r(-) y--(!y+) /* lang=NASM;GW-BASIC;C */
------END GEEK CODE BLOCK------



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
