Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269721AbSISBdG>; Wed, 18 Sep 2002 21:33:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269724AbSISBdG>; Wed, 18 Sep 2002 21:33:06 -0400
Received: from pizda.ninka.net ([216.101.162.242]:60046 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S269721AbSISBdF>;
	Wed, 18 Sep 2002 21:33:05 -0400
Date: Wed, 18 Sep 2002 18:28:55 -0700 (PDT)
Message-Id: <20020918.182855.47438220.davem@redhat.com>
To: greearb@candelatech.com
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Networking: send-to-self [link to non-broken patch
 this time]
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3D890A51.7000103@candelatech.com>
References: <3D8826BE.5090007@candelatech.com>
	<20020918.155534.102954410.davem@redhat.com>
	<3D890A51.7000103@candelatech.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Ben Greear <greearb@candelatech.com>
   Date: Wed, 18 Sep 2002 16:20:49 -0700

   David S. Miller wrote:
   > I don't think I'll be applying this:
   > 
   > 1) No tcp ipv6 bits
   
   I know squat about this, so am reluctant to hack code there.
   
It's hash lookup code, nearly identical to ipv4 version except
it's dealing with 128-bit IP addresses instead of 32-bit.

You give up way too easily, which leads me to belive you'll disappear
just as easily if complicated bugs stop popping up as a result of your
changes.

This is one of the most important issues I consider when I get a
delicate patch to the networking for someone, how fast they throw
their arms up in the air.

For example, someone like Arnaldo, when he sends me a patch and the
whole kernel explodes as a result I know he'll stick around for
however long it takes to fix the problems and he won't go "ipv6 looks
too complicated" when I ask him to submit a complete version of his
changes.

You patch should not be a maintainence burden to me.  Your attitude
tells me it is going to become one.

   See http://www.candelatech.com/sts2_hack.patch (32-bit only), it contains the missing
   bits, I'm not good at generating two patch sets (ie pktgen and send-to-self)
   when they touch the same file...
   
Don't include stuff in the patch that doesn't belong there, this isn't
so difficult.

   The #ifdefs were per request, I personally would like them not to be there
   either.  As far as I can tell, the changes are backwards compatible, so there
   should be no need for ifdefs.

I mean put the ifdefs in a header file such as tcp.h, not in the *.c
code.
   
   Thanks for looking at them.  I can fix the #ifdef cruft, but adding 64bit
   support or hacking ipv6 is beyond my means of testing at this point, so
   I cannot make those changes.
   
I don't require you to test the ipv6 portions, I will be able to
eyeball them and know if they are right or not, this is how simple
the ipv6 version of the tcp bits will be.
