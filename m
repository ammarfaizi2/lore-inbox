Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267550AbRHAQx3>; Wed, 1 Aug 2001 12:53:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267520AbRHAQxS>; Wed, 1 Aug 2001 12:53:18 -0400
Received: from minus.inr.ac.ru ([193.233.7.97]:62473 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S267532AbRHAQxH>;
	Wed, 1 Aug 2001 12:53:07 -0400
Message-Id: <200107312306.DAA00493@mops.inr.ac.ru>
Subject: Re: [PATCH] register_inet6addr_notifier
To: utz.bacher@de.ibm.COM (Utz Bacher)
Date: Wed, 1 Aug 2001 03:06:41 -2000 (MSD)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <OF119FF657.6688232C-ONC1256A9A.0063BDC0@de.ibm.com> from "Utz Bacher" at Jul 31, 1 11:15:03 pm
From: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> attached is a patch which introduces
> * register_inet6addr_notifier
> * unregister_inet6addr_notifier

Nice. But where is a use of this? [For reason of the question, see below]. 


> cards which provide IP offload capabilities and therfore require knowledge
> of IP addresses.

Very interesting. I am very curious, what kind of "offload" is possible
with current stack are possible. Even if you know addresses. :-)


What's about the patch... Do you understand that currently
it is impossible to call notifiers for adding/deletion of each IPv6 address
in an intelligible context? Not seeing uses of such notifiers,
it is difficult to approve such feature because of danger of misuse
now and even worse misuse in (near) future, when context will change.

Alexey
