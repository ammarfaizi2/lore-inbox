Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751106AbWDXShT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751106AbWDXShT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 14:37:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751109AbWDXShS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 14:37:18 -0400
Received: from orfeus.profiwh.com ([82.100.20.117]:24327 "EHLO
	orfeus.profiwh.com") by vger.kernel.org with ESMTP id S1751106AbWDXShR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 14:37:17 -0400
Message-ID: <444D1AD1.4000301@gmail.com>
Date: Mon, 24 Apr 2006 20:36:42 +0159
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Bernard Pidoux <bpidoux@free.fr>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Bernard Pidoux <pidoux@ccr.jussieu.fr>, linux-kernel@vger.kernel.org
Subject: Re: [kernel 2.6] Patch for mxser.c driver
References: <443C1DA0.1030004@ccr.jussieu.fr>  <443C2BF4.6070106@gmail.com> <1144834562.1952.31.camel@localhost.localdomain> <444C913B.3020706@free.fr>
In-Reply-To: <444C913B.3020706@free.fr>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-SpamReason: {Bypass=00}-{0,00}-{0,00}-{0,00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Bernard Pidoux napsal(a):
> Hi,
> 
> The multiport serial adapter I wanted to use is a four ports C104H/PCI
> SmartIO.
> 
> I just received from Moxa support a beta version of the driver
> (mxser_1.9.1.tgz).
> 
> Acording to readme.txt file
> 
>    The Smartio/Industio/UPCI family Linux driver supports following
> multiport
>    boards.
> 
>     - 2 ports multiport board
>         CP-102U, CP-102UL
>         CP-132U-I, CP-132UL,
>         CP-132, CP-132I, CP132S, CP-132IS,
>         CI-132, CI-132I, CI-132IS,
>         (C102H, C102HI, C102HIS, C102P, CP-102, CP-102S)
> 
>     - 4 ports multiport board
>         CP-104EL,
>         CP-104UL, CP-104JU,
>         CP-134U, CP-134U-I
>         C104H/PCI, C104HS/PCI,
>         CP-114, CP-114I, CP-114S, CP-114IS,
>         C104H, C104HS,
>         CI-104J, CI-104JS
>         CI-134, CI-134I, CI-134IS,
>         (C114HI, CT-114I, C104P)
> 
>     - 8 ports multiport board
>         CP-118EL, CP-168EL,
>         CP-118U, CP-168U,
>         C168H/PCI,
>         C168H, C168HS,
>         (C168P)
> 
> I did not have any problem to compile this beta version of driver 1.9
> and utilities under kernel 2.6.16 with gcc 4.0.3
Thanks for sources. The problem is, they still use deprecated api, they still
pci_find_device, despite I applied them to correct it and they promise to at
least try their best, unfortunately with no effect :(. I guess, if they don't
convert it to pci probing, the driver won't be altered (delete 'if LINUXVERSION'
and so on) to be re-merged as a new version.
The driver needs to be rewritten as a whole (macros, whitespace, probing, maybe
it missed some new tty api changes and so on). Maybe I get into that on summer
holidays or somebody may do so earlier, but merging driver in present state is
maybe unwanted.

regards,
- --
Jiri Slaby         www.fi.muni.cz/~xslaby
\_.-^-._   jirislaby@gmail.com   _.-^-._/
B67499670407CE62ACC8 22A032CC55C339D47A7E
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFETRrRMsxVwznUen4RAvxBAJwIhDvzgs0zGJfkfUp8U2bOU3N3kwCeNk3Z
e5f+9FVPKtVd+JbmVuMDeGg=
=niri
-----END PGP SIGNATURE-----
