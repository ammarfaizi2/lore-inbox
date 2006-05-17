Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932415AbWEQBok@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932415AbWEQBok (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 21:44:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932421AbWEQBoj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 21:44:39 -0400
Received: from mail05.syd.optusnet.com.au ([211.29.132.186]:18873 "EHLO
	mail05.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932415AbWEQBoj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 21:44:39 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17514.32708.282431.544415@wombat.chubb.wattle.id.au>
Date: Wed, 17 May 2006 11:43:32 +1000
From: Peter Chubb <peterc@gelato.unsw.edu.au>
To: Andi Kleen <ak@suse.de>
Cc: Peter Chubb <peterc@gelato.unsw.edu.au>, Arnd Bergmann <arnd@arndb.de>,
       Martin Peschke <mp3@de.ibm.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, hch@infradead.org, arjan@infradead.org,
       James.Smart@emulex.com, James.Bottomley@steeleye.com
Subject: Re: [RFC] [Patch 7/8] statistics infrastructure - exploitation prerequisite
In-Reply-To: <200605170327.52605.ak@suse.de>
References: <446A1023.6020108@de.ibm.com>
	<200605170103.08917.arnd@arndb.de>
	<17514.31511.386806.484792@wombat.chubb.wattle.id.au>
	<200605170327.52605.ak@suse.de>
X-Mailer: VM 7.17 under 21.4 (patch 17) "Jumbo Shrimp" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Andi" == Andi Kleen <ak@suse.de> writes:

Anrd> - do_gettimeofday potentially slow, reliable TOD clock,
Anrd> microsecond resolution
>>  Slow, not necessarily safe to call in IRQ context.

Andi> It's only slow if the platform can't do better. On good hardware
Andi> it is fast. And yes it is safe to call in IRQ
Andi> context. Networking does that all the time.

Thanks for the clarification.

I measured do_gettimeofday on IA64 at around 120 cycles (mind you that
was some time ago now, before the last lot of time function revisions
in the kernel).  Whether that's slow or not depends on your application.

-- 
Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
http://www.ertos.nicta.com.au           ERTOS within National ICT Australia
