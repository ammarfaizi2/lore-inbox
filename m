Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265649AbUABV1O (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 16:27:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265691AbUABV1O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 16:27:14 -0500
Received: from h80ad254a.async.vt.edu ([128.173.37.74]:48319 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S265649AbUABV1I (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 16:27:08 -0500
Message-Id: <200401022127.i02LR0vm015416@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Paolo Ornati <ornati@lycos.it>
Cc: Ed Sweetman <ed.sweetman@wmich.edu>, linux-kernel@vger.kernel.org
Subject: Re: Strange IDE performance change in 2.6.1-rc1 (again) 
In-Reply-To: Your message of "Fri, 02 Jan 2004 22:04:27 +0100."
             <200401022200.22917.ornati@lycos.it> 
From: Valdis.Kletnieks@vt.edu
References: <200401021658.41384.ornati@lycos.it> <3FF5B3AB.5020309@wmich.edu>
            <200401022200.22917.ornati@lycos.it>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1689837264P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 02 Jan 2004 16:27:00 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1689837264P
Content-Type: text/plain; charset=us-ascii

On Fri, 02 Jan 2004 22:04:27 +0100, Paolo Ornati said:

> The results are like the previous.
> 
> 2.6.0:
> 64        31.91
> 128      31.89
> 256      26.22	# during the transfer HD LED blinks
> 8192    26.26	# during the transfer HD LED blinks
> 
> 2.6.1-rc1:
> 64        25.84	# during the transfer HD LED blinks
> 128      25.85	# during the transfer HD LED blinks
> 256      25.90	# during the transfer HD LED blinks
> 8192    26.42	# during the transfer HD LED blinks
> 
> I have tried with and without "nice -n '-20'" but without any visible changes

Do you get different numbers if you boot with:

elevator=as
elevator=deadline
elevator=cfq  (for -mm kernels)
elevator=noop

(You may need to build a kernel with these configured - the symbols are:

CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y  (-mm kernels only)

and can be selected in the 'General Setup' menu - they should all be
built by default unless you've selected EMBEDDED).

--==_Exmh_-1689837264P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/9eIkcC3lWbTT17ARAhDkAJ9Z/B9417kLrW/+IPN++WpSgzF4WQCfRN83
hOCXagchpmJhEj+VPWx1pDw=
=2KhD
-----END PGP SIGNATURE-----

--==_Exmh_-1689837264P--
