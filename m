Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261637AbVASJXW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261637AbVASJXW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 04:23:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261663AbVASJWd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 04:22:33 -0500
Received: from mail23.syd.optusnet.com.au ([211.29.133.164]:34956 "EHLO
	mail23.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261637AbVASJTE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 04:19:04 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16878.9678.73202.771962@wombat.chubb.wattle.id.au>
Date: Wed, 19 Jan 2005 20:18:06 +1100
From: Peter Chubb <peterc@gelato.unsw.edu.au>
To: Ingo Molnar <mingo@elte.hu>
Cc: Peter Chubb <peterc@gelato.unsw.edu.au>, Tony Luck <tony.luck@intel.com>,
       Darren Williams <dsw@gelato.unsw.edu.au>, Andrew Morton <akpm@osdl.org>,
       Chris Wedgwood <cw@f00f.org>, torvalds@osdl.org,
       benh@kernel.crashing.org, linux-kernel@vger.kernel.org,
       Ia64 Linux <linux-ia64@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: Horrible regression with -CURRENT from "Don't busy-lock-loop in preemptable spinlocks" patch
In-Reply-To: <20050119080403.GB29037@elte.hu>
References: <20050117055044.GA3514@taniwha.stupidest.org>
	<20050116230922.7274f9a2.akpm@osdl.org>
	<20050117143301.GA10341@elte.hu>
	<20050118014752.GA14709@cse.unsw.EDU.AU>
	<16877.42598.336096.561224@wombat.chubb.wattle.id.au>
	<20050119080403.GB29037@elte.hu>
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Ingo" == Ingo Molnar <mingo@elte.hu> writes:

Ingo> * Peter Chubb <peterc@gelato.unsw.edu.au> wrote:

>> Here's a patch that adds the missing read_is_locked() and
>> write_is_locked() macros for IA64.  When combined with Ingo's
>> patch, I can boot an SMP kernel with CONFIG_PREEMPT on.
>> 
>> However, I feel these macros are misnamed: read_is_locked() returns
>> true if the lock is held for writing; write_is_locked() returns
>> true if the lock is held for reading or writing.

Ingo> well, 'read_is_locked()' means: "will a read_lock() succeed"

Fail, surely?

-- 
Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
The technical we do immediately,  the political takes *forever*
