Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932285AbVL0Lzo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932285AbVL0Lzo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 06:55:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932296AbVL0Lzo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 06:55:44 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:28103 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932285AbVL0Lzo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 06:55:44 -0500
Date: Tue, 27 Dec 2005 12:55:25 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Nicolas Pitre <nico@cam.org>
Cc: lkml <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [patch 2/3] mutex subsystem: fastpath inlining
Message-ID: <20051227115525.GC23587@elte.hu>
References: <20051223161649.GA26830@elte.hu> <Pine.LNX.4.64.0512261414300.1496@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0512261414300.1496@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -1.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.8 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	1.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Nicolas Pitre <nico@cam.org> wrote:

> Some architectures, notably ARM for instance, might benefit from 
> inlining the mutex fast paths. [...]

what is the effect on text size? Could you post the before- and 
after-patch vmlinux 'size kernel/test.o' output in the nondebug case, 
with Arjan's latest 'convert a couple of semaphore users to mutexes' 
patch applied? [make sure you've got enough of those users compiled in, 
so that the inlining cost is truly measured. Perhaps also do 
before/after 'size' output of a few affected .o files, without mixing 
kernel/mutex.o into it, like vmlinux does.]

	Ingo
