Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269391AbRHRXg6>; Sat, 18 Aug 2001 19:36:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269395AbRHRXgt>; Sat, 18 Aug 2001 19:36:49 -0400
Received: from mercury.is.co.za ([196.4.160.222]:54027 "HELO mercury.is.co.za")
	by vger.kernel.org with SMTP id <S269391AbRHRXg3>;
	Sat, 18 Aug 2001 19:36:29 -0400
Date: Sun, 19 Aug 2001 01:35:59 +0200
From: Dewet Diener <linux-kerneldewet.org@darkwing.flatlit.net>
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org, ext3-users@redhat.com
Subject: Re: ext3 partition unmountable
Message-ID: <20010819013559.A26332@darkwing.flatlit.net>
In-Reply-To: <20010818030321.A11649@darkwing.flatlit.net> <3B7EEC4C.D0127AB4@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B7EEC4C.D0127AB4@zip.com.au>; from akpm@zip.com.au on Sat, Aug 18, 2001 at 03:29:32PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 18, 2001 at 03:29:32PM -0700, Andrew Morton wrote:
> Could you please run
> 
> 	 od -A x -t x1 /dev/hdd1
> 
> and send the output?
Here's mine:

000400 c0 5b 0e 81 de ab 1c 00 fe 6e 01 00 2c fa 13 00
000410 1d 36 0e 00 00 00 02 00 02 00 02 00 02 00 00 80
000420 00 80 00 80 00 80 00 20 60 3f 00 00 a3 56 7f 7f
000430 b6 56 7d 3b 0c 00 15 80 53 ef 00 00 01 00 01 81
000440 53 99 48 7b 00 4e ed 00 00 00 01 00 01 00 00 00
000450 00 00 08 00 0b 00 00 00 80 00 00 00 00 00 02 00
000460 02 00 01 00 01 00 e8 00 e8 00 3c 8f 15 e9 42 00
000470 a9 5c fe bf ec a6 84 ef 00 00 00 00 00 00 00 00
000480 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

> For the superblock I get:
> 
> 000400 c0 74 07 00 e2 e8 0e 00 d8 be 00 00 e1 8c 0e 00
> 000410 b5 74 07 00 00 00 00 00 02 00 00 00 02 00 00 00
> 000420 00 80 00 00 00 80 00 00 a0 3f 00 00 2f e9 7e 3b
> 000430 2f e9 7e 3b 01 00 16 00 53 ef 01 00 01 00 00 00
> 000440 1f e9 7e 3b 00 4e ed 00 00 00 00 00 01 00 00 00
> 000450 00 00 00 00 0b 00 00 00 80 00 00 00 04 00 00 00
> 000460 06 00 00 00 01 00 00 00 b9 d3 6c 59 2d cc 42 13
> 000470 91 84 d4 7b 60 d2 d9 50 00 00 00 00 00 00 00 00
> 000480 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 
> The incompat features are at superblock offset 0x60.
> So here it's 0x00000006 - EXT3_FEATURE_INCOMPAT_FILETYPE
> and EXT3_FEATURE_INCOMPAT_RECOVER.

So, mine's 0x00010002 - EXT3_FEATURE_INCOMPAT_FILETYPE, as well as
the undefined bit?

> Somehow you seem to have set bit 16, which isn't defined.  Not sure how
> to fix this without simply running a binary editor against /dev/hdd1 and
> clearing the byte at offset 0x462.

I will certainly give that a try...

Dewet
