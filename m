Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267600AbSKSXWn>; Tue, 19 Nov 2002 18:22:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267612AbSKSXWm>; Tue, 19 Nov 2002 18:22:42 -0500
Received: from c16410.randw1.nsw.optusnet.com.au ([210.49.25.29]:14841 "EHLO
	mail.chubb.wattle.id.au") by vger.kernel.org with ESMTP
	id <S267600AbSKSXWk>; Tue, 19 Nov 2002 18:22:40 -0500
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15834.51557.836769.918443@wombat.chubb.wattle.id.au>
Date: Wed, 20 Nov 2002 10:29:41 +1100
To: Neil Brown <neilb@cse.unsw.edu.au>
Subject: Re: rpc.mountd problem in 2.5.48
Cc: linux-kernel@vger.kernel.org, trond.myklebust@fys.uio.no
In-Reply-To: <15834.49275.238123.495190@notabene.cse.unsw.edu.au>
References: <15834.1952.674371.221691@wombat.chubb.wattle.id.au>
	<15834.49275.238123.495190@notabene.cse.unsw.edu.au>
X-Mailer: VM 7.04 under 21.4 (patch 10) "Military Intelligence" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Neil" == Neil Brown <neilb@cse.unsw.edu.au> writes:

Neil> On Tuesday November 19, peter@chubb.wattle.id.au wrote:
>> Hi, After installing 2.5.48, I see lots and lots of messages like
>> these: Nov 19 20:17:24 wombat rpc.mountd: authenticated mount
>> request from xterm.chubb.wattle.id.au:916 for
>> /usr/local/xenginenew/fonts/misc (/usr) Nov 19 20:17:24 wombat
>> rpc.mountd: getfh failed: Operation not permitted
>> 
>> These weren't there in 2.5.44. What's changed?

Neil> Lots of stuff.... but nothing that I can connect this to.  Also,
Neil> I cannot reproduce it.

>> xterm uses version 2 NFS; /etc/exports says: ..  /usr
>> *.chubb.wattle.id.au(rw,sync,no_root_squash) ..  /usr is ext2: $
>> mount /dev/sda5 on /usr type ext2 (rw)
>> 
>> 
>> If I add the `insecure' option things work again; but this didn't
>> used to be necessary.  And the log shows it coming in on port 916,
>> anyway.

Neil> I suspec that adding 'insecure' did not fix the problem, but
Neil> rather it was trying again that fixed the problem.

Removing `insecure' and doing exportfs -r -a  brings the problem back
again.

Neil> Does /etc/exports have any exports to IP address rather than
Neil> hostname?  Which version of nfs-utils are you using?

No.  All the /etc/exports lines are in terms of *.chubb.wattle.id.au

I'm using the debian-packaged version 1.0.2-1 nfs-utils (which has
no patches over the source version).

There are correct forward and reverse entries for xterm in the DNS:

: wombat ; host xterm
xterm.chubb.wattle.id.au        A       192.168.77.5

: wombat ; host 192.168.77.5
Name: xterm.chubb.wattle.id.au
Address: 192.168.77.5



It's only with xterm (which is a labtam/tektronix xterminal) that I
have a problem; other linux machines are fine.

Peter C


