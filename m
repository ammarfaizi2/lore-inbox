Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270761AbTGNTtL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 15:49:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270764AbTGNTtK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 15:49:10 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:44938 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S270761AbTGNTsY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 15:48:24 -0400
Message-ID: <3F130C75.3010603@pobox.com>
Date: Mon, 14 Jul 2003 16:03:01 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: David griego <dagriego@hotmail.com>
CC: alan@storlinksemi.com, linux-kernel@vger.kernel.org
Subject: Re: Alan Shih: "TCP IP Offloading Interface"
References: <Sea2-F4kWkKEsEXlwM9000178d9@hotmail.com>
In-Reply-To: <Sea2-F4kWkKEsEXlwM9000178d9@hotmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David griego wrote:
> Intel Clusters and Network Storage Volume Platforms Lab reported that it 
> takes about 1MHz to process 1Mbps on a PIII.  Using this rule of thumb 
> (they showed it scaling from 400MHz to 800MHz) it would take 10GHz to 
> process 10Mbps.  Well you might say "what about multi-processers?"  This 

Um.  It doesn't take nearly 10Ghz to handle 10Mbps, or even 100Mbps.


> would be good for people that have multi-processors, but there is a 
> large segment of embedded processors that are not going have SMP, or be 
> at 10GHz anytime soon.  Besides that processing interrupts does not 
> scale across MPs liniarly.  The truth is that communication speeds are 
> outpacing processor speeds at this time.

If the host CPU is a bottleneck after large-send and checksums have been 
offloaded, then logically you aren't getting any work done _anyway_. 
You have to interface with the net stack at some point, in which case 
you incur a fixed cost, for socket handling, TCP exception handling, etc.

Maybe somebody needs to be looking into AMP (asymmetric 
multiprocessing), too.

	Jeff



