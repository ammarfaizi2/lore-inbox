Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262983AbSJBGeV>; Wed, 2 Oct 2002 02:34:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262984AbSJBGeV>; Wed, 2 Oct 2002 02:34:21 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:58377 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S262983AbSJBGeU>; Wed, 2 Oct 2002 02:34:20 -0400
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15770.38068.29726.456359@laputa.namesys.com>
Date: Wed, 2 Oct 2002 10:39:48 +0400
X-PGP-Fingerprint: 43CE 9384 5A1D CD75 5087  A876 A1AA 84D0 CCAA AC92
X-PGP-Key-ID: CCAAAC92
X-PGP-Key-At: http://wwwkeys.pgp.net:11371/pks/lookup?op=get&search=0xCCAAAC92
To: Paul P Komkoff Jr <i@stingr.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [STUPID TESTCASE] ext3 htree vs. reiserfs on 2.5.40-mm1
In-Reply-To: <20021001195914.GC6318@stingr.net>
References: <20021001195914.GC6318@stingr.net>
X-Mailer: VM 7.07 under 21.5  (beta6) "bok choi" XEmacs Lucid
X-Antipastobozoticataclysm: When George Bush projectile vomits antipasto on the Japanese.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul P Komkoff Jr writes:
 > This is the stupidiest testcase I've done but it worth seeing (maybe)
 > 
 > We create 300000 files named from 00000000 to 000493E0 in one
 > directory, then delete it in order.
 > 
 > Tests taken on ext3+htree and reiserfs. ext3 w/o htree hadn't
 > evaluated because it will take long long time ...
 > 
 > both filesystems was mounted with noatime,nodiratime and ext3 was
 > data=writeback to be somewhat fair ...
 > 
 > 	       	real 	      	user  		sys
 > reiserfs:
 > Creating: 	3m13.208s	0m4.412s	2m54.404s
 > Deleting:	4m41.250s	0m4.206s	4m17.926s
 > 
 > Ext3:
 > Creating:	4m9.331s	0m3.927s	2m21.757s
 > Deleting:	9m14.838s	0m3.446s	1m39.508s

Why user times are so different?

 > 
 > htree improved this a much but it still beaten by reiserfs. seems odd
 > to me - deleting taking twice time then creating ...
 > 
 > -- 
 > Paul P 'Stingray' Komkoff 'Greatest' Jr /// (icq)23200764 /// (http)stingr.net
 >   When you're invisible, the only one really watching you is you (my keychain)

Nikita.

