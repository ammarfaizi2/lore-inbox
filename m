Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262161AbVF2Bx4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262161AbVF2Bx4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 21:53:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262234AbVF2BvK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 21:51:10 -0400
Received: from mail04.syd.optusnet.com.au ([211.29.132.185]:33413 "EHLO
	mail04.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262324AbVF2BtQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 21:49:16 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17089.65016.112262.278719@wombat.chubb.wattle.id.au>
Date: Wed, 29 Jun 2005 11:48:40 +1000
From: Peter Chubb <peterc@gelato.unsw.edu.au>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: Grzegorz Kulewski <kangur@polcom.net>, linux-kernel@vger.kernel.org
Subject: Re: accessing loopback filesystem+partitions on a file
In-Reply-To: <20050629013731.GF9566@lkcl.net>
References: <20050628233335.GB9087@lkcl.net>
	<Pine.LNX.4.63.0506290228380.7125@alpha.polcom.net>
	<20050629013731.GF9566@lkcl.net>
X-Mailer: VM 7.17 under 21.4 (patch 17) "Jumbo Shrimp" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Luke" == Luke Kenneth Casson Leighton <lkcl@lkcl.net> writes:


Luke> xen guest OSes manage it fine - the xen layer provides a means
Luke> to present any block device as a "disk".

You can do this witht he loop device, but you need to get the
partition info out first.

Use parted or fdisk to get the partition info.
Then use losetup with the appropriate offset.

Luke> that loopback filesystems cannot be presented as block devices
Luke> by the linux kernel (with no involvement of xen) seems to be a
Luke> curious omission.

But they can!  But a loopback device can't be partitioned.  So do it
one partition at a time.

You'll probably only have a few real filesystems on the disk image
anyway.



-- 
Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
The technical we do immediately,  the political takes *forever*
