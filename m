Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267558AbUIOVcs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267558AbUIOVcs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 17:32:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267505AbUIOV1U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 17:27:20 -0400
Received: from fw.osdl.org ([65.172.181.6]:4525 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267545AbUIOVZg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 17:25:36 -0400
Date: Wed, 15 Sep 2004 14:29:22 -0700
From: Andrew Morton <akpm@osdl.org>
To: hari@in.ibm.com
Cc: linux-kernel@vger.kernel.org, fastboot@osdl.org, suparna@in.ibm.com,
       mbligh@aracnet.com, ebiederm@xmission.com, litke@us.ibm.com
Subject: Re: [PATCH][5/6]ELF format dump file access
Message-Id: <20040915142922.630edc1a.akpm@osdl.org>
In-Reply-To: <20040915125631.GF15450@in.ibm.com>
References: <20040915125041.GA15450@in.ibm.com>
	<20040915125145.GB15450@in.ibm.com>
	<20040915125322.GC15450@in.ibm.com>
	<20040915125422.GD15450@in.ibm.com>
	<20040915125525.GE15450@in.ibm.com>
	<20040915125631.GF15450@in.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hariprasad Nellitheertha <hari@in.ibm.com> wrote:
>
> +#ifdef CONFIG_CRASH_DUMP
> +	if (dump_enabled) {
> +		proc_vmcore = create_proc_entry("vmcore", S_IRUSR, NULL);
> +		if (proc_vmcore) {
> +			proc_vmcore->proc_fops = &proc_vmcore_operations;
> +			proc_vmcore->size =
> +			(size_t)(saved_max_pfn << PAGE_SHIFT);
> +		}
> +	}
> +#endif

Again, please try to move this out of procfs and into a crashdump-specific file.
