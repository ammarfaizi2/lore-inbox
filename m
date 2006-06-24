Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750804AbWFXO5c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750804AbWFXO5c (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 10:57:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752248AbWFXO5c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 10:57:32 -0400
Received: from sj-iport-4.cisco.com ([171.68.10.86]:31067 "EHLO
	sj-iport-4.cisco.com") by vger.kernel.org with ESMTP
	id S1750804AbWFXO5b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 10:57:31 -0400
X-IronPort-AV: i="4.06,172,1149490800"; 
   d="scan'208"; a="1832010963:sNHT35390512"
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       jbeulich@novell.com
Subject: Re: Subject: [PATCH] reintegrate irqreturn.h into hardirq.h
X-Message-Flag: Warning: May contain useful information
References: <Pine.LNX.4.64.0606231943580.12900@scrub.home>
From: Roland Dreier <rdreier@cisco.com>
Date: Sat, 24 Jun 2006 07:57:28 -0700
In-Reply-To: <Pine.LNX.4.64.0606231943580.12900@scrub.home> (Roman Zippel's message of "Fri, 23 Jun 2006 19:45:22 +0200 (CEST)")
Message-ID: <adawtb6k3dz.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 24 Jun 2006 14:57:30.0053 (UTC) FILETIME=[83EBBF50:01C6979E]
Authentication-Results: sj-dkim-5.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > -extern fastcall irqreturn_t handle_IRQ_event(unsigned int irq, struct pt_regs *regs,
 > +extern fastcall int handle_IRQ_event(unsigned int irq, struct pt_regs *regs,
 >  					struct irqaction *action);

This seems like a step backwards: this changes the declaration of
handle_IRQ_event() so it no longer matches the real definition.

 - R.
