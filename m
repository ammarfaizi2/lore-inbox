Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290748AbSBLDZq>; Mon, 11 Feb 2002 22:25:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290746AbSBLDZg>; Mon, 11 Feb 2002 22:25:36 -0500
Received: from pizda.ninka.net ([216.101.162.242]:52359 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S290748AbSBLDZV>;
	Mon, 11 Feb 2002 22:25:21 -0500
Date: Mon, 11 Feb 2002 19:23:34 -0800 (PST)
Message-Id: <20020211.192334.123921982.davem@redhat.com>
To: davidm@hpl.hp.com
Cc: anton@samba.org, linux-kernel@vger.kernel.org, zippel@linux-m68k.org
Subject: Re: thread_info implementation
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <15464.35214.669412.477377@napali.hpl.hp.com>
In-Reply-To: <15464.34183.282646.869983@napali.hpl.hp.com>
	<20020211.190449.55725714.davem@redhat.com>
	<15464.35214.669412.477377@napali.hpl.hp.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: David Mosberger <davidm@hpl.hp.com>
   Date: Mon, 11 Feb 2002 19:18:38 -0800
   
   Let's see: on Itanium, a ld takes up an M slot and has a 2 cycle
   access latency (if in the first level cache).  This may or may not be
   noticable in benchmarks, but it certainly won't go faster.  And all
   this just for task coloring (which we can do with the old set up just
   fine)?

The compiler will schedule the latency out of existence.
