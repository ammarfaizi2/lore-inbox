Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932218AbVHHUlS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932218AbVHHUlS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 16:41:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932219AbVHHUlS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 16:41:18 -0400
Received: from tim.rpsys.net ([194.106.48.114]:30363 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S932218AbVHHUlR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 16:41:17 -0400
Subject: Re: 2.6.13-rc3-mm3
From: Richard Purdie <rpurdie@rpsys.net>
To: Christoph Lameter <christoph@lameter.com>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au,
       linux-arm@vger.kernel.org
In-Reply-To: <Pine.LNX.4.62.0508080945100.19665@graphe.net>
References: <20050728025840.0596b9cb.akpm@osdl.org>
	 <1122860603.7626.32.camel@localhost.localdomain>
	 <Pine.LNX.4.62.0508010908530.3546@graphe.net>
	 <1122926537.7648.105.camel@localhost.localdomain>
	 <Pine.LNX.4.62.0508011335090.7011@graphe.net>
	 <1122930474.7648.119.camel@localhost.localdomain>
	 <Pine.LNX.4.62.0508011414480.7574@graphe.net>
	 <1122931637.7648.125.camel@localhost.localdomain>
	 <Pine.LNX.4.62.0508011438010.7888@graphe.net>
	 <1122933133.7648.141.camel@localhost.localdomain>
	 <Pine.LNX.4.62.0508011517300.8498@graphe.net>
	 <1122937261.7648.151.camel@localhost.localdomain>
	 <Pine.LNX.4.62.0508031716001.24733@graphe.net>
	 <1123154825.8987.33.camel@localhost.localdomain>
	 <Pine.LNX.4.62.0508040703300.3277@graphe.net>
	 <1123166252.8987.50.camel@localhost.localdomain>
	 <Pine.LNX.4.62.0508050817060.28659@graphe.net>
	 <1123422275.7800.24.camel@localhost.localdomain>
	 <Pine.LNX.4.62.0508080945100.19665@graphe.net>
Content-Type: text/plain
Date: Mon, 08 Aug 2005 21:40:51 +0100
Message-Id: <1123533651.7716.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-08-08 at 09:48 -0700, Christoph Lameter wrote:
> Ok. So we cannot set the dirty bit.
> 
> Here is a patch that also prints the pte status immediately before 
> ptep_cmpxchg. I guess this will show that dirty bit is already set.
> 
> Does the ARM have some hardware capability to set dirty bits?
> 
> +		printk(KERN_CRIT "cmpxchg fail fault mm=%p vma=%p addr=%lx write=%d ptep=%p pmd=%p entry=%lx new=%lx current=%lx\n",
> +				mm, vma, address, write_access, pte, pmd, pte_val(entry), pte_val(new_entry), *pte);

Ok, this results in:

cmpxchg fail fault mm=c39fc4e0 vma=c2a37bcc addr=4025f000 write=2048
ptep=c2fc197c pmd=c2b91008 entry=88000f7 new=8800077 current=8800077

I'm beginning to understand this code a bit more so I'll see if I can
work out anything myself as well...

Richard

