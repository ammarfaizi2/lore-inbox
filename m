Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129507AbQKNVT2>; Tue, 14 Nov 2000 16:19:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131469AbQKNVTS>; Tue, 14 Nov 2000 16:19:18 -0500
Received: from tstac.esa.lanl.gov ([128.165.46.3]:28171 "EHLO
	tstac.esa.lanl.gov") by vger.kernel.org with ESMTP
	id <S129507AbQKNVTC>; Tue, 14 Nov 2000 16:19:02 -0500
From: Steven Cole <scole@lanl.gov>
Reply-To: scole@lanl.gov
Date: Tue, 14 Nov 2000 13:48:59 -0700
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] CONFIG_EISA note in Documentation/Configure.help
MIME-Version: 1.0
Message-Id: <00111413485901.03227@spc.esa.lanl.gov>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
>
>Agreed, for the most part.  If you know for sure you don't have an EISA
>machine, you can now disable CONFIG_EISA.  IMHO ideally one should be
>able to eliminate code that is useless on all but a small subset of
>working machines.

Well, the CONFIG_EISA option is there.  My little patch was just intended to 
slightly enlighten those prone to "lets see what this option does".  I 
compiled test11-pre4 both with and without CONFIG_EISA and the difference is
very slight.  Of course, if you had more items with EISA code, this difference
would be bigger.

 848 -rw-r--r--    1 root     root       868179 Nov 14 13:32 bzImage
 848 -rw-r--r--    1 root     root       867973 Nov 14 13:28 bzImage.no_eisa

The difference probably comes from my 3c59x driver.

I also uglied up the 3c59x.c code with #ifdef CONFIG_EISA around the
six sections relavant to EISA to see if that would save anything, and the
object file was only 318 bytes smaller, probably not worth the uglyness of
the six ifdefs.  That modified code was not used in the above comparison.

I am running that modified code right now, BTW.

Jeff, I can send you the patch for the hacked up 3c59x.c if you're at all 
interested.

Steven
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
