Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265492AbUGMQpd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265492AbUGMQpd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 12:45:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265493AbUGMQpd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 12:45:33 -0400
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:31888 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S265492AbUGMQp3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 12:45:29 -0400
Message-ID: <40F411B6.10200@eidetix.com>
Date: Tue, 13 Jul 2004 18:45:42 +0200
From: "David N. Welton" <davidw@eidetix.com>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040708)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: tcp connections dropped in 2.6.7
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ Please CC replies to me.  Thanks! If there is a more specific list, I 
will go there. ]

Hello,

This one has really got me stumped, and I would like to debug it if 
possible (although my boss would really like the machine to 'just 
work').  I think it's in the kernel because it affects all userspace 
programs equally.

The problem:

When logged into the machine via ssh, every so often the connection goes 
  down (not frozen, it goes away completely) and attempts to log back in 
fail.  Seemingly, networking comes back up ok if, from the server (the 
one with the problem) I generate some outgoing traffic - even a single 
icmp packet.  Pings to the machine in question normally run around 0.12 
ms from my machine, but slow down to 2 or 3 ms during the problem.

On a suggestion from someone, I tried turning off the windowing bit 
which has apparently caused some problems lately, but that doesn't help 
(I'm not going through a router in any case).

There are no messages at all in logfiles.  tcpdump doesn't show anything 
that looks obvious (to me at least... could be me not seeing something).

Seeing as how outgoing traffic seems to kick the connection back into 
shape, as a crutch I tried leaving a ping running, but it went down just 
the same.

As a network card, I'm using a realtek.  Initially I observed the 
problem with a forcedeth card, which we substituted thinking that might 
be the problem.

I don't seem to be able to recreate the problem.  It "just happens" 
every now and then.

I'll put a dmesg up at http://dedasys.com/dmesg.txt

Thankyou for your time,
-- 
David N. Welton
davidw@eidetix.com
