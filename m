Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266678AbSL3EFB>; Sun, 29 Dec 2002 23:05:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266686AbSL3EFB>; Sun, 29 Dec 2002 23:05:01 -0500
Received: from eriador.apana.org.au ([203.14.152.116]:44561 "EHLO
	eriador.apana.org.au") by vger.kernel.org with ESMTP
	id <S266678AbSL3EFA>; Sun, 29 Dec 2002 23:05:00 -0500
Date: Mon, 30 Dec 2002 15:13:07 +1100
To: Jeffrey Baker <jwbaker@acm.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20 oops mounting iso9660 fs as hfs
Message-ID: <20021230041307.GA23543@gondor.apana.org.au>
References: <20021230005457.GA15680@noodles> <E18SqVf-0005xV-00@gondolin.me.apana.org.au> <20021230040402.GA680@heat>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021230040402.GA680@heat>
User-Agent: Mutt/1.4i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 29, 2002 at 08:04:02PM -0800, Jeffrey Baker wrote:
> 
> > HFS wants 512 blocks while sr sets hardsect size to 2048.  You can
> > work around it by reading it via loopback (losetup or mount -o loop).
> 
> Do you mean make an image of the CD with dd and mount it
> with loopback?  That sounds like it would work fine.

It's easier that.

losetup /dev/loop0 /dev/cdrom
mount -rt hfs /dev/loop0 /mnt
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
