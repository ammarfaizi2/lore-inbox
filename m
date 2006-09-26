Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751197AbWIZMWq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751197AbWIZMWq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 08:22:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751199AbWIZMWq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 08:22:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:30613 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751197AbWIZMWp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 08:22:45 -0400
To: OGAWA Hirofumi <hogawa@miraclelinux.com>
Cc: linux-kernel@vger.kernel.org, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Subject: Re: [PATCH] arch/i386/pci/mmconfig.c tlb flush fix
References: <lry7s7t1su.fsf@dhcp-0242.miraclelinux.com>
From: Andi Kleen <ak@suse.de>
Date: 26 Sep 2006 14:22:29 +0200
In-Reply-To: <lry7s7t1su.fsf@dhcp-0242.miraclelinux.com>
Message-ID: <p73y7s6kebe.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OGAWA Hirofumi <hogawa@miraclelinux.com> writes:

> Hi,
> 
> We use the fixmap for accessing pci config space in pci_mmcfg_read/write().
> The problem is in pci_exp_set_dev_base(). It is caching a last
> accessed address to avoid calling set_fixmap_nocache() whenever
> pci_mmcfg_read/write() is used.


Good catch. I already had another report of mmconfig corruption on i386,
but didn't have time to look at it yet.

Will be definitely stable material once it hit mainline.

-Andi
