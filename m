Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293434AbSCKBHP>; Sun, 10 Mar 2002 20:07:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293436AbSCKBHF>; Sun, 10 Mar 2002 20:07:05 -0500
Received: from pizda.ninka.net ([216.101.162.242]:3257 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S293434AbSCKBGx>;
	Sun, 10 Mar 2002 20:06:53 -0500
Date: Sun, 10 Mar 2002 17:03:38 -0800 (PST)
Message-Id: <20020310.170338.83978717.davem@redhat.com>
To: rgooch@ras.ucalgary.ca
Cc: laforge@gnumonks.org, skraw@ithnet.com, joe@tmsusa.com,
        linux-kernel@vger.kernel.org, elsner@zrz.TU-Berlin.DE
Subject: Re: Broadcom 5700/5701 Gigabit Ethernet Adapters
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200203110055.g2B0tiP24585@vindaloo.ras.ucalgary.ca>
In-Reply-To: <20020310163339.H16784@sunbeam.de.gnumonks.org>
	<20020310.164113.01028736.davem@redhat.com>
	<200203110055.g2B0tiP24585@vindaloo.ras.ucalgary.ca>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Richard Gooch <rgooch@ras.ucalgary.ca>
   Date: Sun, 10 Mar 2002 17:55:44 -0700

   David S. Miller writes:
   > The hardware is not capable of doing it, due to bugs in the hw
   > checksum implementation of the sk98 chipset.  They aren't being
   > "slow" they just can't possibly implement it for you.
   
   So what is currently the best combination of gige card/driver/cost?
   What do you recommend to the budget-conscious?

I can only tell you what I know performance wise about cards,
and currently it looks like:

1) Intel E1000
2) Tigon2, aka. Acenic
3) SysKonnect sk98, but has broken TX checksums.  If it had
   working TX checksums it would be in 2nd place instead of Acenic.
   This hw bug is essentially why Acenics were used for all the
   TUX benchmarks runs instead of SysKonnect cards.
4) Tigon3, aka. bcm57xx

This may surprise some people, but frankly I think the Tigon3's PCI
dma engine is junk based upon my current knowledge of the card.  It is
always possible I may find out something new which kills this
perception I have of the card, but we'll see...

All the cards listed above have good GPL'd drivers available.
