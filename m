Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318189AbSG3C1j>; Mon, 29 Jul 2002 22:27:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318190AbSG3C1j>; Mon, 29 Jul 2002 22:27:39 -0400
Received: from pizda.ninka.net ([216.101.162.242]:16109 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S318189AbSG3C1i>;
	Mon, 29 Jul 2002 22:27:38 -0400
Date: Mon, 29 Jul 2002 19:19:31 -0700 (PDT)
Message-Id: <20020729.191931.45561787.davem@redhat.com>
To: rml@tech9.net
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spinlock.h cleanup
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <1027989220.1016.273.camel@sinai>
References: <Pine.LNX.4.33.0207291725580.1722-100000@penguin.transmeta.com>
	<1027989053.929.263.camel@sinai>
	<1027989220.1016.273.camel@sinai>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Robert Love <rml@tech9.net>
   Date: 29 Jul 2002 17:33:39 -0700

   On Mon, 2002-07-29 at 17:30, Robert Love wrote:
   
   > On Mon, 2002-07-29 at 17:26, Linus Torvalds wrote:
   > 
   > > Hmm.. Why did you remove the gcc workaround? Are all gcc's > 2.95 known to 
   > > be ok wrt empty initializers?
   > 
   > If I recall correctly, the fix was for older egcs compilers.
   
   To better answer your question, I just checked and indeed it seems all
   gcc's >= 2.95 are OK.

Some platforms (sparc64) are still using things like egcs-2.92.x
vintage compilers as their main supported kernel build compiler.

init/main.c allows 2.91 or greater to pass so that should be the rule
enforced kernel wide.

I don't remember when the empty initializer thing was fixed.
