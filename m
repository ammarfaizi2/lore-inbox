Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131350AbQKNVhd>; Tue, 14 Nov 2000 16:37:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131095AbQKNVhX>; Tue, 14 Nov 2000 16:37:23 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:36619 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S131350AbQKNVhU>;
	Tue, 14 Nov 2000 16:37:20 -0500
Message-ID: <3A11A967.A2EA6D20@mandrakesoft.com>
Date: Tue, 14 Nov 2000 16:06:47 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: scole@lanl.gov
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] CONFIG_EISA note in Documentation/Configure.help
In-Reply-To: <00111413485901.03227@spc.esa.lanl.gov>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Cole wrote:
> Well, the CONFIG_EISA option is there.  My little patch was just intended to
> slightly enlighten those prone to "lets see what this option does".  I
> compiled test11-pre4 both with and without CONFIG_EISA and the difference is
> very slight.  Of course, if you had more items with EISA code, this difference
> would be bigger.
> 
>  848 -rw-r--r--    1 root     root       868179 Nov 14 13:32 bzImage
>  848 -rw-r--r--    1 root     root       867973 Nov 14 13:28 bzImage.no_eisa
> 
> The difference probably comes from my 3c59x driver.
> 
> I also uglied up the 3c59x.c code with #ifdef CONFIG_EISA around the
> six sections relavant to EISA to see if that would save anything, and the
> object file was only 318 bytes smaller, probably not worth the uglyness of
> the six ifdefs.  That modified code was not used in the above comparison.

When !CONFIG_EISA, the global variable 'EISA_bus' is unconditionally
zero.  Therefore you merely need to test EISA_bus, as existing code
already should be doing..  As for 3c59x patches, they should go to the
maintainer, Andrew Morton..

	Jeff


-- 
Jeff Garzik             |
Building 1024           | The chief enemy of creativity is "good" sense
MandrakeSoft            |          -- Picasso
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
