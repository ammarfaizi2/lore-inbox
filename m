Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263358AbTC0Rsa>; Thu, 27 Mar 2003 12:48:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263357AbTC0Rsa>; Thu, 27 Mar 2003 12:48:30 -0500
Received: from pizda.ninka.net ([216.101.162.242]:34277 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S263356AbTC0Rs0>;
	Thu, 27 Mar 2003 12:48:26 -0500
Date: Thu, 27 Mar 2003 09:55:37 -0800 (PST)
Message-Id: <20030327.095537.26269606.davem@redhat.com>
To: torvalds@transmeta.com
Cc: shmulik.hen@intel.com, dane@aiinet.com,
       bonding-devel@lists.sourceforge.net,
       bonding-announce@lists.sourceforge.net, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       mingo@redhat.com, kuznet@ms2.inr.ac.ru
Subject: Re: BUG or not? GFP_KERNEL with interrupts disabled.
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0303270917290.29072-100000@home.transmeta.com>
References: <20030327.054357.17283294.davem@redhat.com>
	<Pine.LNX.4.44.0303270917290.29072-100000@home.transmeta.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Linus Torvalds <torvalds@transmeta.com>
   Date: Thu, 27 Mar 2003 09:22:29 -0800 (PST)

   I do agree that we should obviously not run bottom halves with
   interrupts disabled
   
Ok, so can we add a:

	if (irqs_disabled())
		BUG();

check to do_softirq()?

I'll address the rest of your email in a bit.
