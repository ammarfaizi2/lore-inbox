Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263540AbRFFQ3s>; Wed, 6 Jun 2001 12:29:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263554AbRFFQ3i>; Wed, 6 Jun 2001 12:29:38 -0400
Received: from sun.plan9.de ([213.69.218.222]:51615 "EHLO mailout.plan9.de")
	by vger.kernel.org with ESMTP id <S263540AbRFFQ32>;
	Wed, 6 Jun 2001 12:29:28 -0400
Date: Wed, 6 Jun 2001 18:29:26 +0200
From: Marc Lehmann <pcg@goof.com>
To: linux-kernel@vger.kernel.org
Subject: yellowfin-driver and symbios cards
Message-ID: <20010606182926.B9439@cerebro.laendle>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Operating-System: Linux version 2.4.5 (root@cerebro) (gcc version 2.95.2.1 19991024 (release)) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am using the yellowfin ethernet driver with my:

Ethernet controller: Symbios Logic Inc. (formerly NCR) 83C885 (rev 02)

card. I got *lots* of "transmit timed out messages" until I edited the driver
and changed:

#elif YF_NEW                                    /* A future perfect board
                                                   :->.  */

to

#elif YF_NEW||1                                    /* A future perfect board

Now I don't get any transmit timed out problems. I don't think this is a
bugfix, maybe this is just hiding a problem somewhere. Anyway, it seems
that my symbios card is "a future perfect board".

-- 
      -----==-                                             |
      ----==-- _                                           |
      ---==---(_)__  __ ____  __       Marc Lehmann      +--
      --==---/ / _ \/ // /\ \/ /       pcg@goof.com      |e|
      -=====/_/_//_/\_,_/ /_/\_\       XX11-RIPE         --+
    The choice of a GNU generation                       |
                                                         |
