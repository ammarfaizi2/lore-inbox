Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261211AbSIYHwV>; Wed, 25 Sep 2002 03:52:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261268AbSIYHwV>; Wed, 25 Sep 2002 03:52:21 -0400
Received: from pizda.ninka.net ([216.101.162.242]:50121 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261211AbSIYHwV>;
	Wed, 25 Sep 2002 03:52:21 -0400
Date: Wed, 25 Sep 2002 00:47:19 -0700 (PDT)
Message-Id: <20020925.004719.61852840.davem@redhat.com>
To: green@namesys.com
Cc: zaitcev@redhat.com, mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: cmpxchg in 2.5.38
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020925111820.A23225@namesys.com>
References: <20020925010044.A4464@devserv.devel.redhat.com>
	<20020925111820.A23225@namesys.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Oleg Drokin <green@namesys.com>
   Date: Wed, 25 Sep 2002 11:18:20 +0400
   
   Ingo said that arches that cannot do cmpxchg in hardware should
   provide spinlock-based version.
   
That doesn't make any sense.

If cmpxchg cannot work with user bits of memory, like
cmpxchg is supposed to, it's really a crutch more than
anything else.

F.e. people will think that such systems can support DRM
correctly, they absolutely cannot.
