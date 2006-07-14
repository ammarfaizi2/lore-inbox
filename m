Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161198AbWGNCWl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161198AbWGNCWl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 22:22:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161196AbWGNCWl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 22:22:41 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:16769 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1161192AbWGNCWk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 22:22:40 -0400
Message-Id: <200607140222.k6E2MYBo030620@laptop11.inf.utfsm.cl>
To: "Catalin Marinas" <catalin.marinas@gmail.com>
cc: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/10] Kernel memory leak detector 0.8 
In-Reply-To: Message from "Catalin Marinas" <catalin.marinas@gmail.com> 
   of "Wed, 12 Jul 2006 11:38:48 +0100." <b0943d9e0607120338r37886ebck56db5fbf29e8e350@mail.gmail.com> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 19)
Date: Thu, 13 Jul 2006 22:22:34 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.21.155]); Thu, 13 Jul 2006 22:22:36 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Catalin Marinas <catalin.marinas@gmail.com> wrote:
> On 12/07/06, Joseph Fannin <jfannin@gmail.com> wrote:
> > On Tue, Jul 11, 2006 at 02:00:05PM +0100, Catalin Marinas wrote:
> > > That's a bug in gcc-4. The __builtin_constant_p() function always
> > > returns true even when the argument is not a constant. You could try a
> > > gcc-3.4 or a patched gcc.
> >
> >     Which gcc versions are affected by this?
> 
> From gcc-4.0 I think but I don't know when/if it was fixed in the
> latest. I use CodeSourcery's toolchain and they fixed in in gcc-4.1
> but that's with their own patches. Try to compile the code below. It
> should work if the toolchain is OK:
> 
>        #include <stdlib.h>
> 
>        #define EXPR    atoi(argv[1])
> 
>        int main(int argc, char *argv[])
>        {
>            static int a[] = {
>                __builtin_constant_p(EXPR) ? EXPR : 0
>            };
> 
>            return a[0];
>        }

Fails with gcc-4.1.1-7 from Fedora Core development.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
