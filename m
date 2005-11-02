Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932461AbVKBGse@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932461AbVKBGse (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 01:48:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932462AbVKBGse
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 01:48:34 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:9164 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932461AbVKBGsd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 01:48:33 -0500
Date: Wed, 2 Nov 2005 07:48:54 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpu hoptlug: avoid usage of smp_processor_id() in preemptible code
Message-ID: <20051102064854.GB943@elte.hu>
References: <20051101145402.GA20255@osiris.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051101145402.GA20255@osiris.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Heiko Carstens <heiko.carstens@de.ibm.com> wrote:

> From: Heiko Carstens <heiko.carstens@de.ibm.com>
> 
> Replace smp_processor_id() with any_online_cpu(cpu_online_map) in 
> order to avoid lots of "BUG: using smp_processor_id() in preemptible 
> [00000001] code:..." messages in case taking a cpu online fails.

could you post the full message, including the stacktrace? I think this 
patch just works around the debugging message, and there might be some 
real bug to fix.

	Ingo
