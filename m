Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265805AbSKAWbj>; Fri, 1 Nov 2002 17:31:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265806AbSKAWbj>; Fri, 1 Nov 2002 17:31:39 -0500
Received: from c16410.randw1.nsw.optusnet.com.au ([210.49.25.29]:14590 "EHLO
	mail.chubb.wattle.id.au") by vger.kernel.org with ESMTP
	id <S265805AbSKAWbh>; Fri, 1 Nov 2002 17:31:37 -0500
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15811.567.643867.851362@wombat.chubb.wattle.id.au>
Date: Sat, 2 Nov 2002 09:37:43 +1100
To: John McCash <jmccash@medstrat.com>
Subject: Multiterabyte Filesystem Support in 2.4.x on IA64?
In-Reply-To: <846419754@toto.iv>
X-Mailer: VM 7.04 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "John" == John McCash <jmccash@medstrat.com> writes:

John> Hi, I've searched through the lkml archives, and come up with
John> conflicting information on the topic of large filesystem support
John> in 2.4.x.  What I'm interested in doing is a multiterabyte
John> filesystem, using hardware RAID arrays, connected via SCSI to an
John> Intel-based host. My research indicates that I MAY be able to do
John> this if I use a 64 bit processor architecture, and use either
John> ext3 or xfs on top of LVM for the filesystem.  What's not clear
John> currently, is whether I'm subject to the 2 terabyte file size
John> and filesystem size limitation.

I don't know why you want large block device support in 2.4, but it's
now available at  http://www.gelato.unsw.edu.au/patches for IA64
against Bjorn's latest tree.

I haven't tried LVM, but MD with megaraid works on a 4-way Itanium.

JFS doesn't currently work; XFS should but I've only tried ext[23],
reiserfs (both of which work) and JFS (which doesn't).

You'll be limited to 16TB for ext2, and a maximum 2TB file size; XFS
is a better bet, but is not in the core kernel.

Peter C
