Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264277AbUEXOMp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264277AbUEXOMp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 10:12:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264296AbUEXOMp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 10:12:45 -0400
Received: from mail45.messagelabs.com ([140.174.2.179]:35987 "HELO
	mail45.messagelabs.com") by vger.kernel.org with SMTP
	id S264277AbUEXOMl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 10:12:41 -0400
X-VirusChecked: Checked
X-Env-Sender: justin.piszcz@mitretek.org
X-Msg-Ref: server-23.tower-45.messagelabs.com!1085407960!3132520
X-StarScan-Version: 5.2.11; banners=-,-,-
X-Originating-IP: [141.156.156.57]
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Slow down across kernels
Date: Mon, 24 May 2004 10:12:14 -0400
Message-ID: <5D3C2276FD64424297729EB733ED1F76061000A8@email1.mitretek.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Slow down across kernels
Thread-Index: AcRA+7uGOaD3HZBPQN2JbLSHXlpCGQAnVUgQ
From: "Piszcz, Justin Michael" <justin.piszcz@mitretek.org>
To: "Phy Prabab" <phyprabab@yahoo.com>, <linux-kernel@vger.kernel.org>
Cc: "Al Piszcz" <apiszcz@solarrain.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is unreal! 
Have you tried 2.6.5 by the way?
What is it you are benchmarking if you can say?


-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Phy Prabab
Sent: Sunday, May 23, 2004 3:24 PM
To: linux-kernel@vger.kernel.org
Subject: Slow down across kernels

Hello,

Please cc me as I am not on this mailing list.

I have an issue with the 2.6 kernels that I am unable
to understand and correct.

I have a custom binary that I have used to compile
across different kernel versions and I am getting
vildly different numbers:
(as reported by time):

2.4.21-9  ~45s
2.4.22    ~55s
2.6.1     ~3m.40s
2.6.2     ~4m.00
2.6.3     ~4m.00
2.6.6     ~3m.15s
2.6.6-mm4 ~1m.30s

It is most shocking how much more time is spent in
user/kernel in comparsion:
2.4.21-9

5.09user 9.04system 0:43.79elapsed 32%CPU
(0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (7378946major+1139090minor)pagefaults
0swaps

VS.

2.6.6-mm4

13.06user 23.80system 1:32.00elapsed 40%CPU
(0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+7537027minor)pagefaults
0swaps


The system is AMD Opteron 246 w/12G RAM and broadcom
Ge.  To rule out network issues, I have moved the
files to the local files system, ext2 on a UW320
drive.

I have also tested this on a dual Xeon 3.06GHz w/8G
RAM ge with very similar results in differences across
the kernels.

strace and make -d show no major differences.

Kernels are built with gcc323/340 and bintuils
2.13.2.1.

Could someone help me understand what is at issue
here?

Thank you and appreciate the help.
Phy





	
		
__________________________________
Do you Yahoo!?
Yahoo! Domains - Claim yours for only $14.70/year
http://smallbusiness.promotions.yahoo.com/offer 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/


