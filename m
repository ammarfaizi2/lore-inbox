Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262380AbUGZV34@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262380AbUGZV34 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 17:29:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265487AbUGZV34
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 17:29:56 -0400
Received: from posti6.jyu.fi ([130.234.4.43]:58823 "EHLO posti6.jyu.fi")
	by vger.kernel.org with ESMTP id S262380AbUGZV2Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 17:28:25 -0400
Date: Tue, 27 Jul 2004 00:28:04 +0300 (EEST)
From: Pasi Sjoholm <ptsjohol@cc.jyu.fi>
X-X-Sender: ptsjohol@silmu.st.jyu.fi
To: Stephen Hemminger <shemminger@osdl.org>
cc: Francois Romieu <romieu@fr.zoreil.com>,
       H?ctor Mart?n <hector@marcansoft.com>,
       Linux-Kernel <linux-kernel@vger.kernel.org>, <akpm@osdl.org>,
       <netdev@oss.sgi.com>, <brad@brad-x.com>, <Robert.Olsson@data.slu.se>
Subject: Re: ksoftirqd uses 99% CPU triggered by network traffic (maybe
 RLT-8139 related)
In-Reply-To: <20040726095505.2ddb3bec@dell_ss3.pdx.osdl.net>
Message-ID: <Pine.LNX.4.44.0407270021200.11416-100000@silmu.st.jyu.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
X-Spam-Checked: by miltrassassin
	at posti6.jyu.fi; Tue, 27 Jul 2004 00:28:07 +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Jul 2004, Stephen Hemminger wrote:

>>>> I haven't been able to reproduce this with normal www-browsing or 
>>>> ssh-connections but it's always reproducible when my eth0 is under heavy 
>>>> load.
>>> I guess it can be reproduced even if the binary (nvidia ?) module is never
>>> loaded after boot, right ?

>> After 24 hours of hard working I can answer yes to this question. 
>> Now I can reproduce this from 2 to 15 minutes with 2 cp-processes from 
>> samba->workstation->nfs, some software building with make -j 3, playing 
>> some mp3 via nfs to notice when kernel goes down.. =) and so on..

>> After that ksoftirqd takes almost all the cpu-time and the network is not 
>> working at all.

> Is network traffic still coming in? 

At least tcpdump doesn't say anything, I can only see only arp-packets 
which my computer (not other computer's arp-packets) has made but no 
response to those.

> or perhaps there is a network packet that causes some soft irq to go 
> into an infinite loop. The recent iptables bug with ip options would be 
> an example.

That would make sense but Robert Olsson had some knowledge of this and 
said that this issue is probably the same that they have discussed in OSL.

--
Pasi Sjöholm


