Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268258AbRGZQL0>; Thu, 26 Jul 2001 12:11:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268223AbRGZQLF>; Thu, 26 Jul 2001 12:11:05 -0400
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:15365 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id <S268176AbRGZQLA>; Thu, 26 Jul 2001 12:11:00 -0400
Message-Id: <200107261610.f6QGAnou018105@pincoya.inf.utfsm.cl>
To: sentry21@cdslash.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: Weird ext2fs immortal directory bug 
In-Reply-To: Your message of "Thu, 26 Jul 2001 11:50:24 -0400."
             <Pine.LNX.4.30.0107261150020.18300-100000@spring.webconquest.com> 
X-mailer: MH [Version 6.8.4]
X-charset: ISO_8859-1
Date: Thu, 26 Jul 2001 12:10:49 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

<sentry21@cdslash.net> said:
> > > root@Petra:0:~# debugfs -w /
> > > debugfs 1.22, 22-Jun-2001 for EXT2 FS 0.5b, 95/08/09
> > > /: Is a directory while opening filesystem
> > > debugfs:  ^D
> > >
> > > root@Petra:0:~# debugfs -w /dev/hda5
> > > debugfs 1.22, 22-Jun-2001 for EXT2 FS 0.5b, 95/08/09
> > > debugfs:  unlink /lost+found/#3147
> > > debugfs:  ^D
> >         ^^^^^^^^
> > How about 'Q' so debugfs gets to write the modifications to the
> > drive?
> 
> root@Petra:0:/lost+found# debugfs -w /dev/hda5
> debugfs 1.22, 22-Jun-2001 for EXT2 FS 0.5b, 95/08/09
> debugfs:  unlink /lost+found/#3147
> unlink_file_by_name: No free space in the directory

What machine is that? e2fsprogs-1.22 had some similar weird effects on
SPARC with kernel 2.4.x, 1.20 works fine AFAICS.

You can try nuking the directory (clear_inode or such) and have fsck(8)
pick up the resulting fallout.
-- 
Dr. Horst H. von Brand                Usuario #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
