Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261344AbTKTEk0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 23:40:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261368AbTKTEk0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 23:40:26 -0500
Received: from smtp014.mail.yahoo.com ([216.136.173.58]:29882 "HELO
	smtp014.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261344AbTKTEkY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 23:40:24 -0500
Date: Thu, 20 Nov 2003 01:39:08 -0300
From: Gerardo Exequiel Pozzi <vmlinuz386@yahoo.com.ar>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: akpm@osdl.org, linux-kernel@24x7linux.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test9-mm4 (only) and vmware
Message-Id: <20031120013908.4253c191.vmlinuz386@yahoo.com.ar>
In-Reply-To: <20031120021258.GB22764@holomorphy.com>
References: <20031119181518.0a43c673.vmlinuz386@yahoo.com.ar>
	<20031120002119.GA7875@localhost>
	<20031119170233.2619ba81.akpm@osdl.org>
	<20031120011209.GZ22764@holomorphy.com>
	<20031119175803.65d7dc99.akpm@osdl.org>
	<20031120021258.GB22764@holomorphy.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i486-slackware-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Nov 2003 18:12:58 -0800, William Lee Irwin III wrote:
>William Lee Irwin III <wli@holomorphy.com> wrote:
>diff -prauN mm4-2.6.0-test9-1/mm/memory.c mm4-2.6.0-test9-default-2/mm/memory.c
>--- mm4-2.6.0-test9-1/mm/memory.c	2003-11-19 00:07:15.000000000 -0800
>+++ mm4-2.6.0-test9-default-2/mm/memory.c	2003-11-19 18:08:49.000000000 -0800
>@@ -1424,7 +1424,7 @@ do_no_page(struct mm_struct *mm, struct 
> 	pte_t entry;
> 	struct pte_chain *pte_chain;
> 	int sequence = 0;
>-	int ret;
>+	int ret = VM_FAULT_MINOR;
> 
> 	if (!vma->vm_ops || !vma->vm_ops->nopage)
> 		return do_anonymous_page(mm, vma, page_table,
>-

Applied this only against 2.6.0-test9-mm4 and vmware now works OK!
Not applied the previous change in mm/fault.c and mm/memory.c .

Thanks :P


chau,
 djgera


-- 
Gerardo Exequiel Pozzi ( djgera )
http://www.vmlinuz.com.ar http://www.djgera.com.ar
KeyID: 0x1B8C330D
Key fingerprint = 0CAA D5D4 CD85 4434 A219  76ED 39AB 221B 1B8C 330D
