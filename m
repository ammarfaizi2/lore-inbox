Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933244AbWFZXKJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933244AbWFZXKJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 19:10:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751211AbWFZXJx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 19:09:53 -0400
Received: from ns2.lanforge.com ([66.165.47.211]:48039 "EHLO ns2.lanforge.com")
	by vger.kernel.org with ESMTP id S933244AbWFZXJ3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 19:09:29 -0400
Message-ID: <44A068E7.6080403@candelatech.com>
Date: Mon, 26 Jun 2006 16:08:23 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.12) Gecko/20050922 Fedora/1.7.12-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Herbert Poetzl <herbert@13thfloor.at>
CC: "Eric W. Biederman" <ebiederm@xmission.com>,
       Daniel Lezcano <dlezcano@fr.ibm.com>, Andrey Savochkin <saw@swsoft.com>,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org, serue@us.ibm.com,
       haveblue@us.ibm.com, clg@fr.ibm.com, Andrew Morton <akpm@osdl.org>,
       dev@sw.ru, devel@openvz.org, sam@vilain.net, viro@ftp.linux.org.uk,
       Alexey Kuznetsov <alexey@sw.ru>
Subject: Re: [patch 2/6] [Network namespace] Network device sharing by view
References: <20060609210202.215291000@localhost.localdomain> <20060609210625.144158000@localhost.localdomain> <20060626134711.A28729@castle.nmd.msu.ru> <449FF5A0.2000403@fr.ibm.com> <20060626192751.A989@castle.nmd.msu.ru> <44A00215.2040608@fr.ibm.com> <m1hd27uaxw.fsf@ebiederm.dsl.xmission.com> <20060626183649.GB3368@MAIL.13thfloor.at> <m1u067r9qk.fsf@ebiederm.dsl.xmission.com> <44A05BFD.6030402@candelatech.com> <20060626225440.GA7425@MAIL.13thfloor.at>
In-Reply-To: <20060626225440.GA7425@MAIL.13thfloor.at>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Poetzl wrote:
> On Mon, Jun 26, 2006 at 03:13:17PM -0700, Ben Greear wrote:

> yes, that sounds good to me, any numbers how that
> affects networking in general (performance wise and
> memory wise, i.e. caches and hashes) ...

I'll run some tests later today.  Based on my previous tests,
I don't remember any significant overhead.

>>Using the mac-vlan and source-based routing tables, I can give a
>>unique 'interface' to each process and have each process able to bind
>>to the same IP port, for instance. Using source-based routing (by
>>binding to a local IP explicitly and adding a route table for that
>>source IP), I can give unique default routes to each interface as
>>well. Since we cannot have more than 256 routing tables, this approach
>>is currently limitted to around 250 virtual interfaces, but that is
>>still a substantial amount.
> 
> 
> an typically that would be sufficient IMHO, but
> of course, a more 'general' hash tag would be
> better in the long run ...

I'm willing to offer a bounty (hardware, beer, money, ...)
if someone will 'fix' this so we can have 1000 or more routes....

Being able to select these routes at a more global level (without
having to specifically bind to a local IP would be nice as well.)

Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

