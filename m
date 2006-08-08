Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932089AbWHHHTb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932089AbWHHHTb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 03:19:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932507AbWHHHTb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 03:19:31 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:57478 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S932089AbWHHHTa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 03:19:30 -0400
Message-ID: <44D83B0C.3080908@sw.ru>
Date: Tue, 08 Aug 2006 11:19:40 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: rohitseth@google.com
CC: "Martin J. Bligh" <mbligh@mbligh.org>, vatsa@in.ibm.com,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       mingo@elte.hu, nickpiggin@yahoo.com.au, sam@vilain.net,
       linux-kernel@vger.kernel.org, dev@openvz.org, efault@gmx.de,
       balbir@in.ibm.com, sekharan@us.ibm.com, nagar@watson.ibm.com,
       haveblue@us.ibm.com, pj@sgi.com, Andrey Savochkin <saw@sw.ru>
Subject: Re: [RFC, PATCH 0/5] Going forward with Resource Management - A	cpu
 controller
References: <20060804050753.GD27194@in.ibm.com>	 <20060803223650.423f2e6a.akpm@osdl.org>	 <20060803224253.49068b98.akpm@osdl.org>	 <1154684950.23655.178.camel@localhost.localdomain>	 <20060804114109.GA28988@in.ibm.com> <44D35F0B.5000801@sw.ru>	 <44D388DF.8010406@mbligh.org> <44D6EAFA.8080607@sw.ru>	 <44D74F77.7080000@mbligh.org>  <44D76B43.5080507@sw.ru> <1154975486.31962.40.camel@galaxy.corp.google.com>
In-Reply-To: <1154975486.31962.40.camel@galaxy.corp.google.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>you come across your limit and new allocations will fail.
>>BUT! IMPORTANT!
>>in real life use case with OpenVZ we allow sharing not that much data across containers:
>>vmas mapped as private, i.e. glibc and other libraries .data section
>>(and .code if it is writable). So if you use the same glibc and other executables
>>in the containers then your are charged only a fraction of phys memory used by it.
>>This kind of sharing is not that huge (<< memory limits usually),
>>so the situation you described is not a problem
>>in real life (at least for OpenVZ).
>>
> 
> 
> I think it is not a problem for OpenVZ because there is not that much of
> sharing going between containers as you mentioned (btw, this least
> amount of sharing is a very good thing).  Though I'm not sure if one has
> to go to the extent of doing fractions with memory accounting.  If the
> containers are set up in such a way that there is some sharing across
> containers then it is okay to be unfair and charge one of those
> containers for the specific resource completely.
In this case you can't plan your resources, can't say which one consumes
more memory and can't select the worst container to kill and many other drawbacks.

Kirill

