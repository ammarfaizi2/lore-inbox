Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262624AbVF2RDb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262624AbVF2RDb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 13:03:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262620AbVF2RBI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 13:01:08 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:453 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S262609AbVF2Q5J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 12:57:09 -0400
Message-Id: <200506291655.j5TGtpkX011008@laptop11.inf.utfsm.cl>
To: Jeff Chua <jeffchua@silk.corp.fedex.com>
cc: Alejandro Bonilla <abonilla@linuxwireless.org>,
       "'Arjan van de Ven'" <arjan@infradead.org>,
       "'Jeff Chua'" <jeff96@silk.corp.fedex.com>,
       ipw2100-devel@lists.sourceforge.net,
       "'Linux Kernel'" <linux-kernel@vger.kernel.org>
Subject: Re: ipw2200 can't compile under linux 2.6.13-rc1 
In-Reply-To: Message from Jeff Chua <jeffchua@silk.corp.fedex.com> 
   of "Wed, 29 Jun 2005 22:17:06 +0800." <Pine.LNX.4.63.0506292209050.6581@boston.corp.fedex.com> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Date: Wed, 29 Jun 2005 12:55:51 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b5 (inti.inf.utfsm.cl [200.1.21.155]); Wed, 29 Jun 2005 12:55:53 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Chua <jeffchua@silk.corp.fedex.com> wrote:

[...]

> All the ipw2200 files has ...
> 
>  	#include <net/ieee80211.h>
> 
> and that points to the new linux header in
> /usr/src/linux/include/net/ieee80211.h instead of the local include
> file under the ipw2200/net directory.
> 
> I've modified all ipw2200 files to #include "net/ieee80211.h" and now
> it compiles ok.

No, it doesn't. The warnings are about /function pointers/ that have the
wrong type (this comes from an earlier 2.6.12-git). AFAICS, this is due to
a change in device handling, and as long as this isn't fixed, I won't even
try to load the module.

Just need a little time to decrypt this macro mess...

And again, shouldn't we push for the header here going into the kernel? Or
fix up the code to work with the kernel version? The current situation
isn't confortable at all.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
