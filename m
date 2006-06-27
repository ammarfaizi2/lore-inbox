Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964862AbWF0Jer@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964862AbWF0Jer (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 05:34:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964858AbWF0Jer
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 05:34:47 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:23311 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S964832AbWF0Jep
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 05:34:45 -0400
Message-ID: <44A0FBAC.7020107@fr.ibm.com>
Date: Tue, 27 Jun 2006 11:34:36 +0200
From: Daniel Lezcano <dlezcano@fr.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrey Savochkin <saw@swsoft.com>
CC: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, serue@us.ibm.com,
       haveblue@us.ibm.com, clg@fr.ibm.com, Andrew Morton <akpm@osdl.org>,
       dev@sw.ru, herbert@13thfloor.at, devel@openvz.org, sam@vilain.net,
       ebiederm@xmission.com, viro@ftp.linux.org.uk,
       Alexey Kuznetsov <alexey@sw.ru>
Subject: Re: [patch 2/6] [Network namespace] Network device sharing by view
References: <20060609210202.215291000@localhost.localdomain> <20060609210625.144158000@localhost.localdomain> <20060626134711.A28729@castle.nmd.msu.ru> <449FF5A0.2000403@fr.ibm.com> <20060626192751.A989@castle.nmd.msu.ru> <44A00215.2040608@fr.ibm.com> <20060627131136.B13959@castle.nmd.msu.ru>
In-Reply-To: <20060627131136.B13959@castle.nmd.msu.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrey Savochkin wrote:
> Daniel,
> 
> On Mon, Jun 26, 2006 at 05:49:41PM +0200, Daniel Lezcano wrote:
> 
>>>Then you lose the ability for each namespace to have its own routing entries.
>>>Which implies that you'll have difficulties with devices that should exist
>>>and be visible in one namespace only (like tunnels), as they require IP
>>>addresses and route.
>>
>>I mean instead of having the route tables private to the namespace, the 
>>routes have the information to which namespace they are associated.
> 
> 
> I think I understand what you're talking about: you want to make routing
> responsible for determining destination namespace ID in addition to route
> type (local, unicast etc), nexthop information, and so on.  Right?

Yes.

> 
> My point is that if you make namespace tagging at routing time, and
> your packets are being routed only once, you lose the ability
> to have separate routing tables in each namespace.

Right. What is the advantage of having separate the routing tables ?

