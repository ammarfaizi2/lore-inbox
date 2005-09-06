Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751069AbVIFWdF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751069AbVIFWdF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 18:33:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751071AbVIFWdF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 18:33:05 -0400
Received: from smtp.istop.com ([66.11.167.126]:58252 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S1751069AbVIFWdE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 18:33:04 -0400
From: Daniel Phillips <phillips@istop.com>
To: Andi Kleen <ak@suse.de>
Subject: Re: RFC: i386: kill !4KSTACKS
Date: Tue, 6 Sep 2005 18:36:07 -0400
User-Agent: KMail/1.8
Cc: Giridhar Pemmasani <giri@lmc.cs.sunysb.edu>, linux-kernel@vger.kernel.org
References: <20050904145129.53730.qmail@web50202.mail.yahoo.com> <200509061819.45567.phillips@istop.com> <200509070021.29959.ak@suse.de>
In-Reply-To: <200509070021.29959.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509061836.07813.phillips@istop.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 06 September 2005 18:21, Andi Kleen wrote:
> On Wednesday 07 September 2005 00:19, Daniel Phillips wrote:
> > Andi, their stack will have to have a valid thread_info->task because
> > interrupts will use it.  Out of interest, could you please explain what
> > for?
>
> No, with 4k interrupts run on their own stack with their own thread_info
> Or rather they mostly do. Currently do_IRQ does irq_enter which refers
> thread_info before switching to the interrupt stack, that order would
> likely need to be exchanged.

But then how would thread_info->task on the irq stack ever get initialized?

My "what for" question was re why interrupt routines even need a valid 
current.  I see one answer out there on the web: statistical profiling.  Is 
that it?

Regards,

Daniel
