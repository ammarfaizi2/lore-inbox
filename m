Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261422AbUCIAuE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 19:50:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261425AbUCIAuE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 19:50:04 -0500
Received: from mail004.syd.optusnet.com.au ([211.29.132.145]:63940 "EHLO
	mail004.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261422AbUCIAuB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 19:50:01 -0500
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16461.5298.914057.953749@wombat.chubb.wattle.id.au>
Date: Tue, 9 Mar 2004 11:49:54 +1100
To: bluefoxicy@linux.net
CC: linux-kernel@vger.kernel.org
Subject: Re: Kernel-User shared buffer
In-Reply-To: <819206922@toto.iv>
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "john" == john moser <bluefoxicy@linux.net> writes:

john> Hi.  I'm trying to create a shared buffer for realtime
john> communication between the kernel and a userspace application.
john> All allocation is done for the userspace task in the kernel, and
john> the kernel is to write to the ram from within syscalls made by
john> other processes.

It's easier to go the other way.  Get your application to map the
buffer from a filesystem that you provide.  See, e.g., the code in
arch/ia64/kernel/perfmon.c.

--
Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
The technical we do immediately,  the political takes *forever*

