Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751125AbWHGHYs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751125AbWHGHYs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 03:24:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751127AbWHGHYs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 03:24:48 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:46715 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1751125AbWHGHYr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 03:24:47 -0400
Message-ID: <44D6EAFA.8080607@sw.ru>
Date: Mon, 07 Aug 2006 11:25:46 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: Martin Bligh <mbligh@mbligh.org>
CC: vatsa@in.ibm.com, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Andrew Morton <akpm@osdl.org>, mingo@elte.hu, nickpiggin@yahoo.com.au,
       sam@vilain.net, linux-kernel@vger.kernel.org, dev@openvz.org,
       efault@gmx.de, balbir@in.ibm.com, sekharan@us.ibm.com,
       nagar@watson.ibm.com, haveblue@us.ibm.com, pj@sgi.com
Subject: Re: [RFC, PATCH 0/5] Going forward with Resource Management - A cpu
 controller
References: <20060804050753.GD27194@in.ibm.com> <20060803223650.423f2e6a.akpm@osdl.org> <20060803224253.49068b98.akpm@osdl.org> <1154684950.23655.178.camel@localhost.localdomain> <20060804114109.GA28988@in.ibm.com> <44D35F0B.5000801@sw.ru> <44D388DF.8010406@mbligh.org>
In-Reply-To: <44D388DF.8010406@mbligh.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> OpenVZ assumes that tasks can't move between task-groups for a single 
>> reason:
>> user shouldn't be able to escape from the container.
>> But this have no implication on the design/implementation.
> 
> 
> It does, for the memory controller at least. Things like shared
> anon_vma's between tasks across containers make it somewhat harder.
> It's much worse if you allow threads to split across containers.
we already have the code to account page fractions shared between containers.
Though, it is quite useless to do so for threads... Since this numbers have no meaning (not a real usage)
and only the sum of it will be a correct value.

>> BTW, do you see any practical use cases for tasks jumping between 
>> resource-containers?
> 
> 

