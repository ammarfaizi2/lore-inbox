Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265500AbRFVTwg>; Fri, 22 Jun 2001 15:52:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265501AbRFVTw0>; Fri, 22 Jun 2001 15:52:26 -0400
Received: from 200-206-139-161-br-arqfisb1.public.telesp.net.br ([200.206.139.161]:32261
	"EHLO blackjesus.async.com.br") by vger.kernel.org with ESMTP
	id <S265500AbRFVTwX>; Fri, 22 Jun 2001 15:52:23 -0400
Date: Fri, 22 Jun 2001 16:52:09 -0300 (BRT)
From: Christian Robottom Reis <kiko@async.com.br>
To: <NFS@lists.sourceforge.net>
cc: <reiserfs-list@namesys.com>, <linux-kernel@vger.kernel.org>
Subject: NFS Insanity, v2
Message-ID: <Pine.LNX.4.32.0106221643210.183-100000@blackjesus.async.com.br>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hooray. Or rather, darn. I managed to reproduce the bug again. And now I
even have what I think might be a testcase model. Numbers:  raid-1,
reiserfs, nfs-utils 0.3.1, linux-2.4.5-pre4 now with no extra patching
(well, does iptables-patches count?). fstab line:

anthem:/mondo   /mondo  nfs defaults,rsize=3072,wsize=3072,suid,async 0 0

exports line:

/mondo      foo.bar.com.br(no_root_squash,rw)

Every day at the same time I pull mozilla-latest through http, and untar
it into a directory that is served by nfs. The file isn't too big - around
9MB. It creates a set of files inside /mondo/local/mozilla. One of the
files (same one for some reason), components/libgkcontent.so, always ends
up corrupted on the client side. There is no server-side corruption.

Remounting (and thus rebooting) the client mount gets things back to
normal. Anyone willing to track this down with me? Or is it something
known (and being worked on, hopefully)?

Take care,
--
/\/\ Christian Reis, Senior Engineer, Async Open Source, Brazil
~\/~ http://async.com.br/~kiko/ | [+55 16] 274 4311

