Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751162AbWDKWVi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751162AbWDKWVi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 18:21:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751163AbWDKWVh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 18:21:37 -0400
Received: from mx0.karneval.cz ([81.27.192.108]:27862 "EHLO av2.karneval.cz")
	by vger.kernel.org with ESMTP id S1751162AbWDKWVg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 18:21:36 -0400
Message-ID: <443C2BF4.6070106@gmail.com>
Date: Wed, 12 Apr 2006 00:21:40 +0200
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Bernard Pidoux <pidoux@ccr.jussieu.fr>
CC: linux-kernel@vger.kernel.org, Bernard Pidoux <bpidoux@free.fr>
Subject: Re: [kernel 2.6] Patch for mxser.c driver
References: <443C1DA0.1030004@ccr.jussieu.fr>
In-Reply-To: <443C1DA0.1030004@ccr.jussieu.fr>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Bernard Pidoux napsal(a):
> Hi,
> 
> mxser driver in kernel 2.6.16 can compile but it does not drive the
> serial multiport adapter from Moxa.
> 
> According to Moxa documentation for version 1.8, msmknod script,
> downloaded from their support site, creates ttyM0-7 and cum0-7 tty
> devices with major numbers 30 and 35 by defaults.
> 
> However, in mxser.c major device numbers are still 174 and 175.
> 
> Here is a patch to change major tty device numbers to proper default
> values.
> 
> 
> --- linux/drivers/char/mxser.c.old 2006-04-11 22:35:16.000000000 +0200
> +++ linux/drivers/char/mxser.c     2006-04-11 22:36:49.000000000 +0200
> @@ -68,8 +68,8 @@
>  #include "mxser.h"
> 
>  #define        MXSER_VERSION   "1.8"
> -#define        MXSERMAJOR       174
> -#define        MXSERCUMAJOR     175
Strange:
172 char        Moxa Intellio serial card
173 char        Moxa Intellio serial card - alternate devices
174 char        SmartIO serial card
175 char        SmartIO serial card - alternate devices
> +#define        MXSERMAJOR       30
> +#define        MXSERCUMAJOR     35
They are not free:
 30 char        iBCS-2 compatibility devices
 35 char        tclmidi MIDI driver
> 
>  #define        MXSER_EVENT_TXLOW        1
>  #define        MXSER_EVENT_HANGUP       2
> 
> 
> BTW, driver source that can be downloaded from Moxa support site will
> not compile :
old tty API

see Documentation/devices.txt

regards,
- --
Jiri Slaby         www.fi.muni.cz/~xslaby
~\-/~      jirislaby@gmail.com      ~\-/~
B67499670407CE62ACC8 22A032CC55C339D47A7E
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFEPCv0MsxVwznUen4RAjgzAJ48FiKNDUCDE2Aru39U3HceOI+v2QCeL09m
qR35e/cdR+Cjgz7SpZjmaeQ=
=ZT4r
-----END PGP SIGNATURE-----
