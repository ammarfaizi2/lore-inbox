Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310190AbSERIwz>; Sat, 18 May 2002 04:52:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310206AbSERIwy>; Sat, 18 May 2002 04:52:54 -0400
Received: from matrix2.enst.fr ([137.194.2.14]:55436 "HELO smtp2.enst.fr")
	by vger.kernel.org with SMTP id <S310190AbSERIwx>;
	Sat, 18 May 2002 04:52:53 -0400
Date: Sat, 18 May 2002 10:52:52 +0200
From: Cedric Ware <cedric.ware@enst.fr>
To: Michael Hoennig <michael@hostsharing.net>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: suid bit on directories
Message-ID: <20020518105252.A3897@enst.fr>
In-Reply-To: <20020518103432.5a3b4c67.michael@hostsharing.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I do not even see a security hole if nobody other than the user itself and
> httpd/web can reach this area in the file system, anyway. And it is still
> the users decision that files in this (his) directory should belong to
> him.

I guess it is considered a security hole if a user can create files not
belonging to him.

> Actually, the suid bit on directories works at least under FreeBSD. Is

Not under 4.x (nor OpenBSD 2.9); or did I do anything wrong?

krakatoa ~ % uname -a
FreeBSD krakatoa.tectonics 4.5-STABLE FreeBSD 4.5-STABLE #13: Thu Mar 28 01:12:06 CET 2002     ware@krakatoa.tectonics:/local/usr/obj/usr/src/sys/KRAKATOA  i386
krakatoa ~ % whoami
ware
krakatoa ~ % cd /tmp
krakatoa /tmp % mkdir xx
krakatoa /tmp % sudo chown root.bin xx
krakatoa /tmp % sudo chmod 6777 xx
krakatoa /tmp % touch xx/yy
krakatoa /tmp % ls -la xx
total 4
drwsrwsrwx   2 root     bin           512 May 18 10:47 .
drwxrwxrwt  20 root     wheel        3072 May 18 10:47 ..
-rw-r--r--   1 ware     bin             0 May 18 10:47 yy
krakatoa /tmp % 

						Cheers,
						Cedric Ware.

