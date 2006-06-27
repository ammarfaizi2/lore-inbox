Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964871AbWF0JzX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964871AbWF0JzX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 05:55:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964868AbWF0JzW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 05:55:22 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:1581 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S964858AbWF0JzV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 05:55:21 -0400
Message-ID: <44A1006B.3040700@sw.ru>
Date: Tue, 27 Jun 2006 13:54:51 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: Daniel Lezcano <dlezcano@fr.ibm.com>
CC: Andrey Savochkin <saw@swsoft.com>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, serue@us.ibm.com, haveblue@us.ibm.com,
       clg@fr.ibm.com, Andrew Morton <akpm@osdl.org>, herbert@13thfloor.at,
       devel@openvz.org, sam@vilain.net, ebiederm@xmission.com,
       viro@ftp.linux.org.uk, Alexey Kuznetsov <alexey@sw.ru>
Subject: Re: [patch 2/6] [Network namespace] Network device sharing by view
References: <20060609210202.215291000@localhost.localdomain> <20060609210625.144158000@localhost.localdomain> <20060626134711.A28729@castle.nmd.msu.ru> <449FF5A0.2000403@fr.ibm.com> <20060626192751.A989@castle.nmd.msu.ru> <44A00215.2040608@fr.ibm.com> <20060627131136.B13959@castle.nmd.msu.ru> <44A0FBAC.7020107@fr.ibm.com>
In-Reply-To: <44A0FBAC.7020107@fr.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> My point is that if you make namespace tagging at routing time, and
>> your packets are being routed only once, you lose the ability
>> to have separate routing tables in each namespace.
> 
> 
> Right. What is the advantage of having separate the routing tables ?
it is impossible to have bridged networking, tun/tap and many other 
features without it. I even doubt that it is possible to introduce 
private netfilter rules w/o virtualization of routing.

The question is do we want to have fully featured namespaces which allow 
to create isolated virtual environments with semantics and behaviour of 
standalone linux box or do we want to introduce some hacks with new 
rules/restrictions to meet ones goals only?

 From my POV, fully virtualized namespaces are the future. It is what 
makes virtualization solution usable (w/o apps modifications), provides 
all the features and doesn't require much efforts from people to be used.

Thanks,
Kirill
