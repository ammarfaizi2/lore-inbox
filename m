Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315278AbSH0Hbl>; Tue, 27 Aug 2002 03:31:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315279AbSH0Hbl>; Tue, 27 Aug 2002 03:31:41 -0400
Received: from pizda.ninka.net ([216.101.162.242]:59274 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S315278AbSH0Hbk>;
	Tue, 27 Aug 2002 03:31:40 -0400
Date: Tue, 27 Aug 2002 00:30:27 -0700 (PDT)
Message-Id: <20020827.003027.26962443.davem@redhat.com>
To: andre@linux-ide.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: readsw/writesw readsl/writesl
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.10.10208262321150.24156-100000@master.linux-ide.org>
References: <20020826.231157.10296323.davem@redhat.com>
	<Pine.LNX.4.10.10208262321150.24156-100000@master.linux-ide.org>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andre Hedrick <andre@linux-ide.org>
   Date: Mon, 26 Aug 2002 23:23:22 -0700 (PDT)
   
   Would you consider these for each arch as there are coresponding one for
   IOMIO, and life would be better if we had a standard set for MMIO.
   
   Please consider the request.

The only reason insl() exists is because the x86 has special
instructions to perform that operation.

It used to be an optimization when cpus were really slow.

No cpu to my knowledge has special instructions to readsl et al.  and
on no cpu would be faster than a hand coded loop.

In fact I would instead vote to delete {in,out}s{b,w,l}() and friends.
:-)
