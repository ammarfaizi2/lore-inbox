Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932131AbWHJT4F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932131AbWHJT4F (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 15:56:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751505AbWHJT4D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 15:56:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:37505 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751496AbWHJTz2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:55:28 -0400
From: Andi Kleen <ak@suse.de>
To: Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [PATCH for review] [130/145] i386: clean up topology.c
Date: Thu, 10 Aug 2006 21:55:16 +0200
User-Agent: KMail/1.9.3
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20060810 935.775038000@suse.de> <20060810193729.EC90B13C0B@wotan.suse.de> <1155239403.19249.271.camel@localhost.localdomain>
In-Reply-To: <1155239403.19249.271.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608102155.16849.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 10 August 2006 21:50, Dave Hansen wrote:
> On Thu, 2006-08-10 at 21:37 +0200, Andi Kleen wrote:
> >  static int __init topology_init(void)
> >  {
> >         int i;
> >  
> > +#ifdef CONFIG_NUMA
> >         for_each_online_node(i)
> >                 register_one_node(i);
> > +#endif /* CONFIG_NUMA */
> >  
> >         for_each_present_cpu(i)
> >                 arch_register_cpu(i);
> >         return 0;
> >  } 
> 
> Wouldn't it be more proper here to make register_one_node() have a
> non-NUMA definition, instead of putting an #ifdef in a .c file like
> this?

I don't see a particular advantage of that for something simple like this. 
But if you feel strongly about it please submit a tested replacement patch.

-Andi
