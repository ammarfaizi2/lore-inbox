Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136581AbREGSfJ>; Mon, 7 May 2001 14:35:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136597AbREGSfA>; Mon, 7 May 2001 14:35:00 -0400
Received: from libra.cus.cam.ac.uk ([131.111.8.19]:61612 "EHLO
	libra.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S136581AbREGSeq>; Mon, 7 May 2001 14:34:46 -0400
Message-Id: <5.1.0.14.2.20010507185638.00a91520@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 07 May 2001 19:35:23 +0100
To: Linus Torvalds <torvalds@transmeta.com>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: [PATCH] x86 page fault handler not interrupt safe
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Brian Gerst <bgerst@didntduck.org>,
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0105071003330.12733-100000@penguin.transmeta
 .com>
In-Reply-To: <E14wmbg-0003b3-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 18:12 07/05/2001, Linus Torvalds wrote:
>Untested.
>
>In particular, does anybody have a buggy Pentium to test with the F0 0F
>lock-up bug?

Yes, I have one. 2.4.3-ac6 (plus a few patches) detects the bug on boot up 
and enables the work around. Running the f00f test program from SGI results 
in the correct behaviour of a SIGILL signal being sent to the program.

>If anybody has such a beast, please try this kernel patch _and_ running

Oh my, I always considered it as a cute, fluffy bunny. No need to 
bestialize it unnecessarily... (-;

>the F0 0F bug-producing program (search for it on the 'net - it must be
>out there somewhere) to verify that the code still correctly handles that
>case.

Am compiling 2.4.5-pre1 with your patch (manually applied as parts of it 
were already in .5-pre1) right now. I will follow-up with results when it 
has finished and I have tested it (i.e. don't hold your breath, it might be 
a beast but it is a slow one...)

Best regards,

Anton


-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://sourceforge.net/projects/linux-ntfs/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

