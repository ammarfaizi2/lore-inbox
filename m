Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315482AbSEHCgQ>; Tue, 7 May 2002 22:36:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315483AbSEHCgP>; Tue, 7 May 2002 22:36:15 -0400
Received: from chello062179036163.chello.pl ([62.179.36.163]:38321 "EHLO
	pioneer") by vger.kernel.org with ESMTP id <S315482AbSEHCgP>;
	Tue, 7 May 2002 22:36:15 -0400
Date: Wed, 8 May 2002 04:36:18 +0200 (CEST)
From: Tomasz Rola <rtomek@cis.com.pl>
To: mikeH <mikeH@notnowlewis.co.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: lost interrupt
In-Reply-To: <3CD84F8B.6060308@notnowlewis.co.uk>
Message-ID: <Pine.LNX.3.96.1020508042330.2702K-100000@pioneer>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Tue, 7 May 2002, mikeH wrote:

> Sorry if this is a repeat, I didn't see my last post come through...
> 
> I'm being plauged with "hdX: lost interrupt" messages and resultant 
> system hangs in kernel 2.4.18 on a via 82XXXX chipset.

I may not be the right person to answer but I had same problem (same via,
same kernel, same interrupt). It helped when I turned unmasking off, i.e.
try:

hdparm -u0 /dev/hdX  for every X in existing disks you have problems with.

Actually I did some dirty trick too, cause I have UDMA enabled by default
and compiled in via specific settings in kernel config, while at the same
time I set dma off during init, so I do:

hdparm -d0a0u0 /dev/ide/host0/bus0/target0/lun0/disc (or /dev/hda).

I think -u0 is sufficient but you may try the other command too. My
current dirty tricks are overreaction to problems with UDMA few kernels
(and years) ago so the second command is for paranoids.

bye
T.

- --
** A C programmer asked whether computer had Buddha's nature.      **
** As the answer, master did "rm -rif" on the programmer's home    **
** directory. And then the C programmer became enlightened...      **
**                                                                 **
** Tomasz Rola          mailto:tomasz_rola@bigfoot.com             **

-----BEGIN PGP SIGNATURE-----
Version: PGPfreeware 5.0i for non-commercial use
Charset: noconv

iQA/AwUBPNiPKBETUsyL9vbiEQJ/uACgxwcY2jRlPKt2aBaTd4BzwAIAPoAAoK7g
wYcFIwJZX+cfwmFopa5JHKA5
=hyqY
-----END PGP SIGNATURE-----

