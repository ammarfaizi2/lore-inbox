Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932405AbWEQBPH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932405AbWEQBPH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 21:15:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932407AbWEQBPG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 21:15:06 -0400
Received: from mail07.syd.optusnet.com.au ([211.29.132.188]:17854 "EHLO
	mail07.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932405AbWEQBPF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 21:15:05 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17514.30904.648888.894039@wombat.chubb.wattle.id.au>
Date: Wed, 17 May 2006 11:13:28 +1000
From: Peter Chubb <peterc@gelato.unsw.edu.au>
To: Martin Peschke <mp3@de.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, ak@suse.de,
       hch@infradead.org, arjan@infradead.org, James.Smart@emulex.com,
       James.Bottomley@steeleye.com
Subject: Re: [RFC] [Patch 7/8] statistics infrastructure - exploitation prerequisite
In-Reply-To: <446A53DE.6060400@de.ibm.com>
References: <446A1023.6020108@de.ibm.com>
	<20060516112824.39b49563.akpm@osdl.org>
	<446A53DE.6060400@de.ibm.com>
X-Mailer: VM 7.17 under 21.4 (patch 17) "Jumbo Shrimp" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Martin" == Martin Peschke <mp3@de.ibm.com> writes:


Martin> I would be happy to exploit an API that may result from that
Martin> discussion.  I would plead for exporting such an API to
Martin> modules. I don't see how to implement statistics for
Martin> latencies, otherwise.

Martin> Any other hints on how to replace my sched_clock() calls are
Martin> welcome.  (I want to measure elapsed times in units that are
Martin> understandable to users without hardware manuals and
Martin> calculator, such as milliseconds.)

You may wish to look at the microstate accounting patches at
http://www.gelato.unsw.edu.au/cgi-bin/viewcvs.cgi/cvs/kernel/microstate/
I made the clock source configurable.

It's acually rather difficult to find a reliable cross-platform
monotonic clock with good resolution.  And different statistics may
want different clocks; for my purposes a cycle counter is best
(because I'm running on a machine that varies the clock speed for
power management reasons), other people may want nanoseconds.

-- 
Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
http://www.ertos.nicta.com.au           ERTOS within National ICT Australia
