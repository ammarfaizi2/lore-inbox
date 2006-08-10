Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161145AbWHJLbl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161145AbWHJLbl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 07:31:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161166AbWHJLbl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 07:31:41 -0400
Received: from cantor.suse.de ([195.135.220.2]:58786 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1161145AbWHJLbl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 07:31:41 -0400
From: Andi Kleen <ak@muc.de>
To: virtualization@lists.osdl.org
Subject: Re: [PATCH] paravirt.h
Date: Thu, 10 Aug 2006 13:31:19 +0200
User-Agent: KMail/1.9.3
Cc: Rusty Russell <rusty@rustcorp.com.au>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@sous-sol.org>
References: <1155202505.18420.5.camel@localhost.localdomain> <20060810103012.GA2356@muc.de> <1155207946.18420.18.camel@localhost.localdomain>
In-Reply-To: <1155207946.18420.18.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608101331.19954.ak@muc.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 10 August 2006 13:05, Rusty Russell wrote:
> On Thu, 2006-08-10 at 12:30 +0200, Andi Kleen wrote:
> > On Thu, Aug 10, 2006 at 08:10:03PM +1000, Rusty Russell wrote:
> > > On Thu, 2006-08-10 at 19:35 +1000, Rusty Russell wrote:
> > > > This version over last version:
> > > > (1) Gets rid of the no_paravirt.h header and leaves native ops in place
> > > > (with some reshuffling to keep then under one #ifdef).
> > > > (2) Fixes the "X crashes with CONFIG_PARAVIRT=y" bug.
> > > > (3) Puts __ex_table entry in paravirt iret.
> > > 
> > > Gurp... that was old version.  This version removes the explicit "save
> > > flags and disable irqs" op (the binary patching patches it as one, but
> > > there's little point having a short-cut through the slow path).
> > 
> > Can you please do at least a s/__asm__/asm/g s/__volatile__/volatile/g ?
> > 
> > And you seem to have added some __volatiles too, that should be also 
> > volatile.
> 
> OK, here's with the __removal__

Hmm, i still see a lot of them (and __volatile too) 

Also maybe it's my mail client, but the resulting patch seems to be also full of
MIME damage:

 EXTRA_AFLAGS   :=3D -traditional

Can you send it at least without that please? The __s I can fix
up myself in the worst case if you don't want to.

-Andi
