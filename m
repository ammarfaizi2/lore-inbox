Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261864AbTERJTz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 May 2003 05:19:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261876AbTERJTz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 May 2003 05:19:55 -0400
Received: from pizda.ninka.net ([216.101.162.242]:21691 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S261864AbTERJTx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 May 2003 05:19:53 -0400
Date: Sun, 18 May 2003 02:31:51 -0700 (PDT)
Message-Id: <20030518.023151.77034834.davem@redhat.com>
To: fw@deneb.enyo.de
Cc: linux-kernel@vger.kernel.org, kuznet@ms2.inr.ac.ru, netdev@oss.sgi.com,
       linux-net@vger.kernel.org
Subject: Re: Route cache performance under stress
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <87iss87gqd.fsf@deneb.enyo.de>
References: <87d6iit4g7.fsf@deneb.enyo.de>
	<20030517.150933.74723581.davem@redhat.com>
	<87iss87gqd.fsf@deneb.enyo.de>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Florian Weimer <fw@deneb.enyo.de>
   Date: Sun, 18 May 2003 11:21:14 +0200

[ Please don't CC: sim@netnation.org any more, his address
  bounces at least for me (maybe his site rejects ECN, it is
  the most likely problem if it works for other people) ]

   "David S. Miller" <davem@redhat.com> writes:
   
   > I think your criticism of the routing cache is not well
   > founded.
   
   Well, what would change your mind?

I'll start to listen when you start to demonstrate that you understand
why the input routing cache is there and what problems it solves.

More people will also start to listen when you acutally discuss this
matter on the proper list(s) (which isn't linux-kernel, since
linux-net and netdev@oss.sgi.com are the proper places).  Most of the
net hackers have zero time to follow the enourmous amount of traffic
that exists on linux-kernel and picking out the networking bits.
Frankly, I /dev/null linux-kernel from time to time as well.

The fact is, our routing cache slow path is _FAST_.  And we garbage
collect routing cache entries, so the attacker's entries are deleted
quickly while the entries for legitimate flows stick around.  And
especially during an attack you want your legitimate traffic using the
routing cache.

I've never seen you mention this attribute of how the routing cache
works, nor have I seen you say anything which even suggests that you
are aware of this.  You could even make this apparent by proposing a
replacement for the input routing cache.  But remember, it has to
provide all of the functionality that is there today.

Nobody has demonstrated that there is a performance problem due to the
input routing cache once the hashing DoS is eliminated, which it is
in current kernels.  Take this as my challenge to you. :-)

   using FreeBSD is not always an option

Yeah, that dinosaur :-)
