Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1947077AbWKKDoo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947077AbWKKDoo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 22:44:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947080AbWKKDoo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 22:44:44 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:39810 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1947077AbWKKDon (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 22:44:43 -0500
Message-Id: <200611102017.kAAKGWrV006765@laptop13.inf.utfsm.cl>
To: Alexey Dobriyan <adobriyan@gmail.com>
cc: Dave Jones <davej@redhat.com>, Randy Dunlap <randy.dunlap@oracle.com>,
       Andrew Morton <akpm@osdl.org>, Dave Jones <davej@codemonkey.org.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gx-suspmod: fix "&& 0xff" typo 
In-Reply-To: Message from Alexey Dobriyan <adobriyan@gmail.com> 
   of "Thu, 09 Nov 2006 01:20:46 +0300." <20061108222046.GE4972@martell.zuzino.mipt.ru> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.5  (beta27)
Date: Fri, 10 Nov 2006 17:16:32 -0300
From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
X-Greylist: Delayed for 00:29:29 by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.21.155]); Sat, 11 Nov 2006 00:43:48 -0300 (CLST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Dobriyan <adobriyan@gmail.com> wrote:
> >  > > -	params->pci_rev = class_rev && 0xff;
> >  > > +	params->pci_rev = class_rev & 0xff;
> >  >
> >  > Hi,
> >  > any kind of automated detection on that one?
> >
> > grep -r "&& 0x" .  seems to be pretty effective modulo
> > some false-positives.
> 
> Obligatory nit-picking:
> 
> 	grep '&&[ 	]*0[xX][fF]' -r .

Hum... could also be, e.g., "&& 1 << 3", or "&& SOME_FUNKY_CONSTANT"...

        grep -r '&&[    ]*[0-9A-Z]'

but that gives lots of noise... need to refine (or just eyeball the
output). OK, will check.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                    Fono: +56 32 2654431
Universidad Tecnica Federico Santa Maria             +56 32 2654239
Casilla 110-V, Valparaiso, Chile               Fax:  +56 32 2797513

