Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267765AbUG3RnK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267765AbUG3RnK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 13:43:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267762AbUG3RnK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 13:43:10 -0400
Received: from cantor.suse.de ([195.135.220.2]:63402 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S267764AbUG3RnG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 13:43:06 -0400
Date: Fri, 30 Jul 2004 19:43:04 +0200
From: Andi Kleen <ak@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       James.Bottomley@HansenPartnership.com
Subject: Re: [PATCH] Improve pci_alloc_consistent wrapper on preemptive
 kernels
Message-Id: <20040730194304.2c27f48c.ak@suse.de>
In-Reply-To: <410A826C.4000508@pobox.com>
References: <20040730190227.29913e23.ak@suse.de>
	<410A826C.4000508@pobox.com>
X-Mailer: Sylpheed version 0.9.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Jul 2004 13:16:28 -0400
Jeff Garzik <jgarzik@pobox.com> wrote:


> 
> 1) Changing from GFP_ATOMIC to <something else> may break code

x86-64 did it for a long time and I am not aware of problems with it
(however I don't know how widespread CONFIG_PREEMPT use on x86-64 is) 

> 2) Conversely from #1, I also worry why GFP_ATOMIC would be needed at 
> all.  I code all my drivers to require that pci_alloc_consistent() be 
> called from somewhere that is allowed to sleep.

Maybe you do, but others don't.

-Andi
