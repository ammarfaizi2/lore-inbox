Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290745AbSBLDTG>; Mon, 11 Feb 2002 22:19:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290746AbSBLDS5>; Mon, 11 Feb 2002 22:18:57 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:18942 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S290745AbSBLDSp>;
	Mon, 11 Feb 2002 22:18:45 -0500
From: David Mosberger <davidm@hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15464.35214.669412.477377@napali.hpl.hp.com>
Date: Mon, 11 Feb 2002 19:18:38 -0800
To: "David S. Miller" <davem@redhat.com>
Cc: davidm@hpl.hp.com, anton@samba.org, linux-kernel@vger.kernel.org,
        zippel@linux-m68k.org
Subject: Re: thread_info implementation
In-Reply-To: <20020211.190449.55725714.davem@redhat.com>
In-Reply-To: <15464.33256.837784.657759@napali.hpl.hp.com>
	<20020211.185100.68039940.davem@redhat.com>
	<15464.34183.282646.869983@napali.hpl.hp.com>
	<20020211.190449.55725714.davem@redhat.com>
X-Mailer: VM 7.00 under Emacs 21.1.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Mon, 11 Feb 2002 19:04:49 -0800 (PST), "David S. Miller" <davem@redhat.com> said:

  DaveM> You don't have any facts, you just "think" it will slow
  DaveM> things down because of the pointer dereference.  I challenge
  DaveM> you to show it actually shows up on the performance radar.

  DaveM> The thing is going to be fully hot in the cache all the time,
  DaveM> there is no way you'll take a cache miss for this
  DaveM> dereference.

Let's see: on Itanium, a ld takes up an M slot and has a 2 cycle
access latency (if in the first level cache).  This may or may not be
noticable in benchmarks, but it certainly won't go faster.  And all
this just for task coloring (which we can do with the old set up just
fine)?

	--david
