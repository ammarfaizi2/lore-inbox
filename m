Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262500AbVA0GY6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262500AbVA0GY6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 01:24:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262494AbVA0GY6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 01:24:58 -0500
Received: from alpha.logic.tuwien.ac.at ([128.130.175.20]:12013 "EHLO
	alpha.logic.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S262505AbVA0GYk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 01:24:40 -0500
Date: Thu, 27 Jan 2005 07:24:05 +0100
To: Len Brown <len.brown@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc2-mm1 strange messages
Message-ID: <20050127062405.GA7991@gamma.logic.tuwien.ac.at>
References: <20050125102834.7e549322.akpm@osdl.org> <1106784100.11830.430.camel@d845pe>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1106784100.11830.430.camel@d845pe>
User-Agent: Mutt/1.3.28i
From: Norbert Preining <preining@logic.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mit, 26 Jan 2005, Len Brown wrote:
> > Can you please add this?
> > 
> > --- 25/arch/i386/mm/ioremap.c~iounmap-debugging 2005-01-25
> > 10:26:29.448809152 -0800
> > +++ 25-akpm/arch/i386/mm/ioremap.c      2005-01-25 10:27:07.054092280
> > -0800
> > @@ -233,7 +233,8 @@ void iounmap(volatile void __iomem *addr
> >                 return; 
> >         p = remove_vm_area((void *) (PAGE_MASK & (unsigned long
> > __force) addr));
> >         if (!p) { 
> > -               printk("__iounmap: bad address %p\n", addr);
> > +               printk("iounmap: bad address %p\n", addr);
> > +               dump_stack();
> >                 return;
> >         }
> >  
> > _
> > 
> 
> Better yet, can you please add this?
> 
> http://lkml.org/lkml/2005/1/3/136

I only get hands on the laptop today noon, but then I will immediately
recompile ...

Best wishes

Norbert

-------------------------------------------------------------------------------
Norbert Preining <preining AT logic DOT at>         Technische Universität Wien
sip:preining@at43.tuwien.ac.at                             +43 (0) 59966-690018
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
SCRABSTER (n.)
One of those dogs which has it off on your leg during tea.
			--- Douglas Adams, The Meaning of Liff
