Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262135AbTEUNxr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 09:53:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262136AbTEUNxr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 09:53:47 -0400
Received: from rwcrmhc52.attbi.com ([216.148.227.88]:61112 "EHLO
	rwcrmhc52.attbi.com") by vger.kernel.org with ESMTP id S262135AbTEUNxo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 09:53:44 -0400
Message-ID: <3ECB87F5.8060808@acm.org>
Date: Wed, 21 May 2003 09:06:45 -0500
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030313
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul Rolland <rol@as2917.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: e100 latency, cpu cycle saver and e1000...
References: <00e701c31f76$26fea350$3f00a8c0@witbe>
In-Reply-To: <00e701c31f76$26fea350$3f00a8c0@witbe>
X-Enigmail-Version: 0.74.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My little program was crude at best.

You have to take into account what the machines are doing.  If you
notice, the "Min" latency is about the same, so it's not a CPU cycle
saver.  The long "Max" latencies mean you probably have something on IP2
that is blocking the execution of the IP stack (for, say up to 4.5ms). 
Are all the machine completely quiesced except for the test program? 
Have you tried switching the network connections to see if it is in the
network hardware?

-Corey

Paul Rolland wrote:

>Hello,
>
>A few days ago, there was a thread about e100 latency related to
>CPU Cycle Saver...
>
>Suggestion was to disabled it to return back to some "standard"
>latency.
>
>At the moment, I'm experiencing some strange behavior, not with
>an e100 but with an e1000 on a 2.4.20 kernel...
>
>Here are some traces, using Corey Minyard test application :
>
>[root@IP3 tmp]# ./test IP1 32000 10000 370
>Average: 201us, Max: 631us, Min: 200us
>[root@IP3 tmp]# ./test IP2 32000 10000 370
>Average: 422us, Max: 47581us, Min: 209us
>
>All three machines are using 2.4.20 and e1000 drivers, they are
>the same hardware.
>
>But, definitely, IP2 is exhibiting much higher max latency...
>
>Increasing the packet size up to 1200 bytes doesn't change the 
>global behavior : IP2 is always much "latent" than IP1...
>
>The problem is that it seems there is no CPU Cycle Saver on e1000
>NIC. Is there some equivalent ? Could someone give a guess on
>what's going on ?
>
>Regards,
>Paul
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>  
>


