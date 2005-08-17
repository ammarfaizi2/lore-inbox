Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751217AbVHQUKB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751217AbVHQUKB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 16:10:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751226AbVHQUKB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 16:10:01 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:29410 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1751217AbVHQUKA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 16:10:00 -0400
Message-Id: <200508172008.j7HK8gcp016433@laptop11.inf.utfsm.cl>
To: Andi Kleen <ak@suse.de>
cc: Christian Ehrhardt <ehrhardt@mathematik.uni-ulm.de>,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: Undefined behaviour with get_cpu_vendor 
In-Reply-To: Message from Andi Kleen <ak@suse.de> 
   of "Wed, 17 Aug 2005 13:50:41 +0200." <20050817115041.GK3996@wotan.suse.de> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Date: Wed, 17 Aug 2005 16:08:42 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b5 (inti.inf.utfsm.cl [200.1.21.155]); Wed, 17 Aug 2005 16:08:44 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> wrote:
> On Wed, Aug 17, 2005 at 11:54:23AM +0200, Christian Ehrhardt wrote:
> > Your Patch at (URL wrapped)
> > 
> > http://www.kernel.org/git/?p=linux/kernel/git/torvalds/old-2.6-bkcvs.git; \
> > 		a=commit;h=99c6e60afff8a7bc6121aeb847dab27c556cf0c9
> > 
> > introduced an additional Parameter (int early) to get_cpu_vendor.
> > However, the same function is called in arch/i386/kernel/apic.c (via
> > an explicit extern declaration that doesn't have the new early parameter.
> 
> Sigh. All people adding externs like this should be ...
> 
> But it won't change anything - the only difference with
> the flag being 0 is to read less fields, but since the function
> has been called earlier and the data has not changed
> the output is always the same.

I'm not so sure that "argument not explicitly given" will always turn out
zero...  more like "random" memory contents.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
