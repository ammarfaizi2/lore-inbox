Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277614AbRJHXnc>; Mon, 8 Oct 2001 19:43:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277622AbRJHXnW>; Mon, 8 Oct 2001 19:43:22 -0400
Received: from pizda.ninka.net ([216.101.162.242]:26503 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S277621AbRJHXnN>;
	Mon, 8 Oct 2001 19:43:13 -0400
Date: Mon, 08 Oct 2001 16:43:37 -0700 (PDT)
Message-Id: <20011008.164337.31640467.davem@redhat.com>
To: schuma@gaertner.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: PF_PACKET: packets out of order 
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200110082332.BAA16370@aunt.gaertner.de>
In-Reply-To: <200110082332.BAA16370@aunt.gaertner.de>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Joerg Schumacher <schuma@gaertner.de>
   Date: Tue, 9 Oct 2001 01:32:16 +0200 (MET DST)

   Hi!
   
   NeTraMet v44b10 uses pcap(3) and complains about timestamps jumping 
   backwards.  Looks like a PF_PACKET socket doesn't receive the packets 
   in the correct order.  Some timestamps from a "tcpdump -tt":
   
      RX:  1001465480.175100 [...] 
      TX:  1001465480.179111 [...] 
      RX:  1001465480.177315 [...] 
                      ^^^^^^
      TX:  1001465480.180514 [...]
      RX:  1001465480.179706 [...]

The receive packets are in order, as are the transmit packets.

Anything which absolutely _requires_ all TX and RX packets to
be in precise order, should really be fixed not to have such
a weird restriction.

Franks a lot,
David S. Miller
davem@redhat.com
