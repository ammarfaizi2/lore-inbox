Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932326AbWHGTq7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932326AbWHGTq7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 15:46:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932327AbWHGTq7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 15:46:59 -0400
Received: from dvhart.com ([64.146.134.43]:49603 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S932326AbWHGTq6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 15:46:58 -0400
Message-ID: <44D798B1.8010604@mbligh.org>
Date: Mon, 07 Aug 2006 12:46:57 -0700
From: Martin Bligh <mbligh@mbligh.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: rohitseth@google.com
Cc: Dave Hansen <haveblue@us.ibm.com>, Kirill Korotaev <dev@sw.ru>,
       vatsa@in.ibm.com, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Andrew Morton <akpm@osdl.org>, mingo@elte.hu, nickpiggin@yahoo.com.au,
       sam@vilain.net, linux-kernel@vger.kernel.org, dev@openvz.org,
       efault@gmx.de, balbir@in.ibm.com, sekharan@us.ibm.com,
       nagar@watson.ibm.com, pj@sgi.com, Andrey Savochkin <saw@sw.ru>
Subject: Re: [RFC, PATCH 0/5] Going forward with Resource Management - A	cpu
 controller
References: <20060804050753.GD27194@in.ibm.com>	 <20060803223650.423f2e6a.akpm@osdl.org>	 <20060803224253.49068b98.akpm@osdl.org>	 <1154684950.23655.178.camel@localhost.localdomain>	 <20060804114109.GA28988@in.ibm.com> <44D35F0B.5000801@sw.ru>	 <44D388DF.8010406@mbligh.org> <44D6EAFA.8080607@sw.ru>	 <44D74F77.7080000@mbligh.org>  <44D76B43.5080507@sw.ru>	 <1154975486.31962.40.camel@galaxy.corp.google.com>	 <1154976236.19249.9.camel@localhost.localdomain> <1154977257.31962.57.camel@galaxy.corp.google.com>
In-Reply-To: <1154977257.31962.57.camel@galaxy.corp.google.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rohit Seth wrote:
> On Mon, 2006-08-07 at 11:43 -0700, Dave Hansen wrote:
> 
>>On Mon, 2006-08-07 at 11:31 -0700, Rohit Seth wrote:
>>
>>>I think it is not a problem for OpenVZ because there is not that much
>>>of
>>>sharing going between containers as you mentioned (btw, this least
>>>amount of sharing is a very good thing).  Though I'm not sure if one
>>>has
>>>to go to the extent of doing fractions with memory accounting.  If the
>>>containers are set up in such a way that there is some sharing across
>>>containers then it is okay to be unfair and charge one of those
>>>containers for the specific resource completely. 
>>
>>Right, and if you do reclaim against containers which are over their
>>limits, the containers being unfairly charged will tend to get hit
>>first.  But, once this happens, I would hope that the ownership of those
>>shared pages should settle out among all of the users.
>>
> 
> 
> I think there is lot of simplicity and value add by charging one
> container (even unfairly) for one resource completely.  This puts the
> onus on system admin to set up the containers appropriately.

It also saves you from maintaining huge lists against each page.

Worse case, you want to bill everyone who opens that address_space
equally. But the semantics on exit still suck.

What was Alan's quote again? "unfair, unreliable, inefficient ...
pick at least one out of the three". or something like that.

M.
