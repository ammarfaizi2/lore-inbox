Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261893AbTELEva (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 00:51:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261895AbTELEva
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 00:51:30 -0400
Received: from c16410.randw1.nsw.optusnet.com.au ([210.49.25.29]:26083 "EHLO
	mail.chubb.wattle.id.au") by vger.kernel.org with ESMTP
	id S261893AbTELEv3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 00:51:29 -0400
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16063.11081.433006.407544@wombat.chubb.wattle.id.au>
Date: Mon, 12 May 2003 15:04:09 +1000
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Robert Love <rml@tech9.net>, Chris Friesen <cfriesen@nortelnetworks.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: how to measure scheduler latency on powerpc?  realfeel doesn't work due to /dev/rtc issues
In-Reply-To: <493798056@toto.iv>
X-Mailer: VM 7.07 under 21.4 (patch 12) "Portable Code" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "William" == William Lee Irwin, <William> writes:
William> Not at all. Just stamp at wakeup and difference when it runs.


That then doesn't include interrupt latency.  The nice thing about the
amlat tests is that the test predicts when the next interrupt should
occur, then measures the time between that prediction and the process
running in userspace.  If you just timestamp at wakeup, you miss all
the time between interrupt generation and noticing that the process is
to wake up.

--
Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
You are lost in a maze of BitKeeper repositories,   all slightly different.
