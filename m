Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932383AbWHKBc1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932383AbWHKBc1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 21:32:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932418AbWHKBc1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 21:32:27 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:60557 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932383AbWHKBc0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 21:32:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tDBFdYrh+t7665xHHM9M19m4g8ALaLS1R7B8wv0iZH5lemATyepOSGkKZGOGDgVoran5VCoLFSlaUIjmYA4Nc6iLyzIkPw28bHizHYZDfRwfQAr/P/jH5KHJN7Qq6cMw7hxL2hsg6iWuQBGL1hGvbmAoHLH1UE4bKhsYggZU+uM=
Message-ID: <aec7e5c30608101832p42b30900iaf9738b7f394516e@mail.gmail.com>
Date: Fri, 11 Aug 2006 10:32:22 +0900
From: "Magnus Damm" <magnus.damm@gmail.com>
To: "Dave Hansen" <haveblue@us.ibm.com>
Subject: Re: [PATCH for review] [130/145] i386: clean up topology.c
Cc: "Andi Kleen" <ak@suse.de>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
In-Reply-To: <1155239403.19249.271.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060810193729.EC90B13C0B@wotan.suse.de>
	 <1155239403.19249.271.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/11/06, Dave Hansen <haveblue@us.ibm.com> wrote:
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

I thought about that too, and my reason for not doing it is that this
simple fix would be less straight-forward and probably more subject to
whining and arguing. So my plan was to do this as a first step and
then encourage anyone else that wanted to fix up register_one_node()
properly. =)

Cheers,

/ magnus
