Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264276AbTKLTh1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 14:37:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264283AbTKLTh0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 14:37:26 -0500
Received: from mail010.syd.optusnet.com.au ([211.29.132.56]:58598 "EHLO
	mail010.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S264276AbTKLThZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 14:37:25 -0500
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16306.35809.15450.378197@wombat.chubb.wattle.id.au>
Date: Thu, 13 Nov 2003 06:37:05 +1100
To: Andi Kleen <ak@muc.de>
Cc: Bernd Schubert <Bernd.Schubert@tc.pci.uni-heidelberg.de>,
       linux-kernel@vger.kernel.org
Subject: Re: 2 TB partition support
In-Reply-To: <m3d6bybeiw.fsf@averell.firstfloor.org>
References: <QugF.3Mq.7@gated-at.bofh.it>
	<Qwit.771.11@gated-at.bofh.it>
	<QR40.39P.53@gated-at.bofh.it>
	<m3d6bybeiw.fsf@averell.firstfloor.org>
X-Mailer: VM 7.14 under 21.4 (patch 14) "Reasonable Discussion" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Andi" == Andi Kleen <ak@muc.de> writes:

Andi> Bernd Schubert <Bernd.Schubert@tc.pci.uni-heidelberg.de> writes:
>> Are 2TB possible with an unpatched 2.4.x 64bit-AMD64 kernel? The
>> partion is supposed to be reiserfs. I read an about 2 years old
>> discussion about this and Hans Reiser statet that the maximum size
>> is about 2GB. Unfortunality I don't know what this 'about' depends
>> on.  Furthermore our server for this will be an Opteron and so
>> perhaps this limit is much higher on 64bit systems.

Andi> In theory yes, but note that nobody tested the drivers for 64bit
Andi> cleanness in block numbers. I would do careful testing first if
Andi> your block driver supports
>> 2TB.

Has the kmalloc problem in Reiserfs gone away?  It used to be that the
limit for a Reiser filesystem was determined by how many pointers
could fit into a kmalloced chunk of memory; thus the 64-bit system
limit was half teh 32-bit system limit.

--
Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
The technical we do immediately,  the political takes *forever*
