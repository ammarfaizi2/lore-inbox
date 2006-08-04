Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161335AbWHDTLu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161335AbWHDTLu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 15:11:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161362AbWHDTLu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 15:11:50 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:61615 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1161335AbWHDTLt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 15:11:49 -0400
Message-ID: <44D39BEE.9080304@watson.ibm.com>
Date: Fri, 04 Aug 2006 15:11:42 -0400
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: rohitseth@google.com
CC: Kirill Korotaev <dev@sw.ru>, vatsa@in.ibm.com,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       mingo@elte.hu, nickpiggin@yahoo.com.au, sam@vilain.net,
       linux-kernel@vger.kernel.org, dev@openvz.org, efault@gmx.de,
       balbir@in.ibm.com, sekharan@us.ibm.com, haveblue@us.ibm.com, pj@sgi.com
Subject: Re: [RFC, PATCH 0/5] Going forward with Resource Management - A	cpu
 controller
References: <20060804050753.GD27194@in.ibm.com>	 <20060803223650.423f2e6a.akpm@osdl.org>	 <20060803224253.49068b98.akpm@osdl.org>	 <1154684950.23655.178.camel@localhost.localdomain>	 <20060804114109.GA28988@in.ibm.com> <44D35F0B.5000801@sw.ru>	 <20060804153123.GB32412@in.ibm.com>  <44D36FB5.3050002@sw.ru> <1154716024.7228.32.camel@galaxy.corp.google.com>
In-Reply-To: <1154716024.7228.32.camel@galaxy.corp.google.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rohit Seth wrote:

>>>The use cases I have heard of which would benefit such a feature is
>>>(say) for database threads which want to change their "resource
>>>affinity" status depending on which customer query they are currently handling. 
>>>If they are handling a query for a "important" customer, they will want affinied
>>>to a high bandwidth resource container and later if they start handling
>>>a less important query they will want to give up this affinity and
>>>instead move to a low-bandwidth container.
> 
> 
> hmm, would it not be better to have a thread each in two different
> containers for handling different kind of requests.  

Its possible but now you're effectively requiring the thread pool to
expand as many times as service levels supported.

any long running job whose prioritization changes during its lifetime
also benefits from being able to be moved.


> Or if there is too
> much of sharing between threads, then setting the individual priority
> should help.
> 
