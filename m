Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265293AbUHRLKg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265293AbUHRLKg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 07:10:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265317AbUHRLKf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 07:10:35 -0400
Received: from gwout.thalesgroup.com ([195.101.39.227]:25350 "EHLO
	GWOUT.thalesgroup.com") by vger.kernel.org with ESMTP
	id S265293AbUHRLKd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 07:10:33 -0400
Message-ID: <41233923.80202@fr.thalesgroup.com>
Date: Wed, 18 Aug 2004 13:10:27 +0200
From: "P.O. Gaillard" <pierre-olivier.gaillard@fr.thalesgroup.com>
Reply-To: pierre-olivier.gaillard@fr.thalesgroup.com
Organization: Thales Air Defence
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: voluntary-preempt-2.6.8.1-P1 seems to lose UDP messages.
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have a real-time application that transmits 20 MBytes/s over UDP/Gigabit 
Ethernet between 2 PCs. The NICs are from Intel and use the e1000 driver 
(MTU=1500). On the receive side, the computer has to process the data (real-time 
tasks doing signal processing work and using up 50% of the CPU time).

This app works OK with 2.6.7 and 2.6.8.1 : the app does not complain about lost 
messages.

But when I use the voluntary-preemt-2.6.8.1-P1 patch on the receiving PC, the 
app starts complaining about lost messages. And also, netstat -s -u shows that 
lots of UDP packets are lost (on the PC that receives the data).
[root@centaurus root]# netstat -u -s
Udp:
     8433 packets received
     0 packets to unknown port received.
     869 packet receive errors
     366 packets sent

I have already retried with the e1000 parameters RxIntDelay=0 and 
RxDescriptors=1024. This did not improve anything.

Note: I don't see any error message with dmesg nor in /var/log/messages.

I find the voluntary-preempt series very important and would really like it to 
make its way into the stock kernel. I would therefore gladly make additional 
tests to help you find the problem. Please give me directions.


	thanks for your help,

	P.O. Gaillard


