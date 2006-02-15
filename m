Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932226AbWBOW6L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932226AbWBOW6L (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 17:58:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932163AbWBOW6L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 17:58:11 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:8625 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932226AbWBOW6J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 17:58:09 -0500
Date: Wed, 15 Feb 2006 23:56:27 +0100
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Ulrich Drepper <drepper@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
       Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>
Subject: [patch 0/5] lightweight robust futexes: -V2
Message-ID: <20060215225627.GA5599@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is release -V2 of the "lightweight robust futexes" patchset.
The patchset can also be downloaded from:

  http://redhat.com/~mingo/lightweight-robust-futexes/

one detail i forgot to mention before is the .text effect of the 
feature:

    text    data     bss     dec     hex filename
 4698410  983432  798248 6480090  62e0da vmlinux.orig
 4700692  983504  798248 6482444  62ea0c vmlinux.vma-based    +2282 bytes
 4698941  983540  798248 6480729  62e359 vmlinux.list-based   +531 bytes

so we can get a more complete solution for a fourth of the .text size.

Changes since -V1:

 - fixed FUTEX=n build errors (found by Andrew Morton)

 - fixed patch ordering and other dependencies, so that at every step, 
   the kernel builds and boots fine with FUTEX=y and FUTEX=n.
   (found by Andrew Morton)

	Ingo
