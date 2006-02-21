Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161437AbWBUIsN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161437AbWBUIsN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 03:48:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161438AbWBUIsN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 03:48:13 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:1483 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1161437AbWBUIsL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 03:48:11 -0500
Date: Tue, 21 Feb 2006 09:46:31 +0100
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Ulrich Drepper <drepper@redhat.com>, Paul Jackson <pj@sgi.com>,
       Thomas Gleixner <tglx@linutronix.de>,
       Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>
Subject: [patch 0/6] lightweight robust futexes: -V4
Message-ID: <20060221084631.GA5506@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.3
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.3 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.6 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is release -V4 of the "lightweight robust futexes" patchset. The 
patchset can also be downloaded from:

  http://redhat.com/~mingo/lightweight-robust-futexes/

no big changes - docs updates and the tidying of futex_atomic_cmpxchg() 
semantics.

Changes since -V3:

 - added Documentation/robust-futex-ABI.txt (Paul Jackson)

 - fixed two mistakes in Documentation/robust-futexes.txt.
   (found by Paul Jackson)

 - added an explicit access_ok() check to the futex_atomic_cmpxchg()
   function. This is not needed in the place it's currently used (there 
   we have already validated the access_ok() range validity of the 
   userspace pointer), but it's good to do it nevertheless, just in case 
   the function gets used elsewhere in the futex code.

	Ingo
