Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267446AbUHPGAX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267446AbUHPGAX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 02:00:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267451AbUHPGAX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 02:00:23 -0400
Received: from fw.osdl.org ([65.172.181.6]:54715 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267446AbUHPGAW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 02:00:22 -0400
Date: Sun, 15 Aug 2004 22:58:40 -0700
From: Andrew Morton <akpm@osdl.org>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: anton@samba.org, linux-kernel@vger.kernel.org, jrsantos@austin.ibm.com
Subject: Re: [PATCH] remove cacheline alignment from inode slabs
Message-Id: <20040815225840.3ba8cdce.akpm@osdl.org>
In-Reply-To: <200408160825.42889.vda@port.imtp.ilyichevsk.odessa.ua>
References: <20040815233732.GL5637@krispykreme>
	<200408160825.42889.vda@port.imtp.ilyichevsk.odessa.ua>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua> wrote:
>
> +ifneq ($(CONFIG_CC_ALIGN_FUNCTIONS),0)
>  +CFLAGS		+= -falign-functions=$(CONFIG_CC_ALIGN_FUNCTIONS)
>  +endif
>  +ifneq ($(CONFIG_CC_ALIGN_LABELS),0)
>  +CFLAGS		+= -falign-labels=$(CONFIG_CC_ALIGN_LABELS)
>  +endif
>  +ifneq ($(CONFIG_CC_ALIGN_LOOPS),0)
>  +CFLAGS		+= -falign-loops=$(CONFIG_CC_ALIGN_LOOPS)
>  +endif
>  +ifneq ($(CONFIG_CC_ALIGN_JUMPS),0)
>  +CFLAGS		+= -falign-jumps=$(CONFIG_CC_ALIGN_JUMPS)
>  +endif

When sending optimisation patches, please include information on how
effective the optimisation is.  Before and after code sizes would be
appropriate here.

gcc-2.95.x barfs over all four of the above options.  Some testing of
$(GCC_VERSION) is needed.  That's only set up by arch/i386/Makefile at
present.

