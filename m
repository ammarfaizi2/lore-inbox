Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130753AbQK2Xtr>; Wed, 29 Nov 2000 18:49:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132209AbQK2Xth>; Wed, 29 Nov 2000 18:49:37 -0500
Received: from mail11.voicenet.com ([207.103.0.37]:14007 "HELO voicenet.com")
        by vger.kernel.org with SMTP id <S130753AbQK2XtW>;
        Wed, 29 Nov 2000 18:49:22 -0500
Date: Wed, 29 Nov 2000 18:18:39 -0500
From: safemode <safemode@voicenet.com>
To: Marc Mutz <Marc@Mutz.com>
Cc: Adam <adam@cfar.umd.edu>, linux-kernel@vger.kernel.org
Subject: Re: 'holey files' not holey enough.
Message-ID: <20001129181839.I1217@psuedomode>
In-Reply-To: <Pine.GSO.4.21.0011290755570.2862-100000@chia.umiacs.umd.edu> <3A2584DC.1699B6CD@Mutz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <3A2584DC.1699B6CD@Mutz.com>; from Marc@Mutz.com on Wed, Nov 29, 2000 at 17:36:12 -0500
X-Mailer: Balsa 1.0.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 29 Nov 2000 17:36:12 Marc Mutz wrote:
> kernel 2.2.17, '/' being a 1k blocksize ext2fs:
> 
> root@adam:/ > dd if=/dev/zero of=holed.file bs=1000 seek=5000 count=1000
> 1000+0 records in
> 1000+0 records out
> root@adam:/ > ls -l holed.file
> -rw-r--r--   1 root     root      6000000 Nov 29 23:33 holed.file
> root@adam:/ > du -sh holed.file
> 5.7M    holed.file
> 
> Now that seems funny.

why is 5.7MB funny with 6000000 bytes ?   or are you talking about
something else?  Don't forget that BYTES and thus MEGABYTES are found by
powers of 2.  They do not function like the decimal "bits".  quick way to
do the conversion is divide bytes by 1024 to get Kilobytes and then again
by 1024 to get Megabytes.  This is how it should be displayed.   Or am i
missing the point of your comment?


> Marc
> 
> -- 
> Marc Mutz <Marc@Mutz.com>     http://EncryptionHOWTO.sourceforge.net/
> University of Bielefeld, Dep. of Mathematics / Dep. of Physics
> 
> PGP-keyID's:   0xd46ce9ab (RSA), 0x7ae55b9e (DSS/DH)
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
