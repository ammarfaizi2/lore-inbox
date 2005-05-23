Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261843AbVEWEwx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261843AbVEWEwx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 00:52:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261844AbVEWEwx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 00:52:53 -0400
Received: from h80ad2538.async.vt.edu ([128.173.37.56]:21522 "EHLO
	h80ad2538.async.vt.edu") by vger.kernel.org with ESMTP
	id S261845AbVEWEwu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 00:52:50 -0400
Message-Id: <200505230452.j4N4qEOU001880@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: James Morris <jmorris@redhat.com>
Cc: Reiner Sailer <sailer@us.ibm.com>, Toml@us.ibm.com,
       linux-security-module@wirex.com, linux-kernel@vger.kernel.org,
       Pavel Machek <pavel@ucw.cz>, Emilyr@us.ibm.com, Kylene@us.ibm.com
Subject: Re: [PATCH 2 of 4] ima: related Makefile compile order change and Readme 
In-Reply-To: Your message of "Mon, 23 May 2005 00:30:15 EDT."
             <Xine.LNX.4.44.0505230028380.29960-100000@thoron.boston.redhat.com> 
From: Valdis.Kletnieks@vt.edu
References: <Xine.LNX.4.44.0505230028380.29960-100000@thoron.boston.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1116823933_3542P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 23 May 2005 00:52:13 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1116823933_3542P
Content-Type: text/plain; charset=us-ascii

On Mon, 23 May 2005 00:30:15 EDT, James Morris said:

> Perhaps I don't understand things fully, but what is the purpose of 
> providing measurement values locally via proc?
> 
> How can they be trusted without the TPM signing an externally generated 
> nonce?

If you can't trust what the kernel is outputting in /proc, you're screwed.

And for that matter, how would you verify that it's the TPM that signed the
externally generated nonce? (Remember - if you can't trust /proc, then you
have to assume that *any* attempt at talking to the TPM from userspace *is*
a MITM attack - and you don't have access to any out-of-band info.  If the
now-untrusted kernel did a MITM on your nonce and signed it with a fake key,
then it can *also* MITM your attempt to read the "correct" key from /etc/tpm.key
or wherever it is....

--==_Exmh_1116823933_3542P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCkWF9cC3lWbTT17ARAs/9AJ9uY3O8Z96+n1X3xVNNcfxoeDZKDACeLXhO
2AGnoBVkjC757iFmgH4EPg8=
=Xe5N
-----END PGP SIGNATURE-----

--==_Exmh_1116823933_3542P--
