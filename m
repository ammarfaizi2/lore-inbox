Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750829AbWAYMBQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750829AbWAYMBQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 07:01:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751125AbWAYMBQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 07:01:16 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:56784 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750829AbWAYMBQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 07:01:16 -0500
Date: Wed, 25 Jan 2006 13:01:17 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH, resent] convert a for (i = 0 ; i < NR_CPUS ; i++) to for_each_cpu(i) in sched_init()
Message-ID: <20060125120117.GB5469@elte.hu>
References: <20060124232406.50abccd1.akpm@osdl.org> <43D73913.9070200@cosmosbay.com> <43D739EF.5000609@cosmosbay.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43D739EF.5000609@cosmosbay.com>
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


* Eric Dumazet <dada1@cosmosbay.com> wrote:

> This one was not triggered by yesterday patch : My test machine doesnt 
> crash when dereferencing (runqueue_t *)0x3420, I wonder why ?

x86 SMP kernels have the NULL page remapped during early bootup.

	Ingo
