Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286647AbSCOIzv>; Fri, 15 Mar 2002 03:55:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286825AbSCOIzm>; Fri, 15 Mar 2002 03:55:42 -0500
Received: from pizda.ninka.net ([216.101.162.242]:2970 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S286521AbSCOIzV>;
	Fri, 15 Mar 2002 03:55:21 -0500
Date: Fri, 15 Mar 2002 00:51:55 -0800 (PST)
Message-Id: <20020315.005155.93361168.davem@redhat.com>
To: ian@ianduggan.net
Cc: alan@lxorguk.ukuu.org.uk, rml@tech9.net, linux-kernel@vger.kernel.org
Subject: Re: 2.4.18 Preempt Freezeups
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3C91B30D.A887A033@ianduggan.net>
In-Reply-To: <3C9153A7.292C320@ianduggan.net>
	<E16lhBg-0002Yc-00@the-village.bc.nu>
	<3C91B30D.A887A033@ianduggan.net>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Ian Duggan <ian@ianduggan.net>
   Date: Fri, 15 Mar 2002 00:38:37 -0800
   
   What is required for preempt beyond "SMP safe" code? I thought the whole
   idea was to make the preemptions transparent to other code by utilizing
   the SMP critical regions?

Pre-empt makes things like per-cpu data structures require
preemption disables around cpu-local critical regions.

Code that works before just because it knows the data structure is
only even accessed by the current cpu doesn't work because preemption
can cause a context switch at any time.
