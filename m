Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268502AbRGXWt0>; Tue, 24 Jul 2001 18:49:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268504AbRGXWtR>; Tue, 24 Jul 2001 18:49:17 -0400
Received: from mg02.austin.ibm.com ([192.35.232.12]:14780 "EHLO
	mg02.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S268502AbRGXWtB>; Tue, 24 Jul 2001 18:49:01 -0400
Content-Type: text/plain; charset=US-ASCII
From: Andrew Theurer <andrewt@austin.rr.com>
Reply-To: andrewt@austin.rr.com
To: linux-kernel@vger.kernel.org
Subject: Revisited: Samba, Linux 2.4 & Netbench Scalability
Date: Tue, 24 Jul 2001 17:46:46 -0700
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01072417464600.22214@linux>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Wed, 09 May, I sent email to LKML about my initial efforts for measuring 
samba scalability on linux 2.4.  I want to give you an update on what has 
been going on since then.  I also want to thank all that responded with 
suggestions; you have been very helpful.  OK, things that have changed:

hardware: 
-Same server (8 x 700 MHz/1MB L2 Xeon, Profusion chipset)
-New network: 4 x Intel PRO/1000-SX
-New clients: 44 (quantity changes based on availability) of
  PIII-866 MHz, 256MB, W2K (replaced 16 of PII-500, 128MB, NT4)

software:  
-Samba 2.0.7 -> Samba 2.2.0 (no major performance impact)
-Various linux kernels & patches, including zerocopy.


The hardware has changed some, but the core stuff is still there.  Netbench 
performance on a 4-way configuration is now at 755 Mbps.  Last time I 
reported, I measured 405 Mbps with the old config (16 slower clients and 8 
ethernet cards).  I had a significant jump with the new clients and Gbps 
ethernet (from  405 to 482 Mbps, to my surprise, mostly due to the new 
clients).  The results below show improvements after the new configuration 
was complete, and shows progression from 482 Mbps to 755 Mbps for a 4-way 
configuration.  Also, monthly baseline tests also include UP and 2P 
measurements.  

The main web page for all the results:
http://lse.sourceforge.net/benchmarks/netbench/

May's results show effects of socket buffer size, interrupt delay, and IRQ 
affinity: http://lse.sourceforge.net/benchmarks/netbench/results/may_2001/

June's results show effects of sendfile(), zerocopy, and process affinity:
http://lse.sourceforge.net/benchmarks/netbench/results/june_2001/

So far I am pleased with the performance of samba/linux.  However, I do think 
it can be improved, and I intend to do whatever I can to help make it better. 
 If you are interested in improving samba performance on linux, email me or 
contact the lse project on sourceforge (http://lse.sourceforge.net).

Regards,

Andrew Theurer
IBM LTC

