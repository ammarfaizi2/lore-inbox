Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261585AbTKTKXU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 05:23:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261613AbTKTKXU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 05:23:20 -0500
Received: from mail1.cc.huji.ac.il ([132.64.1.17]:50882 "EHLO
	mail1.cc.huji.ac.il") by vger.kernel.org with ESMTP id S261585AbTKTKXR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 05:23:17 -0500
Message-ID: <3FBC9604.1020007@mscc.huji.ac.il>
Date: Thu, 20 Nov 2003 12:23:00 +0200
From: Voicu Liviu <pacman@mscc.huji.ac.il>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030906
X-Accept-Language: en-us, en, he
MIME-Version: 1.0
Cc: linux-kernel@vger.kernel.org, kerin@recruit2recruit.net
Subject: Re: 2.6.0-test9-mm4 (only) and vmware
References: <20031119181518.0a43c673.vmlinuz386@yahoo.com.ar> <20031119223425.GA20549@64m.dyndns.org> <20031120014718.GA22764@holomorphy.com> <20031119232246.GA20840@64m.dyndns.org> <20031120023457.GC22764@holomorphy.com> <20031119234037.GC20840@64m.dyndns.org> <20031120025730.GD22764@holomorphy.com> <3FBC917E.7090506@mscc.huji.ac.il> <20031120101830.GH22764@holomorphy.com>
In-Reply-To: <20031120101830.GH22764@holomorphy.com>
X-Enigmail-Version: 0.76.4.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:

>On Thu, Nov 20, 2003 at 12:03:42PM +0200, Voicu Liviu wrote:
>  
>
>>May I have the patch of this vmware fix to run a few tests?
>>Best regards,
>>    
>>
>
>Here you go.
>
I really appreciate your quick reply, will this also work with -bk24 branch?
Thank you

>
>
>-- wli
>
>
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
>  
>


-- 
Liviu Voicu
Assistant Programmer and network support
Computation Center, Mount Scopus
Hebrew University of Jerusalem
Tel: 972(2)-5881253
E-mail: "Liviu Voicu"<pacman@mscc.huji.ac.il>

/**
 * cat /usr/src/linux/arch/i386/boot/bzImage > /dev/dsp
 * ( and the voice of God will be heard! )
 *
 */

Click here to see my GPG signature:
----------------------------------
	http://search.keyserver.net:11371/pks/lookup?template=netensearch%2Cnetennomatch%2Cnetenerror&search=pacman%40mscc.huji.ac.il&op=vindex&fingerprint=on&submit=Get+List


