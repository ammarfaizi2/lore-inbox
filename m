Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262458AbRENUFc>; Mon, 14 May 2001 16:05:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262459AbRENUFW>; Mon, 14 May 2001 16:05:22 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:22203 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S262458AbRENUFI>;
	Mon, 14 May 2001 16:05:08 -0400
Message-ID: <3B003A6B.69C6D126@mandrakesoft.com>
Date: Mon, 14 May 2001 16:04:59 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@transmeta.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>, viro@math.psu.edu
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: <3B002FC6.C0093C18@transmeta.com> <3B0033A4.8BB96F43@mandrakesoft.com> <3B0038B3.EBB9747A@transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" wrote:
> Jeff Garzik wrote:
> > Register block device using existing API, and obtain a dynamically
> > assigned major number.  Export a tiny ramfs which lists all device
> > nodes.  Mounted on /dev/snap, /dev/snap/0 would be the first blkdev for
> > snap's dynamically assigned major.  (Al Viro said he has skeleton code
> > to create such an fs, IIRC)

> It does, however, not manage permissions, nor does it provide for a sane
> namespace (it exposes too many internal implementation details in the
> interface -- in particular, the driver becomes part of the namespace, and
> devices move around between drivers regularly.)

True -- that capability is provided by devfs+devfsd, which is supported
in the driver by using the existing 2.4 devfs hooks.  For that case one
would not mount the driver's devfs.

I look at it as an effective transition mechanism.  Device numbers are
frozen now, but devfs is not deployed now.  My solution gets us from
point A to point B, and is IMHO workable in the stable 2.4 series.  We
can go 100% devfs or whatever in 2.5 or 3.0..

Regards,

	Jeff


-- 
Jeff Garzik      | Game called on account of naked chick
Building 1024    |
MandrakeSoft     |
