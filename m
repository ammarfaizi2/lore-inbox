Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264218AbTEGTZV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 15:25:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264220AbTEGTZI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 15:25:08 -0400
Received: from pizda.ninka.net ([216.101.162.242]:59268 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S264218AbTEGTXt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 15:23:49 -0400
Date: Wed, 07 May 2003 11:28:41 -0700 (PDT)
Message-Id: <20030507.112841.63035160.davem@redhat.com>
To: chas@cmf.nrl.navy.mil
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] assorted atm patches
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200305071841.h47IfGW00890@relax.cmf.nrl.navy.mil>
References: <200305071841.h47IfGW00890@relax.cmf.nrl.navy.mil>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: chas williams <chas@cmf.nrl.navy.mil>
   Date: Wed, 7 May 2003 14:41:16 -0400

   [ATM]: drivers/atm/Makefile does not need this
   
Applied.

   [ATM]: ixmicro (now rapidwan) produces a version of these cards but
          they put the end station identifier (mac address to etherheads)
          in a different location in the eeprom.
   
Applied.

   [ATM]: its a good idea to make sure skb->cb is empty before passing the
          pdu's to the network stack (this will bite you on 64-bit platforms
          eventually)
   
Applied.  You appended the patch twice though, but I figured
that out before I applied it :-)

   [ATM]: ATM_PDU_OVHD is 0, isnt used consistently and probably should
          just go away (it might be more useful to have something like 
          hard_trailer_len).  overloading driver->tx_alloc() doesnt work
          for skb's coming from the network.  the driver->send() routine
          should just deal with poorly aligned skb's.  the default 
          alignment from alloc_tx() meets the needs for all drivers.
          further, no driver actually takes advantage of this feature.
          driver->free_rx_skb() isn't used and should just go away.
   
Applied.
   
   [ATM]: cleanup some oddities in the he driver (most are historical
          for one reason or another -- at one point iov_base did actually
          hold a pointer)  also, fixed a comment that was wrong.  the
          he finally has aal0 transmit support.
   
Applied, thanks Chas.
