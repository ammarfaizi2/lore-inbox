Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270112AbTGPECP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 00:02:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270114AbTGPECP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 00:02:15 -0400
Received: from c210-49-26-171.randw1.nsw.optusnet.com.au ([210.49.26.171]:32421
	"EHLO mail.chubb.wattle.id.au") by vger.kernel.org with ESMTP
	id S270112AbTGPECO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 00:02:14 -0400
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16148.53643.475710.301248@wombat.chubb.wattle.id.au>
Date: Wed, 16 Jul 2003 14:16:11 +1000
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Dave Jones <davej@codemonkey.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5 'what to expect'
In-Reply-To: <20030715170804.GA1089@win.tue.nl>
References: <20030711155613.GC2210@gtf.org>
	<20030711203850.GB20970@win.tue.nl>
	<20030715000331.GB904@matchmail.com>
	<20030715170804.GA1089@win.tue.nl>
X-Mailer: VM 7.14 under 21.4 (patch 13) "Rational FORTRAN" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Andries" == Andries Brouwer <aebr@win.tue.nl> writes:

Andries> On Mon, Jul 14, 2003 at 05:03:31PM -0700, Mike Fedyk wrote:
>> So, will the DOS partition make it up to 2TB?  If so, then we won't
>> have a problem until we have larger than 2TB drives

Andries> Yes, DOS partition table works up to 2^32 sectors, and with
Andries> 2^9-byte sectors that is 2 TiB.

Andries> People are encountering that limit already. We need something
Andries> better, either use some existing scheme, or invent something.

We had this discussion before, back when I first submitted the large
block device patches.  The consensus then was to use EFI, or LDM.

Unless the BIOS supports a partitioning scheme, you're not
going to be able to boot anyway, or at least not without doing
something clever.

--
Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
You are lost in a maze of BitKeeper repositories,   all slightly different.
