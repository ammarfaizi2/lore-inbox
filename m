Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267762AbTBMDVC>; Wed, 12 Feb 2003 22:21:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267758AbTBMDVC>; Wed, 12 Feb 2003 22:21:02 -0500
Received: from c16410.randw1.nsw.optusnet.com.au ([210.49.25.29]:47336 "EHLO
	mail.chubb.wattle.id.au") by vger.kernel.org with ESMTP
	id <S267762AbTBMDVA>; Wed, 12 Feb 2003 22:21:00 -0500
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15947.4435.829168.530565@wombat.chubb.wattle.id.au>
Date: Thu, 13 Feb 2003 14:30:27 +1100
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Stephan van Hienen <raid@a2000.nu>, Andreas Dilger <adilger@clusterfs.com>,
       linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
       ext2-devel@lists.sourceforge.net, "Theodore Ts'o" <tytso@mit.edu>,
       peter@chubb.wattle.id.au, tbm@a2000.nu
Subject: Re: [Ext2-devel] Re: fsck out of memory
In-Reply-To: <5250726@toto.iv>
X-Mailer: VM 7.07 under 21.4 (patch 10) "Military Intelligence" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Stephen" == Stephen C Tweedie <sct@redhat.com> writes:

Stephen> Hi, On Tue, 2003-02-11 at 13:11, Stephan van Hienen wrote:

Stephen> I've no idea.  Ben has some lb patches up at

Stephen>   http://people.redhat.com/bcrl/lb/

Stephen> but there's nothing broken out against the latest lbd diffs.


Ben's patches are against a very old version of the kernel (2.4.6-pre8)
and require linking against libgcc to get 64-bit division.


The main issue is 64-bit division.  In the limited time I had I
couldn't convince myself that I could rely on all divisors being less
than 2^31 in the raid4/5 code.  If you can convince yourself of that,
then t's a straightforward but tedious task to make raid1, raid4 and
raid5 LBD-safe.

--
Dr Peter Chubb				    peterc@gelato.unsw.edu.au
You are lost in a maze of BitKeeper repositories, all almost the same.
