Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265678AbSKAKci>; Fri, 1 Nov 2002 05:32:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265681AbSKAKci>; Fri, 1 Nov 2002 05:32:38 -0500
Received: from pizda.ninka.net ([216.101.162.242]:20939 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S265678AbSKAKch>;
	Fri, 1 Nov 2002 05:32:37 -0500
Date: Fri, 01 Nov 2002 02:27:43 -0800 (PST)
Message-Id: <20021101.022743.06339817.davem@redhat.com>
To: levon@movementarian.org
Cc: weigand@immd1.informatik.uni-erlangen.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [8/7] oprofile - dcookies need to use u32
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20021101043304.GA7421@compsoc.man.ac.uk>
References: <20021019003415.GA17016@compsoc.man.ac.uk>
	<20021018.173128.11570989.davem@redhat.com>
	<20021101043304.GA7421@compsoc.man.ac.uk>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: John Levon <levon@movementarian.org>
   Date: Fri, 1 Nov 2002 04:33:04 +0000
   
   The problem is this would trivially break cross-compilation. Would it
   not be better to stick something in the glibc's bits/types.h
   per-platform ?
   
   Not that I particularly fancy going near glibc...

No, becuase this is an attribute of the cpu the binary
is executing on, not an attribute of the ABI under which
userland compilation are taking place.

At run time, you probe this /proc/sys/kernel/pointer_size
value.  In fact, this should have no effect whatsoever on
cross-compilation.  I thought we were quite clear on this
solution?
