Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263107AbUAUMRH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 07:17:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263178AbUAUMRH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 07:17:07 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:2802 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id S263107AbUAUMRD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 07:17:03 -0500
Date: Wed, 21 Jan 2004 23:13:26 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Dave Jones <davej@redhat.com>
Cc: antispam@absamail.co.za, linux-kernel@vger.kernel.org
Subject: Re: [2.6.1 MCE falseness?] Hardware reports non-fatal error
Message-Id: <20040121231326.3acd3823.sfr@canb.auug.org.au>
In-Reply-To: <20040118020301.GA8621@redhat.com>
References: <1074390255.8198.22.camel@ksyrium.local>
	<20040118020301.GA8621@redhat.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Wed__21_Jan_2004_23_13_26_+1100_ei/zhp0rh0YvqfQu"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Wed__21_Jan_2004_23_13_26_+1100_ei/zhp0rh0YvqfQu
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Sun, 18 Jan 2004 02:03:01 +0000 Dave Jones <davej@redhat.com> wrote:
>
> On Sun, Jan 18, 2004 at 03:44:16AM +0200, Niel Lambrechts wrote:
> 
>  > I get the following problem with 2.6.1 consistently after apm resuming:
>  > "ksyrium kernel: MCE: The hardware reports a non fatal, correctable
>  > incident occurred on CPU 0.
>  > 
>  > Message from syslogd@ksyrium at Wed Jan 14 13:33:06 2004 ...
>  > ksyrium kernel: Bank 1: f2000000000001c5"
> 
> As it only happens when you resume from APM, I'm inclined to believe
> its a BIOS bug.  With the output of dmidecode, we could blacklist this
> box to not do the nonfatal checking.

My Thinkpad T22 produces a similar warning on resume using APM:

kernel: MCE: The hardware reports a non fatal, correctable incident occurred on CPU 0.
kernel: Bank 1: f200000000000104

dmidecode output starts with:

# dmidecode 2.3
SMBIOS 2.3 present.
46 structures occupying 1585 bytes.
Table at 0x1FFF0000.
Handle 0x0000
        DMI type 0, 20 bytes.
        BIOS Information
                Vendor: IBM
                Version: 16ET31WW (1.11 )
                Release Date: 03/20/2003
	.
	.
Handle 0x0001
        DMI type 1, 25 bytes.
        System Information
                Manufacturer: IBM
                Product Name: 26475EA

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__21_Jan_2004_23_13_26_+1100_ei/zhp0rh0YvqfQu
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFADmzmFG47PeJeR58RAoG+AJ95yCcVVQRGvkfJTiY7HMwuhVO3ygCfW2+m
DOyamOoPsEhYuII8YRDgx0o=
=yaTi
-----END PGP SIGNATURE-----

--Signature=_Wed__21_Jan_2004_23_13_26_+1100_ei/zhp0rh0YvqfQu--
