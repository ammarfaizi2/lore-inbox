Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129345AbQLKGse>; Mon, 11 Dec 2000 01:48:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129387AbQLKGsY>; Mon, 11 Dec 2000 01:48:24 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:41229 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S129345AbQLKGsH>; Mon, 11 Dec 2000 01:48:07 -0500
Date: Mon, 11 Dec 2000 00:17:23 -0600
To: Anthony Barbachan <barbacha@Hinako.AMBusiness.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Unable to compile the 2.2.18 kernel
Message-ID: <20001211001723.Z6567@cadcamlab.org>
In-Reply-To: <001f01c06323$db434d00$0ac809c0@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <001f01c06323$db434d00$0ac809c0@hotmail.com>; from barbacha@Hinako.AMBusiness.com on Sun, Dec 10, 2000 at 10:38:41PM -0500
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Anthony Barbachan]
> I am unable to compile the latest kernel.  I have attached my kernel
> configuration and a copy of the output of where the compile fails.  I
> am looking into what is causing the compile failure, but have not
> been able to figure it out yet.  Still looking though.

It looks like you overrode the 'CC' make variable, either by editing
the toplevel Makefile or at the command line.  This works fine in 2.4,
but in 2.2 you need to pass extra flags to the compiler:

  make zImage CC="/usr/local/gcc-2.7.2.3/bin/gcc -I$(pwd)/include -D__KERNEL__"

...for example.

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
