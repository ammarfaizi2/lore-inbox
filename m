Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262207AbVCOCbK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262207AbVCOCbK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 21:31:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262208AbVCOCbK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 21:31:10 -0500
Received: from fire.osdl.org ([65.172.181.4]:31638 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262207AbVCOCbB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 21:31:01 -0500
Date: Mon, 14 Mar 2005 18:30:42 -0800
From: Andrew Morton <akpm@osdl.org>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] sparsemem intro patches
Message-Id: <20050314183042.7e7087a2.akpm@osdl.org>
In-Reply-To: <1110834883.19340.47.camel@localhost>
References: <1110834883.19340.47.camel@localhost>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen <haveblue@us.ibm.com> wrote:
>
>  The following four patches provide the last needed changes before the
>  introduction of sparsemem.  For a more complete description of what this
>  will do, please see this patch:
> 
>  http://www.sr71.net/patches/2.6.11/2.6.11-bk7-mhp1/broken-out/B-sparse-150-sparsemem.patch

I don't know what to think about this.  Can you describe sparsemem a little
further, differentiate it from discontigmem and tell us why we want one? 
Is it for memory hotplug?  If so, how does it support hotplug?

To which architectures is this useful, and what is the attitude of the
relevant maintenance teams?

Quoting from the above patch:

> Sparsemem replaces DISCONTIGMEM when enabled, and it is hoped that
> it can eventually become a complete replacement.
> ...
> This patch introduces CONFIG_FLATMEM.  It is used in almost all
> cases where there used to be an #ifndef DISCONTIG, because
> SPARSEMEM and DISCONTIGMEM often have to compile out the same areas
> of code.

Would I be right to worry about increasing complexity, decreased
maintainability and generally increasing mayhem?

If a competent kernel developer who is not familiar with how all this code
hangs together wishes to acquaint himself with it, what steps should he
take?
