Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318397AbSGYKZ5>; Thu, 25 Jul 2002 06:25:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318398AbSGYKZ5>; Thu, 25 Jul 2002 06:25:57 -0400
Received: from pizda.ninka.net ([216.101.162.242]:40641 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S318397AbSGYKZ5>;
	Thu, 25 Jul 2002 06:25:57 -0400
Date: Thu, 25 Jul 2002 03:18:21 -0700 (PDT)
Message-Id: <20020725.031821.123624987.davem@redhat.com>
To: mingo@elte.hu
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: Linux-2.5.28
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0207251126120.20754-100000@localhost.localdomain>
References: <20020724.225921.108418454.davem@redhat.com>
	<Pine.LNX.4.44.0207251126120.20754-100000@localhost.localdomain>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Ingo Molnar <mingo@elte.hu>
   Date: Thu, 25 Jul 2002 11:28:15 +0200 (CEST)
   
   i think the networking code is a special case - nothing else relies on the
   interaction of timers and IRQ contexts in such a deep way. (which it does
   for performance reasons.) I'd say 99% of all cli()/sti() users are in the
   'introduce a per-driver or per-subsystem lock' league Linus mentioned.
   
I'm sure the serial drivers used to.  Look at how they were using
SERIAL_BH for example.

RMK's stuff fixes that so wrt. the current state of affairs you're
probably right.

