Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292855AbSCTVuF>; Wed, 20 Mar 2002 16:50:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312235AbSCTVt4>; Wed, 20 Mar 2002 16:49:56 -0500
Received: from ns01.passionet.de ([62.153.93.33]:25492 "HELO
	mail.cgn.kopernikus.de") by vger.kernel.org with SMTP
	id <S292855AbSCTVtt>; Wed, 20 Mar 2002 16:49:49 -0500
Date: Wed, 20 Mar 2002 22:49:42 +0100
From: Manon Goo <manon@manon.de>
Reply-To: Manon Goo <manon@manon.de>
To: "Cameron, Steve" <Steve.Cameron@COMPAQ.com>, linux-kernel@vger.kernel.org
Subject: RE: Hooks for random device entropy generation missing incpqarray.c
Message-ID: <288638.1016664582@eva.dhcp.gimlab.org>
In-Reply-To: <45B36A38D959B44CB032DA427A6E10640167CF88@cceexc18.americas.cpqcorp.net>
X-Mailer: Mulberry/2.2.0b3 (Mac OS X)
X-manon-file: sentbox
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="==========00319710=========="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--==========00319710==========
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

I have not tried your patch.  but this is in cpqarray_init() and it is only =

called when the driver is initilaized.
How is the entropy-pool further updated ?

Thanks

Manon



--On Mittwoch, 20. M=E4rz 2002 15:37 Uhr -0600 "Cameron, Steve"=20
<Steve.Cameron@COMPAQ.com> wrote:

>
>> excuse me I am using 2.4.18
>>
>
> Ok.  If SA_SAMPLE_RANDOM is not in
> the call to request_irq, you can put
> it in.  A trivial (but untested) patch:
> (if outlook doesn't mangle it)
>
> -- steve
>
> --- cpqarray.c.orig	Wed Mar 20 15:25:51 2002
> +++ cpqarray.c	Wed Mar 20 15:26:30 2002
> @@ -516,8 +516,9 @@
>
>  	
>  	hba[i]->access.set_intr_mask(hba[i], 0);
> -	if (request_irq(hba[i]->intr, do_ida_intr,
> -		SA_INTERRUPT|SA_SHIRQ, hba[i]->devname, hba[i]))
> +	if (request_irq(hba[i]->intr, do_ida_intr,
> +		SA_SAMPLE_RANDOM|SA_INTERRUPT|SA_SHIRQ,
> +		hba[i]->devname, hba[i]))
>  	{
>
>  		printk(KERN_ERR "cpqarray: Unable to get irq %d for %s\n",
>
>


--==========00319710==========
Content-Type: application/pgp-signature
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (Darwin)
Comment: For info see http://www.gnupg.org

iD8DBQE8mQP3lp/TJR6NORURAtQkAJ9pF/LuuPgNXXL7CW1gIdQsJ165PQCgossY
JkQxN5YVD9FcFJjd6otl2u0=
=sywf
-----END PGP SIGNATURE-----

--==========00319710==========--

