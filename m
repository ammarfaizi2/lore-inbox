Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262710AbTFJN3l (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 09:29:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262714AbTFJN3l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 09:29:41 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:5603 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S262710AbTFJN3k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 09:29:40 -0400
Message-ID: <3EE5E5AA.6020901@austin.ibm.com>
Date: Tue, 10 Jun 2003 09:05:30 -0500
From: Steven Pratt <slpratt@austin.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20021120 Netscape/7.01
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <piggin@cyberone.com.au>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.70-mm2 causes performance drop of random read O_DIRECT
References: <3EE5190D.3070401@austin.ibm.com> <3EE522AA.7020200@cyberone.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:

> Steven Pratt wrote:
>
>> Starting in 2.5.70-mm2 and continuing in the mm tree, there is a 
>> significant degrade in random read for block devices using 
>> O_DIRECT.   The drop occurs for all block sizes and ranges from 
>> 30%-40.  CPU usage is also lower although it may already be so low as 
>> to be irrelavent.
>
> Hi Steven, this is quite likely to be an io scheduler problem.
> Is your test program rawread v2.1.5?

This test was actually using 2.1.4, but the only difference in the 2.1.5 
version is a fix for the test label array for the aio versions of the 
test.  No functional change, just fixed the outputed test description.

> What is the command line you are using to invoke the program? 

rawread -t6 -p8 -m1 -d2 -s4096 -n65536 -l1 -z -x

Which you can find if you follow either results link and look in the 
benchmark directory where all raw benchmark out put is stored.

Steve





