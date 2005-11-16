Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965160AbVKPBxL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965160AbVKPBxL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 20:53:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965161AbVKPBxK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 20:53:10 -0500
Received: from mail06.syd.optusnet.com.au ([211.29.132.187]:1455 "EHLO
	mail06.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S965160AbVKPBxJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 20:53:09 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17274.37097.609985.45439@wombat.chubb.wattle.id.au>
Date: Wed, 16 Nov 2005 12:52:41 +1100
From: Peter Chubb <peterc@gelato.unsw.edu.au>
To: nagar@watson.ibm.com
Cc: Peter Chubb <peterc@gelato.unsw.edu.au>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Andi Kleen <ak@suse.de>
Subject: Re: [Patch 1/4] Delay accounting: Initialization
In-Reply-To: <437A8FED.3080508@watson.ibm.com>
References: <43796596.2010908@watson.ibm.com>
	<20051114202017.6f8c0327.akpm@osdl.org>
	<17274.34333.348600.111728@wombat.chubb.wattle.id.au>
	<437A8FED.3080508@watson.ibm.com>
X-Mailer: VM 7.17 under 21.4 (patch 17) "Jumbo Shrimp" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Shailabh" == Shailabh Nagar <nagar@watson.ibm.com> writes:

Shailabh> Peter Chubb wrote:
>>>>>>> "Andrew" == Andrew Morton <akpm@osdl.org> writes:
>>
Andrew> Shailabh Nagar <nagar@watson.ibm.com> wrote:
>>
>>>> + *ts = sched_clock();
>>
Andrew> I'm not sure that it's kosher to use sched_clock() for
Andrew> fine-grained timestamping like this.  Ingo had issues with it
Andrew> last time this happened?
>>  It wasn't Ingo, it was Andi Kleen...  for my Microstate Accounting
>> patches, which do very similar things to Shailabh's patchsetm, but
>> using /proc and a system call instead (following Solaris's lead)
>> 

Shailabh> Were these the comments from Andi to which you refer:
Shailabh> http://www.uwsg.indiana.edu/hypermail/linux/kernel/0503.1/1237.html

Shailabh> The objections to microstate overhead seemed to stem from
Shailabh> the syscall overhead, not use of sched_clock() per se.

The objection was to the use of rdtsc (which is sched_clock() on
platforms that have rdtsc) in fastpaths.


Anyway, I think it's time to repost the microstate patches.
-- 
Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
The technical we do immediately,  the political takes *forever*
