Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751158AbWH3Q6I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751158AbWH3Q6I (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 12:58:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751159AbWH3Q6I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 12:58:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:60809 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751158AbWH3Q6F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 12:58:05 -0400
To: Mathieu Desnoyers <compudj@krystal.dyndns.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: arch/x86_64/kernel/traps.c:show_trace should use __kernel_text_address
References: <20060830160214.GA5557@Krystal>
From: Andi Kleen <ak@suse.de>
Date: 30 Aug 2006 18:58:04 +0200
In-Reply-To: <20060830160214.GA5557@Krystal>
Message-ID: <p73u03u5ffn.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mathieu Desnoyers <compudj@krystal.dyndns.org> writes:

> Hi,
> 
> I noticed arch/x86_64/kernel/traps.c:show_trace uses kernel_text_address to
> verify that an address can potentially belong to kernel code. However, this
> version takes a spinlock and should not be called from oops. I think
> __kernel_text_address would be more appropriate there.

Ok I changed it. Thanks

-Andi
