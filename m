Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266332AbUBLLNP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 06:13:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266354AbUBLLNP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 06:13:15 -0500
Received: from fw.osdl.org ([65.172.181.6]:44009 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266332AbUBLLNN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 06:13:13 -0500
Date: Thu, 12 Feb 2004 03:13:22 -0800
From: Andrew Morton <akpm@osdl.org>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.3-rc2-mm1
Message-Id: <20040212031322.742b29e7.akpm@osdl.org>
In-Reply-To: <20040212015710.3b0dee67.akpm@osdl.org>
References: <20040212015710.3b0dee67.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:
>
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.3-rc2/2.6.3-rc2-mm1/

This kernel and also 2.6.3-rc1-mm1 have a nasty bug which causes
current->preempt_count to be decremented by one on each hard IRQ.  It
manifests as a BUG() in the slab code early in boot.

Disabling CONFIG_DEBUG_SPINLOCK_SLEEP will fix this up.  Do not use this
feature on ia32, for it is bust.

