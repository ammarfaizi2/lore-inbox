Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264680AbRFYGRP>; Mon, 25 Jun 2001 02:17:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265097AbRFYGRF>; Mon, 25 Jun 2001 02:17:05 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:18310 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S264680AbRFYGQx>; Mon, 25 Jun 2001 02:16:53 -0400
Date: Mon, 25 Jun 2001 00:16:51 -0600
Message-Id: <200106250616.f5P6Gp710044@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: "Gregory T. Norris" <haphazard@socket.net>
Cc: rio500-devel <rio500-devel@lists.sourceforge.net>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] rio500 devfs support
In-Reply-To: <20010624173711.A1764@glitch.snoozer.net>
In-Reply-To: <20010619175224.A1137@glitch.snoozer.net>
	<20010624173711.A1764@glitch.snoozer.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gregory T. Norris writes:
> 
> --qlTNgmc+xy1dBmNv
> Content-Type: multipart/mixed; boundary="0F1p//8PRICkK4MW"
> Content-Disposition: inline

Yuk! MIME!

> --0F1p//8PRICkK4MW
> Content-Type: text/plain; charset=us-ascii
> Content-Disposition: inline
> Content-Transfer-Encoding: quoted-printable

Horrors! Quoted-printables!

> Here's an updated version of the patch - the only real difference is
> that rio500.c will printk an error message if devfs_register() fails.=20
> I left that out originally because devfs logs the error, but it's
> probably a good idea to indicate which driver made the request.

No, it's a bad idea to test the error from devfs_register() unless you
*really* have a good reason. Most people who think they have a good
reason actually don't, they're just confused :-)

The reason you don't want to test the return value is that way the
driver works fine with CONFIG_DEVFS=n. Otherwise, you have a driver
that doesn't work with devfs, or you have to put ugly #ifdef's in the
code.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
