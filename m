Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281533AbRLDSff>; Tue, 4 Dec 2001 13:35:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283234AbRLDSeG>; Tue, 4 Dec 2001 13:34:06 -0500
Received: from t2.redhat.com ([199.183.24.243]:58096 "EHLO
	dhcp-177.hsv.redhat.com") by vger.kernel.org with ESMTP
	id <S283221AbRLDSde>; Tue, 4 Dec 2001 13:33:34 -0500
Date: Tue, 4 Dec 2001 12:33:27 -0600
From: Tommy Reynolds <reynolds@redhat.com>
To: apiggyjj@yahoo.ca
Cc: linux-kernel@vger.kernel.org
Subject: Re: Insmod problems
Message-Id: <20011204123327.7e7618b7.reynolds@redhat.com>
In-Reply-To: <20011204182023.87068.qmail@web20206.mail.yahoo.com>
In-Reply-To: <sc0ca5e8.017@mail-smtp.uvsc.edu>
	<20011204182023.87068.qmail@web20206.mail.yahoo.com>
Organization: Red Hat Software, Inc. / Embedded Development
X-Mailer: Sylpheed version 0.6.5cvs3 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: Nr)Jjr<W18$]W/d|XHLW^SD-p`}1dn36lQW,d\ZWA<OQ/XI;UrUc3hmj)pX]@n%_4n{Zsg$ t1p@38D[d"JHj~~JSE_udbw@N4Bu/@w(cY^04u#JmXEUCd]l1$;K|zeo!c.#0In"/d.y*U~/_c7lIl 5{0^<~0pk_ET.]:MP_Aq)D@1AIQf.juXKc2u[2pSqNSi3IpsmZc\ep9!XTmHwx
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 boundary="=.kkvF.Z2SZ.76XE"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.kkvF.Z2SZ.76XE
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

More important activities lacking, "Michael Zhu" <apiggyjj@yahoo.ca> wrote:

> I've changed my source file like this:
> #define MODULE
> 
> #include <linux/module.h>
> 
> int init_module(void)  { printk("<1>Hello, world\n");
> return 0; }
> void cleanup_module(void) { printk("<1>Goodbye cruel
> world\n"); }
> 
> And I use the following command line to build the
> module.
> 
> gcc -c -D__KERNEL__ hello.c
> 
> But when I use insmod to load the module I got the
> following error message:
> 
> hello.o : kernel-module version mismatch
>          hello.o was compiled for kernel version
> 2.4.12
>          while this kernel is version 2.4.8
> 
> What is wrong? My kernel version is 2.4.8. Is there
> something wrong with the gcc compilier? My gcc
> compilier is gcc-2.95.

You're not picking up the correct kernel header files.  Don't allow GCC to pick
up the files from "/usr/include/linux":

$ gcc -I/usr/src/linux/include -c -D__KERNEL__ hello.c

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- + -- -- -- -- -- -- -- -- -- --
Tommy Reynolds                               | mailto: <reynolds@redhat.com>
Red Hat, Inc., Embedded Development Services | Phone:  +1.256.704.9286
307 Wynn Drive NW, Huntsville, AL 35805 USA  | FAX:    +1.256.837.3839
Senior Software Developer                    | Mobile: +1.919.641.2923

--=.kkvF.Z2SZ.76XE
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)

iEYEARECAAYFAjwNFvsACgkQWEn3bOOMcuoESQCfYAgd4aEKWdTf06q+96GnslFb
4hcAoLjUUxoR4cjBqnmgzWDXoBXzlwll
=GHyE
-----END PGP SIGNATURE-----

--=.kkvF.Z2SZ.76XE--

