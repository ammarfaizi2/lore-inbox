Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317152AbSGNVrG>; Sun, 14 Jul 2002 17:47:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317171AbSGNVrF>; Sun, 14 Jul 2002 17:47:05 -0400
Received: from lsanca2-ar27-4-3-064-252.lsanca2.dsl-verizon.net ([4.3.64.252]:2176
	"EHLO barbarella.hawaga.org.uk") by vger.kernel.org with ESMTP
	id <S317152AbSGNVrE>; Sun, 14 Jul 2002 17:47:04 -0400
Date: Sun, 14 Jul 2002 14:49:31 -0700 (PDT)
From: Ben Clifford <benc@hawaga.org.uk>
To: Dave Jones <davej@suse.de>
cc: Heinz Diehl <hd@cavy.de>, <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.25-dj2
In-Reply-To: <20020714115525.C28859@suse.de>
Message-ID: <Pine.LNX.4.44.0207141445390.2823-100000@barbarella.hawaga.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Sun, 14 Jul 2002, Dave Jones wrote:

>  > >   ide-scsi24.c:847: unknown field abort' specified in initializer
>  > >   ide-scsi24.c:847: warning: initialization from incompatible pointer type
>  > >   ide-scsi24.c:848: unknown field reset' specified in initializer
>  > >   ide-scsi24.c:848: warning: initialization from incompatible pointer type
> 
> Just kill those lines.

So I killed those lines (and applied the patch supplied by Tim Schmielau).

My ide-cd module was loaded automatically at boot.
I loaded the ide-scsi24 module (which didn't detect anything because the 
ide-cd module already had both the CD-ROM and CD-RW drives).
So I rmmoded ide-cd and ide-scsi24.
Then I modprobed ide-scsi and got two oopses in quick succession which 
locked up the machine :-(

Anyone else have any luck with ide-scsi24?

More details to follow.

- -- 
Ben Clifford     benc@hawaga.org.uk     GPG: 30F06950
http://www.hawaga.org.uk/ben/


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9MfHxsYXoezDwaVARAj7IAJ9qZp379ALSUoZslSGyvzvPFT6HawCdHO6r
GZQ1J4oBiQYKOM8JyP4SS2M=
=rKux
-----END PGP SIGNATURE-----

