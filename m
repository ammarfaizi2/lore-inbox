Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267158AbTB0WO4>; Thu, 27 Feb 2003 17:14:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267159AbTB0WO4>; Thu, 27 Feb 2003 17:14:56 -0500
Received: from 205-158-62-139.outblaze.com ([205.158.62.139]:9710 "HELO
	spf1.us.outblaze.com") by vger.kernel.org with SMTP
	id <S267158AbTB0WOz>; Thu, 27 Feb 2003 17:14:55 -0500
Message-ID: <20030227222440.14610.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Felipe Alfaro Solana" <felipe_alfaro@linuxmail.org>
To: linux-kernel@vger.kernel.org
Date: Thu, 27 Feb 2003 23:24:40 +0100
Subject: anticipatory scheduling questions
X-Originating-Ip: 213.4.13.153
X-Originating-Server: ws5-2.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, 
 
I have just installed 2.5.63-mm1 on my system and have been performing a very simple benchmarks. Here are 
my first results when compared against a RedHat 2.4.20-2.54 kernel: 
 
(All times expressed as total times) 
 
1. time dd if=/dev/zero of=/tmp/p bs=1024k count=256 
2.5.63-mm1 -> 0m12.737s 
2.4.20-2.54 -> 0m17.704s 
 
2. time cp /tmp/p /tmp/q 
2.5.63-mm1 -> 0m41.108s 
2.4.20-2.54 -> 0m51.939s 
 
3. time cmp /tmp/p /tmp/q 
2.5.63-mm1 -> 1m7.349s 
2.4.20-2.54 -> 0m58.966s 
 
4. time cmp /dev/zero /tmp/q 
2.5.63-mm1 -> 0m17.965s 
2.4.20-2.54 -> 0m14.038s 
 
The question is, why, apparently, is anticipatory scheduling perfomring worse than 2.4.20? Indeed, this can be 
tested interactively with an application like Evolution: I have configured Evolution to use 2 dictionaries (English 
and Spanish) for spell checking in e-mail messages. When running 2.4.20, if I choose to reply to a large 
message, it only takes a few seconds to read both dictionaries from disk and perform the spell checking. 
However, on 2.5.63-mm1 the same process takes considerably longer. Any reason for this? 
 
Thanks! 
 
Best regards, 
 
   Felipe Alfaro Solana 
 
-- 
______________________________________________
http://www.linuxmail.org/
Now with e-mail forwarding for only US$5.95/yr

Powered by Outblaze
