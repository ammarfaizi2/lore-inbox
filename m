Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271742AbRICQCg>; Mon, 3 Sep 2001 12:02:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271741AbRICQC0>; Mon, 3 Sep 2001 12:02:26 -0400
Received: from ns.suse.de ([213.95.15.193]:6671 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S271742AbRICQCU> convert rfc822-to-8bit;
	Mon, 3 Sep 2001 12:02:20 -0400
To: Ben LaHaise <bcrl@redhat.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [resend PATCH] reserve BLKGETSIZE64 ioctl
In-Reply-To: <Pine.LNX.4.33.0109031119400.1610-100000@toomuch.toronto.redhat.com>
X-Yow: I invented skydiving in 1989!
From: Andreas Schwab <schwab@suse.de>
Date: 03 Sep 2001 18:02:38 +0200
In-Reply-To: <Pine.LNX.4.33.0109031119400.1610-100000@toomuch.toronto.redhat.com> (Ben LaHaise's message of "Mon, 3 Sep 2001 11:21:39 -0400 (EDT)")
Message-ID: <jezo8cw9cx.fsf@sykes.suse.de>
User-Agent: Gnus/5.090003 (Oort Gnus v0.03) Emacs/21.0.106
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben LaHaise <bcrl@redhat.com> writes:

|> Hello,
|> 
|> Is there any problem with the patch below for reserving a 64 bit get block
|> device size ioctl?

Yes.

|> diff -urN v2.4.10-pre4/include/linux/fs.h work/include/linux/fs.h
|> --- v2.4.10-pre4/include/linux/fs.h	Mon Sep  3 11:04:39 2001
|> +++ work/include/linux/fs.h	Mon Sep  3 11:18:44 2001
|> @@ -182,7 +182,8 @@
|>  /* This was here just to show that the number is taken -
|>     probably all these _IO(0x12,*) ioctls should be moved to blkpg.h. */
|>  #endif
|> -/* A jump here: 108-111 have been used for various private purposes. */
|> +/* A jump here: 108,109,111 have been used for various private purposes. */
|> +#define BLKBSZGET  _IOR(0x12,110,sizeof(u64))
|>  #define BLKBSZGET  _IOR(0x12,112,sizeof(int))
            ^^^^^^^^^

Conflicting definitions.

Andreas.

-- 
Andreas Schwab                                  "And now for something
Andreas.Schwab@suse.de				completely different."
SuSE Labs, SuSE GmbH, Schanzäckerstr. 10, D-90443 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
