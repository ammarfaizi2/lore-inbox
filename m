Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285568AbRLSXZJ>; Wed, 19 Dec 2001 18:25:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285569AbRLSXY7>; Wed, 19 Dec 2001 18:24:59 -0500
Received: from colorfullife.com ([216.156.138.34]:32008 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S285568AbRLSXYj>;
	Wed, 19 Dec 2001 18:24:39 -0500
Message-ID: <3C2121B8.1030702@colorfullife.com>
Date: Thu, 20 Dec 2001 00:24:40 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us
MIME-Version: 1.0
To: Andreas Haumer <andreas@xss.co.at>
CC: linux-kernel@vger.kernel.org
Subject: Re: Deadlock: Linux-2.2.18, sym53c8xx, Compaq ProLiant, HP Ultrium
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>
>   After that, the amanda process hangs in state "D" and
>   cannot be killed anymore. The machine itself is still
>   working.
>  
>
If something is stuck in D state, always try sysrq-T.
This dumps the kernel stack of all processes. Check that the stuck 
process is logged (the kernel log can overflow if many processes are 
running), then parse the result through ksymoops.
This shows you/us where it stuck.

--
    Manfred

