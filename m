Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264682AbTGBEMR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 00:12:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264683AbTGBEMR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 00:12:17 -0400
Received: from smtp2.brturbo.com ([200.199.201.30]:49101 "EHLO
	smtp.brturbo.com") by vger.kernel.org with ESMTP id S264682AbTGBEMP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 00:12:15 -0400
Subject: [BENCHMARK] O1int with contest
From: Roberto Orenstein <orenstein@brturbo.com>
To: linux-kernel@vger.kernel.org
Cc: kernel@kolivas.org
Content-Type: text/plain
Organization: 
Message-Id: <1057120014.7919.23.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 02 Jul 2003 01:26:55 -0300
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

Here are some numbers from three kernels tested on my home machine.
All threes are 2.5.73 based.
Vanilla is a plain one, O1int-0307020011 is the latest (as I last
checked) O1int patch w/o the granularity patch, and
O1int-granu-0307020011 is the former with granularity.
One can see that with granularity, the kernel compile suffers a bit, but
the response is usually high. In my machine, this was the kernel with
the best responsiveness.

Each kernel was run once, except O1int-0307020011 with three iterations.
This was the first I tested, and as soon I noticed the time it took, I
decided to run once the others 8). Maybe this has some bad influence on
the results. I appreciate any comments...

regards,
Roberto

no_load:
Kernel                 [runs]	Time	CPU%	Loads	LCPU%	Ratio
O1int-0307020011            3	122	93.4	0.0	0.0	1.00
O1int-granu-0307020011      1	124	93.5	0.0	0.0	1.00
vanilla                     1	123	92.7	0.0	0.0	1.00
cacherun:
Kernel                 [runs]	Time	CPU%	Loads	LCPU%	Ratio
O1int-0307020011            3	115	99.1	0.0	0.0	0.94
O1int-granu-0307020011      1	119	97.5	0.0	0.0	0.96
vanilla                     1	116	98.3	0.0	0.0	0.94
process_load:
Kernel                 [runs]	Time	CPU%	Loads	LCPU%	Ratio
O1int-0307020011            3	161	70.8	72.5	27.3	1.32
O1int-granu-0307020011      1	166	69.9	79.0	28.7	1.34
vanilla                     1	160	71.2	79.0	27.5	1.30
ctar_load:
Kernel                 [runs]	Time	CPU%	Loads	LCPU%	Ratio
O1int-0307020011            3	154	77.3	1.0	3.2	1.26
O1int-granu-0307020011      1	163	74.8	2.0	7.4	1.31
vanilla                     1	161	74.5	2.0	7.5	1.31
xtar_load:
Kernel                 [runs]	Time	CPU%	Loads	LCPU%	Ratio
O1int-0307020011            3	160	72.5	1.0	6.2	1.31
O1int-granu-0307020011      1	166	71.1	1.0	7.2	1.34
vanilla                     1	160	72.5	1.0	7.5	1.30
io_load:
Kernel                 [runs]	Time	CPU%	Loads	LCPU%	Ratio
O1int-0307020011            3	310	39.0	66.3	15.4	2.54
O1int-granu-0307020011      1	332	36.7	75.8	16.3	2.68
vanilla                     1	306	39.5	71.7	16.7	2.49
io_other:
Kernel                 [runs]	Time	CPU%	Loads	LCPU%	Ratio
O1int-0307020011            3	286	42.3	62.3	16.0	2.34
O1int-granu-0307020011      1	296	41.2	65.4	15.9	2.39
vanilla                     1	364	33.2	93.0	18.7	2.96
read_load:
Kernel                 [runs]	Time	CPU%	Loads	LCPU%	Ratio
O1int-0307020011            3	156	75.0	5.4	3.2	1.28
O1int-granu-0307020011      1	159	75.5	5.7	3.8	1.28
vanilla                     1	155	76.1	5.7	3.9	1.26
list_load:
Kernel                 [runs]	Time	CPU%	Loads	LCPU%	Ratio
O1int-0307020011            3	147	79.6	0.0	7.5	1.20
O1int-granu-0307020011      1	149	79.2	0.0	7.4	1.20
vanilla                     1	147	79.6	0.0	7.5	1.20
mem_load:
Kernel                 [runs]	Time	CPU%	Loads	LCPU%	Ratio
O1int-0307020011            3	177	65.5	42.3	1.1	1.45
O1int-granu-0307020011      1	188	62.8	43.0	1.1	1.52
vanilla                     1	189	61.9	44.0	1.1	1.54
dbench_load:
Kernel                 [runs]	Time	CPU%	Loads	LCPU%	Ratio
O1int-0307020011            3	152	75.0	23535.3	19.1	1.25
O1int-granu-0307020011      1	142	82.4	20464.0	16.2	1.15
vanilla                     1	149	76.5	27791.0	20.8	1.21

