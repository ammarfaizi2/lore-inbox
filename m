Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261620AbSI0DsJ>; Thu, 26 Sep 2002 23:48:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261621AbSI0DsJ>; Thu, 26 Sep 2002 23:48:09 -0400
Received: from sex.inr.ac.ru ([193.233.7.165]:52668 "HELO sex.inr.ac.ru")
	by vger.kernel.org with SMTP id <S261620AbSI0DsI>;
	Thu, 26 Sep 2002 23:48:08 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200209270353.HAA19674@sex.inr.ac.ru>
Subject: Re: Problems with tcp_retransmit_skb - Please omit the previous incomplete mail
To: rpranesh@yahoo.COM (Venkatesh Rao)
Date: Fri, 27 Sep 2002 07:53:09 +0400 (MSD)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020926184618.35723.qmail@web21401.mail.yahoo.com> from "Venkatesh Rao" at Sep 26, 2 11:15:02 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> When conditions fails, the value of wmem_alloc is ~ 
> around 56K-154K,

... which means that you already have 64-154K transmitted
and all this buffers still not left the host. So, further
retransmission is pointless.


> Each time it tries to retransmit this if condition
> always fail
...
> Any hints in  helping me debug this issue will be
> appreciated.

Most likely, this means that driver leaks memory.

Alexey
