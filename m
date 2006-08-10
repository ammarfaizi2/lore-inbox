Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932125AbWHJTua@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932125AbWHJTua (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 15:50:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932087AbWHJTuW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 15:50:22 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:45753 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S932318AbWHJTuQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:50:16 -0400
Subject: Re: [PATCH for review] [130/145] i386: clean up topology.c
From: Dave Hansen <haveblue@us.ibm.com>
To: Andi Kleen <ak@suse.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20060810193729.EC90B13C0B@wotan.suse.de>
References: <20060810 935.775038000@suse.de>
	 <20060810193729.EC90B13C0B@wotan.suse.de>
Content-Type: text/plain
Date: Thu, 10 Aug 2006 12:50:03 -0700
Message-Id: <1155239403.19249.271.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-10 at 21:37 +0200, Andi Kleen wrote:
>  static int __init topology_init(void)
>  {
>         int i;
>  
> +#ifdef CONFIG_NUMA
>         for_each_online_node(i)
>                 register_one_node(i);
> +#endif /* CONFIG_NUMA */
>  
>         for_each_present_cpu(i)
>                 arch_register_cpu(i);
>         return 0;
>  } 

Wouldn't it be more proper here to make register_one_node() have a
non-NUMA definition, instead of putting an #ifdef in a .c file like
this?

-- Dave

