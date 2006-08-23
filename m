Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965293AbWHWXHL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965293AbWHWXHL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 19:07:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965295AbWHWXHL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 19:07:11 -0400
Received: from smtp.osdl.org ([65.172.181.4]:14283 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965293AbWHWXHK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 19:07:10 -0400
Date: Wed, 23 Aug 2006 15:57:24 -0700
From: Andrew Morton <akpm@osdl.org>
To: Stephane Eranian <eranian@frankl.hpl.hp.com>
Cc: linux-kernel@vger.kernel.org, eranian@hpl.hp.com
Subject: Re: [PATCH 10/18] 2.6.17.9 perfmon2 patch for review: PMU context
 switch support
Message-Id: <20060823155724.505fb979.akpm@osdl.org>
In-Reply-To: <200608230806.k7N86151000456@frankl.hpl.hp.com>
References: <200608230806.k7N86151000456@frankl.hpl.hp.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Aug 2006 01:06:01 -0700
Stephane Eranian <eranian@frankl.hpl.hp.com> wrote:

> +#define PFM_LAST_CPU(ctx, act) \
> +	((ctx)->last_cpu == smp_processor_id() && (ctx)->last_act == act)

Hiding this in a macro rather invites mistakes.  Has all this code been
thoroughly tested with CONFIG_DEBUG_PREEMPT, to detect use of
smp_processor_id() in preemptible code?
