Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750830AbWFXPed@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750830AbWFXPed (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 11:34:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750833AbWFXPed
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 11:34:33 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:7896 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1750830AbWFXPec (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 11:34:32 -0400
Date: Sat, 24 Jun 2006 17:34:21 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Roland Dreier <rdreier@cisco.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       jbeulich@novell.com
Subject: Re: Subject: [PATCH] reintegrate irqreturn.h into hardirq.h
In-Reply-To: <adawtb6k3dz.fsf@cisco.com>
Message-ID: <Pine.LNX.4.64.0606241731340.12900@scrub.home>
References: <Pine.LNX.4.64.0606231943580.12900@scrub.home> <adawtb6k3dz.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 24 Jun 2006, Roland Dreier wrote:

>  > -extern fastcall irqreturn_t handle_IRQ_event(unsigned int irq, struct pt_regs *regs,
>  > +extern fastcall int handle_IRQ_event(unsigned int irq, struct pt_regs *regs,
>  >  					struct irqaction *action);
> 
> This seems like a step backwards: this changes the declaration of
> handle_IRQ_event() so it no longer matches the real definition.

Then it's better to change the definition back as well, we generally want 
to avoid typedefs and this one is only a compatibility typedef meant for 
drivers.

bye, Roman
