Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280592AbRKNNpX>; Wed, 14 Nov 2001 08:45:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280591AbRKNNpN>; Wed, 14 Nov 2001 08:45:13 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:40610 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S280592AbRKNNpB>; Wed, 14 Nov 2001 08:45:01 -0500
Message-ID: <3BF27557.30007@sap.com>
Date: Wed, 14 Nov 2001 14:44:55 +0100
From: Willi =?ISO-8859-1?Q?N=FC=DFer?= <wilhelm.nuesser@sap.com>
Organization: SAP AG
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: Comparison of PAE and Non-PAE 2..4.14 (p8) in high load
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-SAP: out
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

after my first posting to lkml where we compared distributor
provided kernels vs. a plain 2.4.14-pre8 it was pointed
out that between PAE and non-PAE kernels some performance
differences might exist.


We checked this last night and here are the first results.
Again,
a) the relevant quantity dialog steps per second is a
measure for the throughput our application servers runs.
b) our application server and the corresponding database
(SAP DB) run on 4 way Dell, 1 GB at boot time enabled.

Results:
---------

2.4.7 
	2.4.14p8 PAE		2.4.14p4 non- PAE
-------------------------------------------------------------
   1.80		13.42            	15.47
   1.10		13.28            	14.76
   1.20 		14.08            	14.63
   1.26     	13.17            	15.30
   1.35		13.41            	14.51


This means that we did see a performance decrease of about
6 % compared to 2.4.14p8 nonPAE but still 2.4.14p8 is an order
of magnitude faster than 2.4.7

-- 
Best regards
	Willi

-----------------------------------
Willi Nuesser
SAP Linuxlab

