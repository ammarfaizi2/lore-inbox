Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750817AbWCJMa2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750817AbWCJMa2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 07:30:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750837AbWCJMa1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 07:30:27 -0500
Received: from smtp.amirix.com ([142.176.159.6]:22460 "EHLO smtp.amirix.com")
	by vger.kernel.org with ESMTP id S1750817AbWCJMa1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 07:30:27 -0500
Message-ID: <019601c6443e$55043cc0$89a74bc0@delleb1186>
From: "Kevin Winchester" <kwin@ns.sympatico.ca>
To: "Andrew Morton" <akpm@osdl.org>, "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: <ak@muc.de>, <linux-kernel@vger.kernel.org>
References: <4410BDFB.3070401@ns.sympatico.ca><20060309172854.ae8eeec9.rdunlap@xenotime.net> <20060309173738.6a97d0eb.akpm@osdl.org>
Subject: Re: [PATCH -mm3] x86-64: Eliminate register_die_notifier symbol exported twice
Date: Fri, 10 Mar 2006 08:29:53 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1506
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1506
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


"Andrew Morton" <akpm@osdl.org> wrote:
> "Randy.Dunlap" <rdunlap@xenotime.net> wrote:
> >
> > On Thu, 09 Mar 2006 19:44:59 -0400 Kevin Winchester wrote:
> >
> > >
> > > register_die_notifier is exported twice, once in traps.c and once in
> > > x8664_ksyms.c.  This results in a warning on build.
> > >
> > > Signed-Off-By: Kevin Winchester <kwin@ns.sympatico.ca>
> > >
> > > --- v2.6.16-rc5-mm3.orig/arch/x86_64/kernel/x8664_ksyms.c
> > > 2006-03-09 19:34:11.000000000 -0400
> > > +++ v2.6.16-rc5-mm3/arch/x86_64/kernel/x8664_ksyms.c    2006-03-09
> > > 19:40:46.000000000 -0400
> > > @@ -142,7 +142,6 @@ EXPORT_SYMBOL(rwsem_down_write_failed_th
> > >  EXPORT_SYMBOL(empty_zero_page);
> > >
> > >  EXPORT_SYMBOL(die_chain);
> > > -EXPORT_SYMBOL(register_die_notifier);
> > >
> > >  #ifdef CONFIG_SMP
> > >  EXPORT_SYMBOL(cpu_sibling_map);
> >
> > Thanks for that.  However, I see 2 such warnings:
> >
> > WARNING: vmlinux: 'register_die_notifier' exported twice. Previous
export was in vmlinux
> > WARNING: vmlinux: 'strlen' exported twice. Previous export was in
vmlinux
> >
>
> They're all over the place.  Some of them are due to -mm-only patches.
>
> It's not very urgent.  Let's get Sam's stuff settled down into mainline
and
> get all such warnings in mainline fixed up first.  That way, people will
> then know when their new patches are being bad and I'll know when -mm
> patches need fixups.

Fixing warnings like this is about the extent of my kernel abilities, so I
figured I'd do it even if it isn't high priority.  I do get the strlen
warning as well, that was going to be tonight's task.

If it helps, I don't see any warnings on the -rc5 kernel.  These two are the
only ones I see.

Kevin


