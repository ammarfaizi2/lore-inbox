Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277316AbRJJQuE>; Wed, 10 Oct 2001 12:50:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277313AbRJJQty>; Wed, 10 Oct 2001 12:49:54 -0400
Received: from florence.buici.com ([206.124.142.26]:3200 "HELO
	florence.buici.com") by vger.kernel.org with SMTP
	id <S277315AbRJJQtm>; Wed, 10 Oct 2001 12:49:42 -0400
From: elf@florence.buici.com
Date: Wed, 10 Oct 2001 09:50:12 -0700
To: saw@saw.sw.com.sg, linux-kernel@vger.kernel.org
Subject: eepro100 selftest failure in 2.4.11 (and .10)
Message-ID: <20011010095012.A29307@buici.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I checked the released 2.4.11 kernel and found the same driver
failure as was present in the 2.4.10 kernel. 

I'm running Linux on a single-board computer that uses an Intel
ethernet chip, apparently i82557 compatible.  The 2.2.17 kernel boots
OK.  The 2.4.10 kernel fails to initialize the chip complaining
[thanks to kernel message scrollback]:

eth0: Intel Corporation 82557 [Ethernet Pro 100], 00:60:92:00:17:F4, IRQ 11
  Board assembly 721383-006, Physical connectors present: RJ45
  Primary interface chip 82555 PHY #1
Self test failed, status ffffffff:
  Failure to initialize the i82557.
  Verify that the card is in a bus-master capable slot.

   
When the 2.2.17 kernel boots, it reports that

  The receiver lock-up bug exists -- enabling workaround.

and all of the tests succeed.  The rest of the messages are the same
except for driver version information.
