Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263165AbRFTXXm>; Wed, 20 Jun 2001 19:23:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263625AbRFTXXc>; Wed, 20 Jun 2001 19:23:32 -0400
Received: from 200-206-139-161-br-arqfisb1.public.telesp.net.br ([200.206.139.161]:8198
	"EHLO blackjesus.async.com.br") by vger.kernel.org with ESMTP
	id <S263165AbRFTXXY>; Wed, 20 Jun 2001 19:23:24 -0400
Date: Wed, 20 Jun 2001 20:23:06 -0300 (BRT)
From: Christian Robottom Reis <kiko@async.com.br>
To: <NFS@lists.sourceforge.net>
cc: <linux-kernel@vger.kernel.org>, <reiserfs-list@namesys.com>
Subject: NFS insanity 
Message-ID: <Pine.LNX.4.32.0106202015380.2976-100000@blackjesus.async.com.br>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've got an NFS server, version 2.4.4, using reiserfs with trond's NFS
patches and the reiser-2.4.4 nfs patch.

On a client running 2.4.5 with trond's patches and the corresponding
reiser patches, I get the wierdest behaviour:

# on client
cp libgkcontent.so libgkcontent.so.x
diff libgkcontent.so libgkcontent.so.x
# no diff

# on server
diff libgkcontent.so libgkcontent.so.x
Binary files libgkcontent.so and libgkcontent.so.x differ

It _only_ happens in this file of all files I've tried out so far. I'm
trying to get xdelta to show me what's differing so I can see if there's a
pattern or something, but it's awful - data corruption not only possibly
but happening. :-)

I haven't tried remounting yet to see what I get, but I don't see the
problems on unpatched 2.4.2. I'll wait a bit to see if anyone has seen
this. Anyone?

Take care,
--
/\/\ Christian Reis, Senior Engineer, Async Open Source, Brazil
~\/~ http://async.com.br/~kiko/ | [+55 16] 274 4311


