Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751056AbVHUPrE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751056AbVHUPrE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Aug 2005 11:47:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751061AbVHUPrE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Aug 2005 11:47:04 -0400
Received: from web33303.mail.mud.yahoo.com ([68.142.206.118]:56236 "HELO
	web33303.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751056AbVHUPrB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Aug 2005 11:47:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=BwuQoHUzfBGgV5+koRcKx0bPOYZHBK17gDAl702stw3u3B6xoCui1N/D4iBCLqVYN5V66QFi101bEoY1pDyJ2NJDSUbv4OImVTxz9Wzpf3UpJ2mJS3eFRT3sskpDv+/QIbcyHU69yYA1BRRF/4umxSPylZVjI0EYY9KUFxCS/34=  ;
Message-ID: <20050821154654.63788.qmail@web33303.mail.mud.yahoo.com>
Date: Sun, 21 Aug 2005 08:46:54 -0700 (PDT)
From: Danial Thom <danial_thom@yahoo.com>
Reply-To: danial_thom@yahoo.com
Subject: 2.6.12 Performance problems
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just started fiddling with 2.6.12, and there
seems to be a big drop-off in performance from
2.4.x in terms of networking on a uniprocessor
system. Just bridging packets through the
machine, 2.6.12 starts dropping packets at
~100Kpps, whereas 2.4.x doesn't start dropping
until over 350Kpps on the same hardware (2.0Ghz
Opteron with e1000 driver). This is pitiful
prformance for this hardware. I've 
increased the rx ring in the e1000 driver to 512
with little change (interrupt moderation is set
to 8000 Ints/second). Has "tuning" for MP 
destroyed UP performance altogether, or is there
some tuning parameter that could make a 4-fold
difference? All debugging is off and there are 
no messages on the console or in the error logs.
The kernel is the standard kernel.org dowload
config with SMP turned off and the intel ethernet
card drivers as modules without any other
changes, which is exactly the config for my 2.4
kernels.

Danial


		
____________________________________________________
Start your day with Yahoo! - make it your home page 
http://www.yahoo.com/r/hs 
 
