Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262205AbVG0MBa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262205AbVG0MBa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 08:01:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262209AbVG0L7E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 07:59:04 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:18596 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S262198AbVG0L66 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 07:58:58 -0400
Message-Id: <200507270149.j6R1n26u013077@laptop11.inf.utfsm.cl>
To: Adrian Bunk <bunk@stusta.de>
cc: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] include/linux/bio.h: "extern inline" -> "static inline" 
In-Reply-To: Message from Adrian Bunk <bunk@stusta.de> 
   of "Tue, 26 Jul 2005 16:53:44 +0200." <20050726145344.GO3160@stusta.de> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Date: Tue, 26 Jul 2005 21:49:02 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b5 (inti.inf.utfsm.cl [200.1.19.1]); Wed, 27 Jul 2005 07:57:35 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> wrote:
> "extern inline" doesn't make much sense.

The gcc info here (4.0.1-4 on Fedora rawhide) says it means that the
function should be inlined, and no local copy should be generated
ever. This way the build will bomb out when something isn't inlined.

It also says you should use:

   static inline void foo(some args) __attribute__((always_inline));

as a prototype in this case for future proofing (gcc inlining is not C99
compatible!), but I don't know if that is supported as far back as 2.95.3
(as per Documentation/Changes the required compiler).

Side question: Is there anybody still seriously using such ancient
compilers? I'd guess almost everybody is using newer versions, so this
would really be not a supported combination anymore.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513



