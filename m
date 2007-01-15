Return-Path: <linux-kernel-owner+w=401wt.eu-S1751125AbXAOVzU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751125AbXAOVzU (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 16:55:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751326AbXAOVzU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 16:55:20 -0500
Received: from pne-smtpout4-sn2.hy.skanova.net ([81.228.8.154]:35898 "EHLO
	pne-smtpout4-sn2.hy.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751125AbXAOVzT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 16:55:19 -0500
Date: Mon, 15 Jan 2007 23:55:15 +0200
From: Sami Farin <7atbggg02@sneakemail.com>
To: linux-kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: I broke my port numbers :(
Message-ID: <20070115215515.GA3771@m.safari.iki.fi>
Mail-Followup-To: linux-kernel Mailing List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I know this may be entirely my fault but I have tried reversing
all of my _own_ patches I applied to 2.6.19.2 but can't find what broke this.
I did three times "netcat 127.0.0.69 42", notice the different
port numbers.

First, if someone could attempt this on 2.6.19.2 or 2.6.20-rc* ,
and tell it works, I shut up.

2007-01-15 23:42:05.833636 IP (tos 0x0, ttl  61, id 34230, offset 0, flags [DF], proto: TCP (6), length: 60) 127.0.0.69.23287 > 127.0.0.69.42: SWE, cksum 0x0281 (correct), 674651575:674651575(0) win 32792 <mss 16396,sackOK,timestamp 1616544 0,nop,wscale 4>
2007-01-15 23:42:05.833673 IP (tos 0x0, ttl  61, id 0, offset 0, flags [DF], proto: TCP (6), length: 40) 127.0.0.69.42 > 127.0.0.69.52935: R, cksum 0x5c66 (correct), 0:0(0) ack 674651576 win 0

2007-01-15 23:42:06.009245 IP (tos 0x0, ttl  61, id 11189, offset 0, flags [DF], proto: TCP (6), length: 60) 127.0.0.69.20161 > 127.0.0.69.42: SWE, cksum 0x96b3 (correct), 678941897:678941897(0) win 32792 <mss 16396,sackOK,timestamp 1616720 0,nop,wscale 4>
2007-01-15 23:42:06.009289 IP (tos 0x0, ttl  61, id 0, offset 0, flags [DF], proto: TCP (6), length: 40) 127.0.0.69.42 > 127.0.0.69.52936: R, cksum 0xe511 (correct), 0:0(0) ack 678941898 win 0

2007-01-15 23:42:06.169587 IP (tos 0x0, ttl  61, id 36607, offset 0, flags [DF], proto: TCP (6), length: 60) 127.0.0.69.52470 > 127.0.0.69.42: SWE, cksum 0x15b5 (correct), 681498315:681498315(0) win 32792 <mss 16396,sackOK,timestamp 1616880 0,nop,wscale 4>
2007-01-15 23:42:06.169624 IP (tos 0x0, ttl  61, id 0, offset 0, flags [DF], proto: TCP (6), length: 40) 127.0.0.69.42 > 127.0.0.69.52937: R, cksum 0xe2e7 (correct), 0:0(0) ack 681498316 win 0

If something was listening on port 42, it would see the wrong port,
e.g. 23287, 20161 or 52470, not 52935, 52936 or 52937.

-- 
