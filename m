Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272135AbTGYO5L (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 10:57:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272136AbTGYO5L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 10:57:11 -0400
Received: from h80ad26ab.async.vt.edu ([128.173.38.171]:8066 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S272135AbTGYO5F (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 10:57:05 -0400
Message-Id: <200307251512.h6PFCD9g004415@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Duncan Sands <baldrick@wanadoo.fr>
Cc: koraq@xs4all.nl, linux-kernel@vger.kernel.org
Subject: Re: [2.4.22-pre7] speedtouch.o unresolved symbols 
In-Reply-To: Your message of "Fri, 25 Jul 2003 16:43:31 +0200."
             <200307251643.32003.baldrick@wanadoo.fr> 
From: Valdis.Kletnieks@vt.edu
References: <20030724202048.GA16411@spearhead> <200307250855.24218.baldrick@wanadoo.fr> <200307251426.h6PEQs9g003992@turing-police.cc.vt.edu>
            <200307251643.32003.baldrick@wanadoo.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1752085672P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 25 Jul 2003 11:12:13 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1752085672P
Content-Type: text/plain; charset=us-ascii

On Fri, 25 Jul 2003 16:43:31 +0200, Duncan Sands said:

> From drivers/usb/Config.in
> 
>    if [ "$CONFIG_ATM" = "y" -o "$CONFIG_ATM" = "m" ]; then
>       dep_tristate '  Alcatel Speedtouch USB support' CONFIG_USB_SPEEDTOUCH $CONFIG_ATM $CONFIG_USB
>    fi
> 
> Now the question is: why is this not enough?

Hmm.. I don't have a 22-pre7 tree handy, what's the relevant reference in
drivers/usb/Makefile look like?  I'm guessing a missing 'ifeq' or
obj-$(CONFIG_mumble) in there, so speedtch.o gets build even if the
required flags aren't set?

Other possibility is a missing EXPORT_SYMBOL() that's horquing things up
if you have CONFIG_ATM=m rather than y? (Yes, I know it's a 'bool' in net/Config.in,
doesn't mean you can't get an 'm' in there anyhow. ;)

--==_Exmh_1752085672P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/IUjNcC3lWbTT17ARAoZWAKDBMXat8FpXjp02DKoDkjDNtpr/FQCcDx1G
UUhfnuoDG5SX+XmUt3NqYwM=
=OyGy
-----END PGP SIGNATURE-----

--==_Exmh_1752085672P--
