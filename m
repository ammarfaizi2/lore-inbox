Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263274AbTKJX4l (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 18:56:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263290AbTKJX4l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 18:56:41 -0500
Received: from mail001.syd.optusnet.com.au ([211.29.132.142]:43721 "EHLO
	mail001.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S263274AbTKJX4k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 18:56:40 -0500
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16304.9647.994684.804486@wombat.chubb.wattle.id.au>
Date: Tue, 11 Nov 2003 10:56:31 +1100
To: "Joseph Shamash" <info@avistor.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: 2 TB partition support
In-Reply-To: <HBEHKOEIIJKNLNAMLGAOKECHDKAA.info@avistor.com>
References: <HBEHKOEIIJKNLNAMLGAOKECHDKAA.info@avistor.com>
X-Mailer: VM 7.14 under 21.4 (patch 14) "Reasonable Discussion" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Joseph" == Joseph Shamash <info@avistor.com> writes:

Joseph> Hello,

Joseph> I'm wondering if I can create a 2 TB partition using linux
Joseph> systems. If so, do I need any special patches?

Yes you can do it.

You need a 2.6 kernel.  And it's best to use something other than the
MSDOS partition format --- I suggest you use parted to create a GPT
partition table (which means compiling your kernel to understand that
format).

You didn't say what architecture you're running on.  If it's a 64-bit
system you don't have to do anything else.  If it's a 32-bit system,
then turn on CONFIG_LBD when you compile.

--
Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
The technical we do immediately,  the political takes *forever*
