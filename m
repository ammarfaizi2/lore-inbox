Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262712AbUKRKXg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262712AbUKRKXg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 05:23:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262715AbUKRKWd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 05:22:33 -0500
Received: from fw.osdl.org ([65.172.181.6]:7396 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262712AbUKRKOo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 05:14:44 -0500
Date: Thu, 18 Nov 2004 02:14:19 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Ian Pratt" <m+Ian.Pratt@cl.cam.ac.uk>
Cc: Keir.Fraser@cl.cam.ac.uk, haveblue@us.ibm.com, Ian.Pratt@cl.cam.ac.uk,
       linux-kernel@vger.kernel.org, Christian.Limpach@cl.cam.ac.uk
Subject: Re: [patch 2] Xen core patch : arch_free_page return value
Message-Id: <20041118021419.0c0d1dad.akpm@osdl.org>
In-Reply-To: <A95E2296287EAD4EB592B5DEEFCE0E9D122E52@liverpoolst.ad.cl.cam.ac.uk>
References: <A95E2296287EAD4EB592B5DEEFCE0E9D122E52@liverpoolst.ad.cl.cam.ac.uk>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Ian Pratt" <m+Ian.Pratt@cl.cam.ac.uk> wrote:
>
> We forwarded the patches around
>  so many different people for comment before sending them to lkml that
>  somewhere along the line something bad happned.

Just send 'em to linux-kernel first-up and cc everyone else.  That way you
avoid duplication of effort and everyone is on the same page.

I'm still struggling to understand the rationale behind the mem.c change
btw.  io_remap_page_range() _is_ remap_page_range() (or, now,
remap_pfn_range()) on x86.  So whatever the patch is supposed to be doing,
it's a no-op.

