Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267263AbTA0SN5>; Mon, 27 Jan 2003 13:13:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267264AbTA0SN5>; Mon, 27 Jan 2003 13:13:57 -0500
Received: from pizda.ninka.net ([216.101.162.242]:16017 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S267263AbTA0SN4>;
	Mon, 27 Jan 2003 13:13:56 -0500
Date: Mon, 27 Jan 2003 10:11:28 -0800 (PST)
Message-Id: <20030127.101128.104592362.davem@redhat.com>
To: lkernel2003@tuxers.net
Cc: linux-kernel@vger.kernel.org, kuznet@ms2.inr.ac.ru
Subject: Re: SSH Hangs in 2.5.59 and 2.5.55 but not 2.4.x, through Cisco PIX
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0301270920150.5267-100000@harappa.oldtrail.reston.va.us>
References: <Pine.LNX.4.44.0301241237160.29548-100000@harappa.oldtrail.reston.va.us>
	<Pine.LNX.4.44.0301270920150.5267-100000@harappa.oldtrail.reston.va.us>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: David C Niemi <lkernel2003@tuxers.net>
   Date: Mon, 27 Jan 2003 09:27:25 -0500 (EST)

   On Fri, 24 Jan 2003, David S. Miller wrote:
   > What happens if you comment out the enabling of
   > NETIF_F_TSO in drivers/net/e1000/e1000_main.c around
   > line 428? Does the problem persist? 
   
   Yes, the problem persists.
   
   Interesting that it seems to happen on a variety of Ethernet cards,
   I wonder if the problem's in the TCP area.

I think the clue in this thread is the TCP_NODELAY socket option.
The one post claimed that by turning this on in telnet, it made
telnet exhibit the same problems SSH shows.
