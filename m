Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264147AbTKLTfa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 14:35:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264256AbTKLTfa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 14:35:30 -0500
Received: from mail009.syd.optusnet.com.au ([211.29.132.64]:39147 "EHLO
	mail009.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S264147AbTKLTfZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 14:35:25 -0500
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16306.35684.471324.582862@wombat.chubb.wattle.id.au>
Date: Thu, 13 Nov 2003 06:35:00 +1100
To: Bernd Schubert <Bernd.Schubert@tc.pci.uni-heidelberg.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2 TB partition support
In-Reply-To: <20031112002811.GA18177@tc.pci.uni-heidelberg.de>
References: <16304.9647.994684.804486@wombat.chubb.wattle.id.au>
	<HBEHKOEIIJKNLNAMLGAOIECPDKAA.info@avistor.com>
	<20031112002811.GA18177@tc.pci.uni-heidelberg.de>
X-Mailer: VM 7.14 under 21.4 (patch 14) "Reasonable Discussion" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Bernd" == Bernd Schubert <Bernd.Schubert@tc.pci.uni-heidelberg.de> writes:

Bernd> On Mon, Nov 10, 2003 at 06:12:06PM -0800, Joseph Shamash wrote:
>> Hello Peter,
>> 
>> Forgive another quick Q or two.
>> 
>> What is the maximum partition size for a patched 2.4.x kernel, and
>> where are those patches?
>> 

Bernd> Hello,

Bernd> Are 2TB possible with an unpatched 2.4.x 64bit-AMD64 kernel? 

On unpatched 2.4, the limit (depending on your driver) for a single
block device is either 2TB-1k or 1TB - 512b.

The 2.4 kernel keeps the block device sizes in an unsigned int, in 1k
units, so the maximum size is (2^32-1)*1k.

I forget which subsystem does it,but one of them tries to keep the
capacity of a disc in an unsigned int in 512byte units; if you're using
that subsystem, the macimum size you can use is (2^31-1)*512b

--
Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
The technical we do immediately,  the political takes *forever*
