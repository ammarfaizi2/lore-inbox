Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129299AbRAaC7D>; Tue, 30 Jan 2001 21:59:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129393AbRAaC6x>; Tue, 30 Jan 2001 21:58:53 -0500
Received: from main.cyclades.com ([209.128.87.2]:44550 "EHLO cyclades.com")
	by vger.kernel.org with ESMTP id <S129299AbRAaC6p>;
	Tue, 30 Jan 2001 21:58:45 -0500
Date: Tue, 30 Jan 2001 18:58:43 -0800 (PST)
From: Ivan Passos <lists@cyclades.com>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Kernel 2.2.18: Protocol 0008 is buggy
Message-ID: <Pine.LNX.4.10.10101301831460.24409-100000@main.cyclades.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

I have a customer who's getting tons of these msgs in his LOGs:

kernel: protocol 0008 is buggy, dev hdlc0
kernel: protocol 0608 is buggy, dev hdlc0

The msg comes from net/core/dev.c, and this device is using the Cisco HDLC 
protocol in drivers/net/hdlc.c . However, AFAIK, 0008 and 0608 represent
IP and ARP (respectively), not Cisco HDLC. So ...

What I'd like to know is: what exactly causes this msg?? It seems that
it's printed when someone sends a packet without properly setting 
skb->nh.raw first, but who's supposed to set skb->nh.raw?? The HW driver??
The data link (HDLC) driver?? The kernel protocol drivers? How should I go
about fixing this problem, where should I start??

I'm at a total loss here. Any help would be really appreciated.

Later,
Ivan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
