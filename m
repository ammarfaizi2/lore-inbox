Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261195AbTEESUm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 14:20:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261198AbTEESUl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 14:20:41 -0400
Received: from smtp015.mail.yahoo.com ([216.136.173.59]:33041 "HELO
	smtp015.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261195AbTEESUj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 14:20:39 -0400
From: Michael Buesch <fsdeveloper@yahoo.de>
To: Jochen Hein <jochen@jochen.org>
Subject: Re: [2.5.69, TR] compile error
Date: Mon, 5 May 2003 20:32:55 +0200
User-Agent: KMail/1.5.1
References: <87bryh9ue3.fsf@echidna.jochen.org>
In-Reply-To: <87bryh9ue3.fsf@echidna.jochen.org>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200305052033.10592.fsdeveloper@yahoo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Monday 05 May 2003 19:27, Jochen Hein wrote:
> This seems to be a fallout from the irq-type changes:
>
>   gcc -Wp,-MD,drivers/net/pcmcia/.ibmtr_cs.o.d -D__KERNEL__ -Iinclude
>   -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing
>   -fno-common -pipe -mpreferred-stack-boundary=2 -march=pentium2
>   -Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include
>   -DMODULE   -DKBUILD_BASENAME=ibmtr_cs -DKBUILD_MODNAME=ibmtr_cs -c
>   -o drivers/net/pcmcia/ibmtr_cs.o drivers/net/pcmcia/ibmtr_cs.c
> In file included from drivers/net/pcmcia/ibmtr_cs.c:71:
> drivers/net/tokenring/ibmtr.c: In function `tok_open':
> drivers/net/tokenring/ibmtr.c:903: warning: `MOD_INC_USE_COUNT' is
>   deprecated (declared at include/linux/module.h:456)
> In file included from drivers/net/pcmcia/ibmtr_cs.c:71:
> drivers/net/tokenring/ibmtr.c: In function `tok_close':
> drivers/net/tokenring/ibmtr.c:1068: warning: `MOD_DEC_USE_COUNT' is
>   deprecated (declared at include/linux/module.h:468)
> drivers/net/pcmcia/ibmtr_cs.c: At top level:
> drivers/net/pcmcia/ibmtr_cs.c:130: conflicting types for
>   `tok_interrupt'
> drivers/net/tokenring/ibmtr.c:1170: previous declaration of
>   `tok_interrupt'
> make[3]: *** [drivers/net/pcmcia/ibmtr_cs.o] Fehler 1
> make[2]: *** [drivers/net/pcmcia] Fehler 2
> make[1]: *** [drivers/net] Fehler 2
> make: *** [drivers] Fehler 2

Can you please post your .config, as I'm not able to reproduce it.
thanks.

- -- 
Regards Michael Büsch
http://www.8ung.at/tuxsoft
 20:32:19 up  2:57,  1 user,  load average: 1.17, 1.06, 1.14
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+tq5moxoigfggmSgRAghNAJ0UOjfMe+00LE5Rfo4zMOFKZMwJvACeOtWg
Vcf0mH80oXgwedcBrDk/NsE=
=7vUk
-----END PGP SIGNATURE-----

