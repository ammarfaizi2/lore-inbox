Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271904AbTHDQfO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 12:35:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271919AbTHDQfO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 12:35:14 -0400
Received: from dhcp-20-253.via-eth.ch ([192.33.101.253]:28133 "EHLO
	spyro.moor.ws") by vger.kernel.org with ESMTP id S271904AbTHDQfI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 12:35:08 -0400
Message-ID: <3F2E8B3B.3070003@netpeople.ch>
Date: Mon, 04 Aug 2003 18:35:07 +0200
From: Patrick Moor <pmoor@netpeople.ch>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030728
X-Accept-Language: en-us, en, de-ch, de, fr
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: time jumps (again)
X-Enigmail-Version: 0.76.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Some days ago I started noticing strange time jumps on my Athlon system. 
(Asus board, VIA chipset, AMD Athlon 650MHz processor). I haven't 
noticed them before and I am pretty sure there weren't any for the last 
few years! Uptime of the machine is now 218 days, and problems began 
appearing after 215 days approximately.

What happens: when doing a
  $ while true; do date; done
I'm noticing time jumps _exactly_ at the beginning of a "new" second (or 
at the end of an "old" one). the jump is exactly 4294 (4295) seconds 
into the future. Example:
...
Mon Aug  4 18:11:06 CEST 2003
Mon Aug  4 18:11:06 CEST 2003
Mon Aug  4 19:22:41 CEST 2003
Mon Aug  4 19:22:41 CEST 2003
Mon Aug  4 19:22:41 CEST 2003
Mon Aug  4 18:11:07 CEST 2003
Mon Aug  4 18:11:07 CEST 2003
...

I've found some previous discussions about this about a year ago:

   http://www.ussg.iu.edu/hypermail/linux/kernel/0203.3/0557.html
   http://www.ussg.iu.edu/hypermail/linux/kernel/0206.0/1505.html

What seems strange to me is, that these jumps have never occured before. 
The machine is running a plain 2.4.20 kernel.

So my question is: will disabling the CONFIG_X86_TSC option and passing 
"notsc" as boot parameter fix the problem? Or did I get something wrong 
there?

thanks
  patrick


