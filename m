Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262269AbVCVLlV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262269AbVCVLlV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 06:41:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262386AbVCVLlV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 06:41:21 -0500
Received: from fire.osdl.org ([65.172.181.4]:64726 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262269AbVCVLlR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 06:41:17 -0500
Date: Tue, 22 Mar 2005 03:40:53 -0800
From: Andrew Morton <akpm@osdl.org>
To: Hugh Dickins <hugh@veritas.com>
Cc: nickpiggin@yahoo.com.au, davem@davemloft.net, tony.luck@intel.com,
       benh@kernel.crashing.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] freepgt: free_pgtables use vma list
Message-Id: <20050322034053.311b10e6.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0503212048040.1970@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0503212048040.1970@goblin.wat.veritas.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


With these six patches the ppc64 is hitting the BUG in exit_mmap():

        BUG_ON(mm->nr_ptes);    /* This is just debugging */

fairly early in boot.
