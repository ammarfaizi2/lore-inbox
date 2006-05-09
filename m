Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751139AbWEIUap@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751139AbWEIUap (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 16:30:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751152AbWEIUao
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 16:30:44 -0400
Received: from mta2.cl.cam.ac.uk ([128.232.0.14]:1220 "EHLO mta2.cl.cam.ac.uk")
	by vger.kernel.org with ESMTP id S1751139AbWEIUan (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 16:30:43 -0400
In-Reply-To: <20060509132556.76deaa91@localhost.localdomain>
References: <20060509084945.373541000@sous-sol.org> <20060509085201.446830000@sous-sol.org> <20060509132556.76deaa91@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <6a1855ab01a195ac2a28a97c5f966f67@cl.cam.ac.uk>
Content-Transfer-Encoding: 7bit
Cc: virtualization@lists.osdl.org, Ian Pratt <ian.pratt@xensource.com>,
       xen-devel@lists.xensource.com, linux-kernel@vger.kernel.org,
       Chris Wright <chrisw@sous-sol.org>, netdev@vger.kernel.org
From: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Subject: Re: [RFC PATCH 34/35] Add the Xen virtual network device driver.
Date: Tue, 9 May 2006 21:26:11 +0100
To: Stephen Hemminger <shemminger@osdl.org>
X-Mailer: Apple Mail (2.623)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 9 May 2006, at 21:25, Stephen Hemminger wrote:

>> +	memcpy(netdev->dev_addr, info->mac, ETH_ALEN);
>> +	network_connect(netdev);
>> +	info->irq = bind_evtchn_to_irqhandler(
>> +		info->evtchn, netif_int, SA_SAMPLE_RANDOM,
>> netdev->name,
>>
>
> This doesn't look like a real random entropy source. packets
> arriving from another domain are easily timed.

Where should we get our entropy from in a VM environment? Leaving the 
pool empty can cause processes to hang.

  -- Keir

