Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270754AbTHFMry (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 08:47:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273016AbTHFMry
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 08:47:54 -0400
Received: from smtp016.mail.yahoo.com ([216.136.174.113]:48905 "HELO
	smtp016.mail.yahoo.com") by vger.kernel.org with SMTP
	id S270754AbTHFMrw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 08:47:52 -0400
From: Michael Buesch <fsdeveloper@yahoo.de>
To: "lode leroy" <lode_leroy@hotmail.com>
Subject: Re: 2.5.70 lockup while write()ing to /dev/hda1
Date: Wed, 6 Aug 2003 14:47:33 +0200
User-Agent: KMail/1.5.3
References: <Sea2-F12XkCBewSQRg600027013@hotmail.com>
In-Reply-To: <Sea2-F12XkCBewSQRg600027013@hotmail.com>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200308061447.46364.fsdeveloper@yahoo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Wednesday 06 August 2003 14:32, lode leroy wrote:
> main()
> {
>     int f = open("/dev/hda1", O_RDWR);
>     char buffer[8192];
>     for(i=0;1;i++) {
>        printf("%d\r", i);
>        write(f, buffer, sizeof(buffer);

Shouldn't this be:
	write(f, buffer, sizeof(buffer) / sizeof(buffer[0]));

And what are you thying to do with the code?

>        /* fsync(f); */
>     }
>     close(f)
> }

- -- 
Regards Michael Buesch  [ http://www.8ung.at/tuxsoft ]
Penguin on this machine:  Linux 2.6.0-test2 - i386

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/MPjvoxoigfggmSgRAkhNAJ40TUOftJfk/wa+g6B6gFiRSEdsNwCeJ/Tc
YH8xVddWCQZzozFNlIxT14o=
=x0ge
-----END PGP SIGNATURE-----

