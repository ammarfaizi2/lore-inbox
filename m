Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267440AbTBIT6p>; Sun, 9 Feb 2003 14:58:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267439AbTBIT6p>; Sun, 9 Feb 2003 14:58:45 -0500
Received: from c16410.randw1.nsw.optusnet.com.au ([210.49.25.29]:20468 "EHLO
	mail.chubb.wattle.id.au") by vger.kernel.org with ESMTP
	id <S267438AbTBIT6n>; Sun, 9 Feb 2003 14:58:43 -0500
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15942.46375.478902.665549@wombat.chubb.wattle.id.au>
Date: Mon, 10 Feb 2003 07:08:07 +1100
To: Stephan van Hienen <raid@a2000.nu>
Cc: Andreas Dilger <adilger@clusterfs.com>, linux-kernel@vger.kernel.org,
       linux-raid@vger.kernel.org, ext2-devel@lists.sourceforge.net,
       "Theodore Ts'o" <tytso@mit.edu>, peter@chubb.wattle.id.au, tbm@a2000.nu
Subject: Re: fsck out of memory
In-Reply-To: <Pine.LNX.4.53.0302090953440.1039@ddx.a2000.nu>
References: <Pine.LNX.4.53.0302071555110.718@ddx.a2000.nu>
	<Pine.LNX.4.53.0302071800200.1306@ddx.a2000.nu>
	<20030207102858.P18636@schatzie.adilger.int>
	<Pine.LNX.4.53.0302090953440.1039@ddx.a2000.nu>
X-Mailer: VM 7.07 under 21.4 (patch 10) "Military Intelligence" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Stephan" == Stephan van Hienen <raid@a2000.nu> writes:

Stephan> makes me wonder if this can have todo with the lbd (to allow
Stephan> 2TB+ devices) patch ? or is this something else?  (if it can
Stephan> be related to the lbd patch, i will remove 2 hd's from the
Stephan> array (but i don't prefer this option))

I haven't tested ext[23] with that large a system on IA32 (I stopped
at 2.4TB, and that was on Linux 2.5).  The 2.4 LBD patch was basically
backported from the 2.5.9 version (the last tested version before Al
Viro's rewrite of the block device and partitioning code).  Differences in
ext[32] between 2.4.20 and 2.5.9 may not have been allowed for
properly.

I'll have a look when I'm in at work today.

Is there any reason why you're sticking with the 2.4 kernel and ext3?
XFS has been used (on SGI systems) for much longer with large disk
arrays, and I'd expect (linux-specific bugs aside) it to be a more
mature product for this application.

Peter C

