Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932724AbWAHMJz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932724AbWAHMJz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 07:09:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932725AbWAHMJz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 07:09:55 -0500
Received: from mtagate1.de.ibm.com ([195.212.29.150]:15299 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S932724AbWAHMJy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 07:09:54 -0500
Date: Sun, 8 Jan 2006 13:09:48 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Dave McCracken <dmccr@us.ibm.com>
Cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [PATCH/RFC] Shared page tables
Message-ID: <20060108120948.GA10688@osiris.ibm.com>
References: <A6D73CCDC544257F3D97F143@[10.1.1.4]> <20060107122534.GA20442@osiris.boeblingen.de.ibm.com> <2796BAF66E63B415FF1929B8@[10.1.1.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2796BAF66E63B415FF1929B8@[10.1.1.4]>
User-Agent: mutt-ng/devel (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Tried to get this running with CONFIG_PTSHARE and CONFIG_PTSHARE_PTE on
> > s390x. Unfortunately it crashed on boot, because pt_share_pte
> > returned a broken pte pointer:
> 
> The patch as submitted only works on i386 and x86_64.  Sorry.

That's why I added what seems to be needed for s390. For CONFIG_PTSHARE and
CONFIG_PTSHARE_PTE it's just a slightly modified Kconfig file.
For CONFIG_PTSHARE_PMD it involves adding a few more pud_* defines to
asm-generic/4level-fixup.h.
Seems to work with the pmd/pud_clear changes as far as I can tell.

Just tested this out of curiousity :)

Thanks,
Heiko
