Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750723AbWCYCwG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750723AbWCYCwG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 21:52:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750754AbWCYCwG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 21:52:06 -0500
Received: from mail23.syd.optusnet.com.au ([211.29.133.164]:15326 "EHLO
	mail23.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1750723AbWCYCwF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 21:52:05 -0500
From: Con Kolivas <kernel@kolivas.org>
To: linux list <linux-kernel@vger.kernel.org>
Subject: [benchmark] Interbench 2.6.16-ck/mm
Date: Sat, 25 Mar 2006 13:51:56 +1100
User-Agent: KMail/1.9.1
Cc: ck list <ck@vds.kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603251351.57341.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are interbench numbers for a pentium4 HT with 2.6.16-ck1 and 2.6.16-mm1

The rules I use for flagging diffferences are:
1. Deadlines met is the primary endpoint.
2. When latency is out of bounds, what is the worst max latency as that will 
be the most noticeable jerkiness, stutter etc, but I only flag them if at 
least one value is >=7ms since that is required to be human perceptible. 

Using 2036365 loops per ms, running every load for 30 seconds
Benchmarking kernel 2.6.16-ck1 at datestamp 200603250244

--- Benchmarking simulated cpu of Audio in the presence of simulated ---
Load	Latency +/- SD (ms)  Max Latency   % Desired CPU  % Deadlines Met
None	  0.015 +/- 0.0159     0.023 		 100	        100
Video	  0.757 +/- 0.881          2		 100	        100
X	  0.051 +/- 0.189       1.02 		 100	        100
Burn	  0.019 +/- 0.0201     0.056 *		 100 	        100 *
Write	  0.055 +/- 0.344       4.83		 100	        100
Read	  0.024 +/- 0.0251     0.064		 100	        100
Compile	   0.03 +/- 0.0888      1.69		 100	        100
Memload	  0.321 +/- 4.94         112		99.8	       99.8

--- Benchmarking simulated cpu of Video in the presence of simulated ---
Load	Latency +/- SD (ms)  Max Latency   % Desired CPU  % Deadlines Met
None	  0.016 +/- 0.0162     0.028		 100	        100
X	  0.043 +/- 0.17        2.01 *		 100	        100 *
Burn	  0.188 +/- 2.33        45.3 *		99.6	       99.2 *
Write	  0.043 +/- 0.558       16.7 *		 100	       99.9 *
Read	  0.021 +/- 0.0217     0.078 *		 100	        100 
Compile	  0.093 +/- 1.08        18.4 *		 100	       99.6 *
Memload	  0.385 +/- 4.83         138		98.9	       98.3 *

--- Benchmarking simulated cpu of X in the presence of simulated ---
Load	Latency +/- SD (ms)  Max Latency   % Desired CPU  % Deadlines Met
None	  0.026 +/- 0.356          6 *		 100	         99 *
Video	     14 +/- 26.5          72 *		35.6	       26.5 *
Burn	   51.4 +/- 98.4         456 *		15.1	       7.91 *
Write	   2.19 +/- 6.65          36 *		78.6	       71.1
Read	  0.756 +/- 3.33          24 *		90.6	         86
Compile	   34.5 +/- 53.8         165 *		20.7	       11.6 *
Memload	   4.05 +/- 12.6          80		73.3	       66.8

--- Benchmarking simulated cpu of Gaming in the presence of simulated ---
Load	Latency +/- SD (ms)  Max Latency   % Desired CPU
None	   1.49 +/- 6.03        34.8 *		98.5 *
Video	   68.7 +/- 68.9          74 *		59.3
X	   60.7 +/- 70.6         143		62.2
Burn	    514 +/- 534          602 *		16.3
Write	   20.6 +/- 31.4         109 *		82.9
Read	   7.77 +/- 9.04        31.3		92.8
Compile	    436 +/- 459          697 *		18.7
Memload	   27.1 +/- 58.3         755		78.7 *



Using 2036365 loops per ms, running every load for 30 seconds
Benchmarking kernel 2.6.16-mm1 at datestamp 200603250939

--- Benchmarking simulated cpu of Audio in the presence of simulated ---
Load	Latency +/- SD (ms)  Max Latency   % Desired CPU  % Deadlines Met
None	  0.012 +/- 0.0121     0.023		 100	        100
Video	   1.16 +/- 1.24        2.01		 100	        100
X	  0.302 +/- 0.681       2.01		 100	        100
Burn	  0.365 +/- 8.63         211		99.7	       99.7
Write	  0.017 +/- 0.0193     0.072		 100	        100
Read	   0.02 +/- 0.0209     0.056		 100	        100
Compile	  0.019 +/- 0.0196     0.046		 100	        100
Memload	  0.092 +/- 0.623         11 *	 	 100 *	        100 *

--- Benchmarking simulated cpu of Video in the presence of simulated ---
Load	Latency +/- SD (ms)  Max Latency   % Desired CPU  % Deadlines Met
None	  0.011 +/- 0.0114      0.04		 100	        100
X	  0.885 +/- 3.73        18.7		 100	       95.8
Burn	  0.977 +/- 22.6         934		98.4	       95.9
Write	  0.047 +/- 0.789       23.7		 100	       99.8
Read	  0.017 +/- 0.0181     0.058		 100	        100
Compile	    1.6 +/- 17.6         370		96.5	       94.5
Memload	  0.501 +/- 3.48        44.4 *		98.9	       97.4

--- Benchmarking simulated cpu of X in the presence of simulated ---
Load	Latency +/- SD (ms)  Max Latency   % Desired CPU  % Deadlines Met
None	  0.255 +/- 2.25          27		94.1	       93.3
Video	   14.8 +/- 27.7          76		34.8	       25.5
Burn	   39.4 +/- 75.6         505		13.1	       7.07
Write	    1.6 +/- 6.17          48		78.7	       74.9 *
Read	  0.709 +/- 3.26          30		91.2	         88 *
Compile	   42.9 +/- 80.5         667		11.3	       5.61
Memload	   2.23 +/- 7.24          42 *		71.4	       66.8

--- Benchmarking simulated cpu of Gaming in the presence of simulated ---
Load	Latency +/- SD (ms)  Max Latency   % Desired CPU
None	   5.31 +/- 19           123		  95
Video	   69.8 +/- 70.1        80.1		58.9 *
X	   60.3 +/- 70.3         120 *		62.4
Burn	    295 +/- 310          710		25.3 *
Write	   17.3 +/- 30.8         110		85.2 *
Read	   5.64 +/- 6.45        20.3 *		94.7 *
Compile	    392 +/- 420          713		20.3
Memload	   27.8 +/- 47.8         430 *		78.3


Summary:
	Deadlines	Max Latencies
	ck	mm	ck	mm
Audio 	1	1	1	1
Video	5	0	5	1
X	4	2	6	1
Game	2	4	5	3

Note that most of the differences between -ck and -mm on this benchmark are 
due to the staircase cpu scheduler in -ck. It has staircase v14.2 as recently 
posted to the mailing list.

Cheers,
Con
