Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751940AbWCMLsQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751940AbWCMLsQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 06:48:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751955AbWCMLsQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 06:48:16 -0500
Received: from smtp.osdl.org ([65.172.181.4]:33693 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751940AbWCMLsP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 06:48:15 -0500
Date: Mon, 13 Mar 2006 03:45:35 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-kernel@vger.kernel.org, ak@suse.de, cmm@us.ibm.com,
       pbadari@us.ibm.com
Subject: Re: [discuss] Re: 2.6.16-rc5-mm3: spinlock bad magic on CPU#0 on
 AMD64
Message-Id: <20060313034535.256b5dc2.akpm@osdl.org>
In-Reply-To: <200603131234.08804.rjw@sisk.pl>
References: <200603120024.04938.rjw@sisk.pl>
	<200603121349.32374.rjw@sisk.pl>
	<20060312142654.650b90fb.akpm@osdl.org>
	<200603131234.08804.rjw@sisk.pl>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Rafael J. Wysocki" <rjw@sisk.pl> wrote:
>
> > This should fix:
>  > 
>  > --- devel/fs/ext3/inode.c~ext3-get-blocks-maping-multiple-blocks-at-a-once-journal-reentry-fix	2006-03-12 14:25:04.000000000 -0800
>  > +++ devel-akpm/fs/ext3/inode.c	2006-03-12 14:25:04.000000000 -0800
>  > @@ -830,7 +830,7 @@ ext3_direct_io_get_blocks(struct inode *
>  >  	handle_t *handle = journal_current_handle();
>  >  	int ret = 0;
>  >  
>  > -	if (!handle)
>  > +	if (!create)
>  >  		goto get_block;		/* A read */
>  >  
>  >  	if (max_blocks == 1)
> 
>  Er, it doesn't apply to either 2.6.16-rc5-mm3 or 2.6.16-rc6-mm1.

Nope, it applies OK to rc6-mm1.

But whatever - it's only a single line?
