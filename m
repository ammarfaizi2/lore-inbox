Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267621AbUHEKRr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267621AbUHEKRr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 06:17:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267620AbUHEKRr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 06:17:47 -0400
Received: from ns1.landhost.net ([66.98.188.87]:17556 "EHLO
	secure.landhost.net") by vger.kernel.org with ESMTP id S267621AbUHEKOp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 06:14:45 -0400
Message-ID: <41120882.40302@marcansoft.com>
Date: Thu, 05 Aug 2004 12:14:26 +0200
From: Hector Martin <hector@marcansoft.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; es-ES; rv:1.6) Gecko/20040409
X-Accept-Language: es-es, es, en-us, en
MIME-Version: 1.0
To: Pasi Sjoholm <ptsjohol@cc.jyu.fi>
CC: Francois Romieu <romieu@fr.zoreil.com>,
       Robert Olsson <Robert.Olsson@data.slu.se>,
       Linux-Kernel <linux-kernel@vger.kernel.org>, akpm@osdl.org,
       netdev@oss.sgi.com, brad@brad-x.com, shemminger@osdl.org
Subject: Re: ksoftirqd uses 99% CPU triggered by network traffic (maybe RLT-8139
 related)
References: <Pine.LNX.4.44.0408041915510.14609-100000@silmu.st.jyu.fi>
In-Reply-To: <Pine.LNX.4.44.0408041915510.14609-100000@silmu.st.jyu.fi>
X-Enigmail-Version: 0.83.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - secure.landhost.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - marcansoft.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pasi Sjoholm wrote:

>Ok, now I have tested it for 6 hours without crashing the driver. The 
>system's load has been something like 5-6 the whole time. I also made some 
>network load with ~90Mbps-incoming and ~90Mbps-outgoing traffic. 
>
>I haven't had time to test anything else but I'm quite sure that there is 
>no need for that anymore because the stability we have reached. 
>
>I'll let you know if there's any problems within next few days but I would 
>recommend that those patches would be included in 2.6.8. (without that "if 
>(received > 0) {").
>
>Many thanks for your help to resolve this problem. 
>
>Hector, have you tested these patches?
>
>  
>
Wow.. I gotta learn some more about kernel hacking someday.. lol

I applied both (new) -10 and -20 patches and removed the test.

I doubled the debug-messages that get sent to the PC (the UDP traffic) 
but it froze (the sender) and stopped sending them after 5 minutes. I 
guess that's because of the crappy TCP/IP stack on the other side (this 
is a PlayStation2 application i'm developing, and the homebrew PS2 
TCP/IP stack doesn't have a good reputation.) I'm back to normal 
debugging, I'll test it for a couple of hours. So far, no problem.
