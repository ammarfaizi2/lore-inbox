Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262312AbTFKArS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 20:47:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262413AbTFKArS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 20:47:18 -0400
Received: from dyn-ctb-210-9-246-243.webone.com.au ([210.9.246.243]:54279 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S262312AbTFKArL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 20:47:11 -0400
Message-ID: <3EE67F38.9030702@cyberone.com.au>
Date: Wed, 11 Jun 2003 11:00:40 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030327 Debian/1.3-4
X-Accept-Language: en
MIME-Version: 1.0
To: Steven Pratt <slpratt@austin.ibm.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.70-mm2 causes performance drop of random read O_DIRECT
References: <3EE5190D.3070401@austin.ibm.com> <3EE522AA.7020200@cyberone.com.au> <3EE5E5AA.6020901@austin.ibm.com>
In-Reply-To: <3EE5E5AA.6020901@austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Steven Pratt wrote:

> Nick Piggin wrote:
>
>> Steven Pratt wrote:
>>
>>> Starting in 2.5.70-mm2 and continuing in the mm tree, there is a 
>>> significant degrade in random read for block devices using 
>>> O_DIRECT.   The drop occurs for all block sizes and ranges from 
>>> 30%-40.  CPU usage is also lower although it may already be so low 
>>> as to be irrelavent.
>>
>>
>> Hi Steven, this is quite likely to be an io scheduler problem.
>> Is your test program rawread v2.1.5?
>
>
> This test was actually using 2.1.4, but the only difference in the 
> 2.1.5 version is a fix for the test label array for the aio versions 
> of the test.  No functional change, just fixed the outputed test 
> description.
>
>> What is the command line you are using to invoke the program? 
>
>
> rawread -t6 -p8 -m1 -d2 -s4096 -n65536 -l1 -z -x
>
> Which you can find if you follow either results link and look in the 
> benchmark directory where all raw benchmark out put is stored.
>

OK thanks, I can now reproduce this! I'll work on it.

