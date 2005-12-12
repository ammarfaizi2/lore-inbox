Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751206AbVLLRLt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751206AbVLLRLt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 12:11:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751268AbVLLRLs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 12:11:48 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:6560 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751206AbVLLRLs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 12:11:48 -0500
Subject: Re: Kernel BUG at arch/x86_64/mm/pageattr.c:154
From: Arjan van de Ven <arjan@infradead.org>
To: Kasper Sandberg <lkml@metanurb.dk>
Cc: LKML Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <1134406398.4953.3.camel@localhost>
References: <1134406398.4953.3.camel@localhost>
Content-Type: text/plain
Date: Mon, 12 Dec 2005 18:11:44 +0100
Message-Id: <1134407505.2874.21.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 1.8 (+)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (1.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[213.93.14.173 listed in dnsbl.sorbs.net]
	1.7 RCVD_IN_NJABL_DUL      RBL: NJABL: dialup sender did non-local SMTP
	[213.93.14.173 listed in combined.njabl.org]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-12-12 at 17:53 +0100, Kasper Sandberg wrote:
> hello... i know my kernel is tainted,

...

> Call Trace:<ffffffff80101810>{init_level4_pgt+2064}
> <ffffffff8011e31b>{change_page_attr_addr+155}
>        <ffffffff88479947>{:nvidia:nv_vm_free_pages+274}
> <ffffffff88475b44>{:nvidia:nv_kern_vma_release+126}
>        <ffffffff8015f80c>{remove_vma+44} <ffffffff8015fd78>{exit_mmap
> +184}
>        <ffffffff8012c37b>{mmput+27} <ffffffff80130633>{do_exit+547}
>        <ffffffff80131029>{do_group_exit+169}
> <ffffffff8010e96e>{system_call+126}

... and the nvidia module is all over the backtrace. I think this is a
clear one for reporting to nvidia instead....

