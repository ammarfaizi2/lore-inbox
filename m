Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264844AbSK0Vcx>; Wed, 27 Nov 2002 16:32:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264854AbSK0Vcx>; Wed, 27 Nov 2002 16:32:53 -0500
Received: from newmail.somanetworks.com ([216.126.67.42]:1456 "EHLO
	mail.somanetworks.com") by vger.kernel.org with ESMTP
	id <S264844AbSK0Vcw>; Wed, 27 Nov 2002 16:32:52 -0500
Message-Id: <200211272140.gARLe5wF007020@localhost.localdomain>
Date: Wed, 27 Nov 2002 16:40:05 -0500
From: Georg Nikodym <georgn@somanetworks.com>
To: Linux/ARM Kernel List <linux-arm-kernel@lists.arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: v2.4.19-rmk4 slab.c: /proc/slabinfo uses broken instead of slab labels
In-Reply-To: <200211272015.gARKFHwF006320@localhost.localdomain>
References: <200211272015.gARKFHwF006320@localhost.localdomain>
Organization: SOMA Networks
X-Mailer: Sylpheed version 0.8.6 (GTK+ 1.2.10; i386-redhat-linux)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="=.8+11GnEG0'YTB4"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.8+11GnEG0'YTB4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 27 Nov 2002 15:15:17 -0500
Georg Nikodym <georgn@somanetworks.com> wrote:

> 1. Is the ARM __get_user() broken?
> 2. Could I be doing something else broken that is confusing __get_user()?
> 3. What was/is the intent of the test?  Or stated differently, why on earth
>    would cachep->name be a user address?

In answer to my own question, reading the 2.5 source was illuminating. 
The intent of the test is obvious:

akpm     1.50         | 	/*
akpm     1.50         | 	 * Check to see if `name' resides inside a module which has been
akpm     1.50         | 	 * unloaded (someone forgot to destroy their cache)
akpm     1.50         | 	 */

Thanks to Mr. Morton for that comment.  Now I get to wrestle with questions 1 and 2.

-g

--=.8+11GnEG0'YTB4
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE95Tu1oJNnikTddkMRAqltAJ9JBhAGQgYEp2X5+l4K3iyV31evfACfbF93
dul0LxG4AUsKNInIWsIvZEU=
=7y9w
-----END PGP SIGNATURE-----

--=.8+11GnEG0'YTB4--
