Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265270AbUBPAGi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 19:06:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265276AbUBPAGi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 19:06:38 -0500
Received: from mail004.syd.optusnet.com.au ([211.29.132.145]:14561 "EHLO
	mail004.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S265270AbUBPAGc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 19:06:32 -0500
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16432.2241.906730.769445@wombat.chubb.wattle.id.au>
Date: Mon, 16 Feb 2004 11:03:13 +1100
To: davidm@hpl.hp.com
Cc: Herbert Poetzl <herbert@13thfloor.at>, linux-kernel@vger.kernel.org,
       linux-gcc@vger.kernel.org
Subject: Re: Kernel Cross Compiling
In-Reply-To: <16429.16944.521739.223708@napali.hpl.hp.com>
References: <20040213205743.GA30245@MAIL.13thfloor.at>
	<16429.16944.521739.223708@napali.hpl.hp.com>
X-Mailer: VM 7.17 under 21.4 (patch 14) "Reasonable Discussion" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "David" == David Mosberger <davidm@napali.hpl.hp.com> writes:

>>>>> On Fri, 13 Feb 2004 21:57:43 +0100, Herbert Poetzl <herbert@13thfloor.at> said:
Herbert> I got all headers fixed, except for the ia64, which still
Herbert> doesn't work

David> Something sounds wrong here. You shouldn't have to patch
David> headers.

David> A recipe for building ia32->ia64 cross-toolchain on Debian can
David> be found here:

David>  http://www.gelato.unsw.edu.au/IA64wiki/CrossCompilation

He's trying to use gcc 3.3.2 which isn't packaged in toolchain-source
yet.  And he's running on a RedHat-like system.

And there's currently a problem:  To build gcc you need access to an
appropriate libc6 header package; dpkg-cross refuses to install one
without linux-kernel-headers-cross-ia64; but will also not install
linux-kernel-headers.  You need the patch at
http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=222168

Peter C
