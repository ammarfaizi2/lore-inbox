Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262059AbSIYTEY>; Wed, 25 Sep 2002 15:04:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262063AbSIYTEY>; Wed, 25 Sep 2002 15:04:24 -0400
Received: from pizda.ninka.net ([216.101.162.242]:17870 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262059AbSIYTEX>;
	Wed, 25 Sep 2002 15:04:23 -0400
Date: Wed, 25 Sep 2002 11:59:14 -0700 (PDT)
Message-Id: <20020925.115914.106633211.davem@redhat.com>
To: mingo@elte.hu
Cc: green@namesys.com, zaitcev@redhat.com, mingo@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: cmpxchg in 2.5.38
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0209251024580.4690-100000@localhost.localdomain>
References: <20020925120725.A23559@namesys.com>
	<Pine.LNX.4.44.0209251024580.4690-100000@localhost.localdomain>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Ingo Molnar <mingo@elte.hu>
   Date: Wed, 25 Sep 2002 10:26:34 +0200 (CEST)
   
   It's only this place in the code that ever modifies that word, and
   that happens only once during the lifetime of this address, so i'll rather
   add a spinlock to the generic PID allocator code, it's a very very rare
   slowpath.

You can't define a crippled primitive like this Ingo.

What if someone else starts to use it?

And more importantly, if you can't use it on a datum shared between
userspace and the kernel, you have to name it something other than
cmpxchg or make the DRM use something else.
