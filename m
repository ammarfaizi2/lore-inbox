Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263565AbTIHTqI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 15:46:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263566AbTIHTqI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 15:46:08 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:38117 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S263565AbTIHTqF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 15:46:05 -0400
Message-ID: <3F5CDC65.6060409@colorfullife.com>
Date: Mon, 08 Sep 2003 21:45:41 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030701
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Jamie Lokier <jamie@shareable.org>, Adrian Bunk <bunk@fs.tum.de>,
       linux-kernel@vger.kernel.org, peter_daum@t-online.de
Subject: Re: [2.4 patch] fix CONFIG_X86_L1_CACHE_SHIFT
References: <3F5B96C3.1060706@colorfullife.com> <20030908142046.GA28062@fs.tum.de> <20030908170751.GB27097@mail.jlokier.co.uk> <20030908172416.GA21226@gtf.org>
In-Reply-To: <20030908172416.GA21226@gtf.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:

>Yes; I've lost the specific context of the thread, but I have been
>working on MWI/cacheline size issues along with IvanK for a while.
>  
>
Context: Peter experiences very bad network performance with 2.4.22 - it 
looks like 99% packet drop or something like that. The packet drop 
disappears if CONFIG_L1_CACHE_SHIFT is set to 7 (i.e. 128 byte cache 
line size). 2.4.21 works.
The network cards are some kind of atm cards. Several systems are 
affected - at least Pentium II and PPro systems.

Peter: what's the exact brand and nic driver that you use? Could you try 
to figure out what exactly breaks? I'd use "ping -f -s 1500", perhaps 
together with "tcpdump -s 1500 -x" on both ends.

--
    Manfred

