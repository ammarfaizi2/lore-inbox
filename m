Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263332AbVGANPv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263332AbVGANPv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 09:15:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263333AbVGANPv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 09:15:51 -0400
Received: from cantor.suse.de ([195.135.220.2]:44266 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S263332AbVGANPq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 09:15:46 -0400
To: "liyu@WAN" <liyu@ccoss.com.cn>
Cc: linux-kernel@vger.kernel.org
Subject: Re: one question about pgd allocation
References: <42C53E7D.7090404@ccoss.com.cn.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 01 Jul 2005 15:15:43 +0200
In-Reply-To: <42C53E7D.7090404@ccoss.com.cn.suse.lists.linux.kernel>
Message-ID: <p73k6kafz0g.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"liyu@WAN" <liyu@ccoss.com.cn> writes:
> 
>     I can not understand this. I search intel developer mannal. but
> nothing to help.
> Who can tell me why?

bit 0 is the present bit which needs to be set on the PGD, otherwise
the CPU will ignore it. A clearer way to write this would have been

        __pgd(__pa(pmd) | _PAGE_PRESENT)

-Andi
