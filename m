Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264771AbSKSJf4>; Tue, 19 Nov 2002 04:35:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264854AbSKSJf4>; Tue, 19 Nov 2002 04:35:56 -0500
Received: from c16410.randw1.nsw.optusnet.com.au ([210.49.25.29]:31735 "EHLO
	mail.chubb.wattle.id.au") by vger.kernel.org with ESMTP
	id <S264771AbSKSJfz>; Tue, 19 Nov 2002 04:35:55 -0500
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15834.1952.674371.221691@wombat.chubb.wattle.id.au>
Date: Tue, 19 Nov 2002 20:42:56 +1100
To: linux-kernel@vger.kernel.org
cc: neilb@cse.unsw.edu.au, trond.myklebust@fys.uio.no
Subject: rpc.mountd problem in 2.5.48
X-Mailer: VM 7.04 under 21.4 (patch 10) "Military Intelligence" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
	After installing 2.5.48, I see lots and lots of messages like these:
Nov 19 20:17:24 wombat rpc.mountd: authenticated mount request from xterm.chubb.wattle.id.au:916 for /usr/local/xenginenew/fonts/misc (/usr) 
Nov 19 20:17:24 wombat rpc.mountd: getfh failed: Operation not permitted 

These weren't there in 2.5.44. What's changed?
xterm uses version 2 NFS; /etc/exports says:
..
/usr	*.chubb.wattle.id.au(rw,sync,no_root_squash)
..
/usr is ext2:
$ mount
/dev/sda5 on /usr type ext2 (rw)


If I add the `insecure' option things work again; but this didn't used
to be necessary.  And the log shows it coming in on port 916, anyway.

Peter C
