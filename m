Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261578AbSJQA5u>; Wed, 16 Oct 2002 20:57:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261604AbSJQA5u>; Wed, 16 Oct 2002 20:57:50 -0400
Received: from pizda.ninka.net ([216.101.162.242]:47030 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261578AbSJQA5p>;
	Wed, 16 Oct 2002 20:57:45 -0400
Date: Wed, 16 Oct 2002 17:55:15 -0700 (PDT)
Message-Id: <20021016.175515.21904896.davem@redhat.com>
To: levon@movementarian.org
Cc: weigand@immd1.informatik.uni-erlangen.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [8/7] oprofile - dcookies need to use u32
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20021017005728.GA8267@compsoc.man.ac.uk>
References: <20021016164057.GB85246@compsoc.man.ac.uk>
	<20021016.143843.99745166.davem@redhat.com>
	<20021017005728.GA8267@compsoc.man.ac.uk>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: John Levon <levon@movementarian.org>
   Date: Thu, 17 Oct 2002 01:57:28 +0100

   The oprofile event buffer is unsigned long [], and stores cookie values.
   Surely that would require us to use u64 there too, doubling the buffer
   sizes on 32-bit machines ?
   
   I suppose we could do so magic to spread the cookie value across two
   buffer entries if necessary, but that's ugly...
   
True.

What if you could query the cookie size at runtime?
Would that help?

Really, if you make it long it's going to be impossible
to support this in 32/64 environments (ppc/sparc/mips/x86_64/
ia64/etc.)
