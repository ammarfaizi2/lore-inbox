Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261297AbTI3KzQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 06:55:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261325AbTI3KzQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 06:55:16 -0400
Received: from law12-f106.law12.hotmail.com ([64.4.19.106]:44043 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S261297AbTI3KzL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 06:55:11 -0400
X-Originating-IP: [192.6.111.72]
X-Originating-Email: [a1b2c3d4_66@hotmail.com]
From: =?iso-8859-1?B?bWFyaW8gY2FtdfFhcw==?= <a1b2c3d4_66@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Is kswapd working right?
Date: Tue, 30 Sep 2003 10:55:10 +0000
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Message-ID: <Law12-F106mnzMdOssA00047399@hotmail.com>
X-OriginalArrivalTime: 30 Sep 2003 10:55:10.0533 (UTC) FILETIME=[516E8F50:01C38741]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

  Our scenario is the following:

	 One web server runninng kernel 2.4.9-e-12(smp), it is used to host an 
Apache webserver with an integrated application server. The system has 2Gb 
of RAM and 2Gb of swap. The last day an strange thing happened. We tried to 
connect to our system using ssh and we can´t, after many attempts we could 
connect to the system and saw that we couldn´t connect because there was a 
lack of memory. Every proccess you tried to start failed  and gave the 
following error message" fork failed: Can´t allocate memory (errno=12)".

The output of the free -k command showed that the swap space(there was only 
5 Mb of free RAM) wasn´t being used and we don´t understand why. We have 
found a lot of similar cases of systems that couldn´t fork but were plenty 
of unused swap space so we thought we would find answers for this problem 
but we haven´t found any(although we have looked for one a lot).

    We think that perhaps our freepages settings are too low( 1.6-4.5-7.4 
Mb) and if we merge this low values with an excesive fragmented memory this 
could explain our memory squeeze problems. Some of us have proposed the 
theory that everytime a proccess is started it needs a little quantity of 
contiguous memory and that if the system can´t provide it to the process it 
dies before the fork is completed. Any idea about what can be happening 
here?

Regards,
Mario.

_________________________________________________________________
Descubre el mayor catálogo de coches de la Red en MSN Motor. 
http://motor.msn.es/researchcentre/

