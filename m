Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261467AbVCMVse@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261467AbVCMVse (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 16:48:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261469AbVCMVsd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 16:48:33 -0500
Received: from fire.osdl.org ([65.172.181.4]:5541 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261467AbVCMVsb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 16:48:31 -0500
Date: Sun, 13 Mar 2005 13:48:02 -0800
From: Andrew Morton <akpm@osdl.org>
To: Roland McGrath <roland@redhat.com>
Cc: ak@suse.de, linux-kernel@vger.kernel.org, jkenisto@us.ibm.com,
       PRASANNA@in.ibm.com
Subject: Re: [PATCH] x86-64 kprobes: handle %RIP-relative addressing mode
Message-Id: <20050313134802.28d59568.akpm@osdl.org>
In-Reply-To: <200503130954.j2D9sgjB028594@magilla.sf.frob.com>
References: <200503130954.j2D9sgjB028594@magilla.sf.frob.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland McGrath <roland@redhat.com> wrote:
>
> +	area = __get_vm_area(0, VM_ALLOC, MODULES_END, 0ULL - PAGE_SIZE);

The longlong here seems wrong?  If this is to mean "the top of the address
space minus a page" then unsigned long is the appropriate type.

