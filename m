Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265426AbSJSAeL>; Fri, 18 Oct 2002 20:34:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265427AbSJSAeL>; Fri, 18 Oct 2002 20:34:11 -0400
Received: from pizda.ninka.net ([216.101.162.242]:10956 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S265426AbSJSAeL>;
	Fri, 18 Oct 2002 20:34:11 -0400
Date: Fri, 18 Oct 2002 17:31:28 -0700 (PDT)
Message-Id: <20021018.173128.11570989.davem@redhat.com>
To: levon@movementarian.org
Cc: weigand@immd1.informatik.uni-erlangen.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [8/7] oprofile - dcookies need to use u32
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20021019003415.GA17016@compsoc.man.ac.uk>
References: <20021019002645.GA16882@compsoc.man.ac.uk>
	<20021018.172327.11877875.davem@redhat.com>
	<20021019003415.GA17016@compsoc.man.ac.uk>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: John Levon <levon@movementarian.org>
   Date: Sat, 19 Oct 2002 01:34:15 +0100

   Or do I add /dev/oprofile/sizeof or whatever ?
   
That would be a great way to do this portably.

I suspect oprofile won't be the only situation where this value
would be useful, perhaps /proc/sys/kernel/pointer_size?

If you use sizeof(void *) as the initialization value in the kernel
code that implements this read-only sysctl, it will "just work".
