Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275126AbRJJJ3w>; Wed, 10 Oct 2001 05:29:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275139AbRJJJ3m>; Wed, 10 Oct 2001 05:29:42 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:32748 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S275126AbRJJJ3f>; Wed, 10 Oct 2001 05:29:35 -0400
Date: Wed, 10 Oct 2001 11:30:01 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Rasmus Andersen <rasmus@jaquet.dk>
cc: Thomas Hood <jdthood@mail.com>, <linux-kernel@vger.kernel.org>,
        <acme@conectiva.com.br>
Subject: Re: Linux 2.4.10-ac10
In-Reply-To: <20011010110905.A28673@jaquet.dk>
Message-ID: <Pine.NEB.4.40.0110101129440.28306-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Oct 2001, Rasmus Andersen wrote:

> On Wed, Oct 10, 2001 at 10:47:40AM +0200, Adrian Bunk wrote:
> [...]
> >
> > Yes, that was it. Sound works again for me after I've reversed the
> > attached patch to drivers/sound/ad1816.c.
>
> [...]
>
> >
> > -	if (check_region (io_base, 16)) {
> > -		printk ("ad1816: I/O port 0x%03x not free\n", io_base);
> > -		return 0;
> > +	if (request_region(io_base, 16, "AD1816 Sound")) {
> > +		printk(KERN_WARNING "ad1816: I/O port 0x%03x not free\n",
> > +				    io_base);
> > +		goto err;
> >  	}
> >
>
> Would you mind trying with a '!' in front of the request_region call?


Thanks, this fixed it!


> Regards,
>   Rasmus

cu
Adrian

-- 

Get my GPG key: finger bunk@debian.org | gpg --import

Fingerprint: B29C E71E FE19 6755 5C8A  84D4 99FC EA98 4F12 B400

