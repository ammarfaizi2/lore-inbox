Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262696AbVBYNil@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262696AbVBYNil (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 08:38:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262697AbVBYNil
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 08:38:41 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:19355 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S262696AbVBYNht (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 08:37:49 -0500
Message-Id: <200502251337.j1PDbVbo005932@laptop11.inf.utfsm.cl>
To: Brian Gerst <bgerst@didntduck.org>
cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] vsprintf.c cleanups 
In-Reply-To: Message from Brian Gerst <bgerst@didntduck.org> 
   of "Fri, 25 Feb 2005 07:28:20 CDT." <421F19E4.10600@didntduck.org> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Date: Fri, 25 Feb 2005 10:37:31 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b2 (inti.inf.utfsm.cl [200.1.21.155]); Fri, 25 Feb 2005 10:37:32 -0300 (CLST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brian Gerst <bgerst@didntduck.org> said:
> Horst von Brand wrote:
> > Brian Gerst <bgerst@didntduck.org> said:
> > 
> >>- Make sprintf call vsnprintf directly
> >>- use INT_MAX for sprintf and vsprintf

> > This is the size limit on what is written. 4GiB sounds a bit extreme...

> Sprintf has no limit, which is why it's generally bad to use it.  I just 
> replaced an open coded ((~0U)>>1) value with the equivalent INT_MAX.

Which is the same as "no limit" in my book. Either you know a limit (in
which case vsprintf() is OK) or you don't (in which case vsnprintf() is
just obfuscation).
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
