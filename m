Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316853AbSILSWo>; Thu, 12 Sep 2002 14:22:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316883AbSILSWo>; Thu, 12 Sep 2002 14:22:44 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:33552 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S316853AbSILSWn>; Thu, 12 Sep 2002 14:22:43 -0400
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15744.56469.104338.357738@laputa.namesys.com>
Date: Thu, 12 Sep 2002 22:27:33 +0400
X-PGP-Fingerprint: 43CE 9384 5A1D CD75 5087  A876 A1AA 84D0 CCAA AC92
X-PGP-Key-ID: CCAAAC92
X-PGP-Key-At: http://wwwkeys.pgp.net:11371/pks/lookup?op=get&search=0xCCAAAC92
To: Alexander Viro <viro@math.psu.edu>
Cc: Linux Kernel Mailing List <Linux-Kernel@Vger.Kernel.ORG>
Subject: lookup on unlinked directory.
X-Mailer: VM 7.07 under 21.5  (beta6) "bok choi" XEmacs Lucid
X-Meat: Ham
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

why ->create(), ->unlink(), and ->readdir() are disabled on the unlinked
but open directory (one with ->i_flags |= S_DEAD), but ->lookup() is
not?  This is especially strange, because ->rmdir() usually removes dot
and dotdot, but link_path_walk() will pretend they still exist.

Is this so for being able to do "cd .." from inside unlinked directory?

Nikita.
