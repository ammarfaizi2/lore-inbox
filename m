Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751351AbWFICRc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751351AbWFICRc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 22:17:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751352AbWFICRc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 22:17:32 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:59885 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1751351AbWFICRc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 22:17:32 -0400
Message-Id: <200606090217.k592HNjq011090@laptop11.inf.utfsm.cl>
To: "Matheus Izvekov" <mizvekov@gmail.com>
cc: "Sascha Nitsch" <Sash_lkl@linuxhowtos.org>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: Idea about a disc backed ram filesystem 
In-Reply-To: Message from "Matheus Izvekov" <mizvekov@gmail.com> 
   of "Thu, 08 Jun 2006 19:48:39 -0300." <305c16960606081548m316099awafa619bb5d0d14f0@mail.gmail.com> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 19)
Date: Thu, 08 Jun 2006 22:17:23 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.19.1]); Thu, 08 Jun 2006 22:17:25 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matheus Izvekov <mizvekov@gmail.com> wrote:

[...]

> I had a somewhat similar idea, once i have time to implement it ill
> submit a patch.
> My idea consisted of adding the capability to specify a device for
> tmpfs mounting. if you dont specify any device, tmpfs continues to
> behave the way it currently is. But if you do, once data doesnt fit on
> ram (or some other limit) anymore, it will flush things to this
> device. my intention was to reuse swap code for this, so you mount a
> tmpfs passing the dev node of some unused swap device, and it works
> just like tmpfs with a dedicated swap partition.

tmpfs does use swap currently. Giving tmpfs a dedicated swap space is dumb,
as it takes away the possibility of using that space for swapping when not
in use by tmpfs (and viceversa).
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
