Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263317AbRFFCww>; Tue, 5 Jun 2001 22:52:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263467AbRFFCwl>; Tue, 5 Jun 2001 22:52:41 -0400
Received: from f120.law3.hotmail.com ([209.185.241.120]:4362 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S263317AbRFFCwX>;
	Tue, 5 Jun 2001 22:52:23 -0400
X-Originating-IP: [65.25.189.2]
From: "John William" <jw2357@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Network Performance Testing Summary
Date: Wed, 06 Jun 2001 02:52:03 
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F120XA946xFRFtReq5G0000dddd@hotmail.com>
X-OriginalArrivalTime: 06 Jun 2001 02:52:03.0534 (UTC) FILETIME=[AA5D06E0:01C0EE33]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a follow up message to the original "Abysmal Receive Performance" 
message. Thanks to everyone who e-mailed me with suggestions.

Well, after poking around, I eventually narrowed the problem down to the 
fact that the system BIOS did not enable PCI->RAM write posting. After I 
enabled that with the bridge optimization setting in 2.2.19, network RECV 
performance went from ~5Mbps to 41Mbps.

The curse of the HP Vectra XU 5/90 strikes again!

What is interesting is that I tried the NetGear FA310, FA311, 3COM 3cSOHO 
and 3C905C-TX cards and both the receive and transmit speeds (measured with 
both iperf and netperf) were so close to each other as to be a non-issue.

Several people e-mailed me to let me know that "card 'X' performance is 
terrible, I can only get good performance with card 'Y'". So, I just thought 
I should send this message out to set things a bit straight.

I know this machine isn't exactly cutting-edge, but I have to admit I was a 
little surprised to see all four of the cards I tested clustered so close 
together (so close, that you could call it 41.8Mpbs RECV and 52.2Mbps XMIT 
for all cards).

FWIW, it is somewhat interesting that 2.4.3 performance is so horrible with 
PCI->RAM posting disabled, whereas 2.2.19 doesn't take nearly the same hit. 
Using the 1.1.7 Tulip driver from Sourceforge didn't change this at all. 
With write posting enabled, things 2.4.3 ended up performing better than 
2.2.19.

So, thanks to everyone who helped me out. Looks like I now need to start a 
FAQ just for Vectra XU 5/90 owners so they can get their machines to work...

- John

_________________________________________________________________
Get your FREE download of MSN Explorer at http://explorer.msn.com

