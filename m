Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266101AbSL3DOY>; Sun, 29 Dec 2002 22:14:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266108AbSL3DOY>; Sun, 29 Dec 2002 22:14:24 -0500
Received: from eriador.apana.org.au ([203.14.152.116]:48144 "EHLO
	eriador.apana.org.au") by vger.kernel.org with ESMTP
	id <S266101AbSL3DOX>; Sun, 29 Dec 2002 22:14:23 -0500
From: Herbert Xu <herbert@gondor.apana.org.au>
To: jwbaker@acm.org (Jeffrey Baker), linux-kernel@vger.kernel.org
Subject: Re: 2.4.20 oops mounting iso9660 fs as hfs
In-Reply-To: <20021230005457.GA15680@noodles>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.5.14-20020917 ("Chop Suey!") (UNIX) (Linux/2.4.20-686-smp (i686))
Message-Id: <E18SqVf-0005xV-00@gondolin.me.apana.org.au>
Date: Mon, 30 Dec 2002 14:22:35 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeffrey Baker <jwbaker@acm.org> wrote:
> Using kernel 2.4.20 on ix86 and an HP IEEE1394 DVD+RW drive, I
> encountered this BUG/oops when attempting to mount a CD-ROM.  I at
> first could not mount the disc, so I attempted to mount it as HFS:

HFS wants 512 blocks while sr sets hardsect size to 2048.  You can
work around it by reading it via loopback (losetup or mount -o loop).
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
