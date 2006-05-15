Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932443AbWEOTA3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932443AbWEOTA3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 15:00:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932502AbWEOTA2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 15:00:28 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:990 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932443AbWEOS7t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 14:59:49 -0400
Date: Mon, 15 May 2006 20:59:46 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, apw@shadowen.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86 NUMA panic compile error
Message-ID: <20060515185945.GA20215@elte.hu>
References: <20060515005637.00b54560.akpm@osdl.org> <20060515182855.GB18652@elte.hu> <20060515115208.57a11dcb.akpm@osdl.org> <200605152056.27702.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200605152056.27702.ak@suse.de>
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


* Andi Kleen <ak@suse.de> wrote:

> 
> > But still, referencing a variable which is implemented in
> > arch/i386/kernel/timers/timer_cyclone.c from within arch/i386/kernel/srat.c
> > is asking for trouble, no?
> 
> Probably, but where would you define it instead? It kind of belongs 
> into timer_cyclone.c

there should be a asm-i386/cyclone.h that properly defines this. (and to 
make things more consistent, it could make it 0 even if 
!CONFIG_X86_CYCLONE_TIMER)

	Ingo
