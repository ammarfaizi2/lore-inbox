Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281719AbRKQWMA>; Sat, 17 Nov 2001 17:12:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281728AbRKQWLl>; Sat, 17 Nov 2001 17:11:41 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:58128 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S281719AbRKQWL0>; Sat, 17 Nov 2001 17:11:26 -0500
Message-ID: <3BF6E039.923E0577@zip.com.au>
Date: Sat, 17 Nov 2001 14:10:01 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.14-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Mike Fedyk <mfedyk@matchmail.com>
CC: Jamie Lokier <lk@tantalophile.demon.co.uk>,
        "Theodore Ts'o" <tytso@mit.edu>, Brian <hiryuu@envisiongames.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andreas Dilger <adilger@turbolabs.com>
Subject: Re: File server FS?
In-Reply-To: <200111132203.fADM3jW03006@demai05.mw.mediaone.net> <20011113175348.B24864@mikef-linux.matchmail.com> <20011117181253.B5003@kushida.jlokier.co.uk>,
		<20011117181253.B5003@kushida.jlokier.co.uk> <20011117135542.H21354@mikef-linux.matchmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Fedyk wrote:
> 
> I haven't actually resized any ext2/3 partitions.  Didn't need to.  I'll do
> some tests though.

I tested it a while back - it worked OK.  If you could retest that'd be
neat.

The journal shouldn't be affected - it's just a regular file.

mke2fs and tune2fs choose an initial journal size based
on the size of the fs, so if you were increasing the
fs size by a large ratio then there may be a case for
increasing the journal size.  But as you've pointed out,
an 8, 16 or 32 megabyte journal covers an awful lot of metadata.
