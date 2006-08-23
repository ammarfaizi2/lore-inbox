Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751350AbWHWAcF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751350AbWHWAcF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 20:32:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751330AbWHWAcF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 20:32:05 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:41190
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751266AbWHWAcC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 20:32:02 -0400
Date: Tue, 22 Aug 2006 17:32:00 -0700 (PDT)
Message-Id: <20060822.173200.126578369.davem@davemloft.net>
To: sundell.software@gmail.com
Cc: kuznet@ms2.inr.ac.ru, johnpol@2ka.mipt.ru, nmiell@comcast.net,
       linux-kernel@vger.kernel.org, drepper@redhat.com, akpm@osdl.org,
       netdev@vger.kernel.org, zach.brown@oracle.com, hch@infradead.org
Subject: Re: [take12 0/3] kevent: Generic event handling mechanism.
From: David Miller <davem@davemloft.net>
In-Reply-To: <b3f268590608221728r6cffd03i2f2dd12421b9f37@mail.gmail.com>
References: <b3f268590608221551q5e6a1057hd1474ee8b9811f10@mail.gmail.com>
	<20060822231129.GA18296@ms2.inr.ac.ru>
	<b3f268590608221728r6cffd03i2f2dd12421b9f37@mail.gmail.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Jari Sundell" <sundell.software@gmail.com>
Date: Wed, 23 Aug 2006 02:28:32 +0200

> There are system calls that take timespec, so I assume the magic is
> already available for handling the timeout argument of kevent.

System calls are one thing, they can be translated for these
kinds of situations.  But this doesn't help, and nothing at
all can be done, for datastructures exposed to userspace via
mmap()'d buffers, which is what kevent will be doing.

This is what Alexey is trying to explain to you.
