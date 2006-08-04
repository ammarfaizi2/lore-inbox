Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161349AbWHDRuZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161349AbWHDRuZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 13:50:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161350AbWHDRuZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 13:50:25 -0400
Received: from dvhart.com ([64.146.134.43]:33473 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S1161349AbWHDRuZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 13:50:25 -0400
Message-ID: <44D388DF.8010406@mbligh.org>
Date: Fri, 04 Aug 2006 10:50:23 -0700
From: Martin Bligh <mbligh@mbligh.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kirill Korotaev <dev@sw.ru>
Cc: vatsa@in.ibm.com, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Andrew Morton <akpm@osdl.org>, mingo@elte.hu, nickpiggin@yahoo.com.au,
       sam@vilain.net, linux-kernel@vger.kernel.org, dev@openvz.org,
       efault@gmx.de, balbir@in.ibm.com, sekharan@us.ibm.com,
       nagar@watson.ibm.com, haveblue@us.ibm.com, pj@sgi.com
Subject: Re: [RFC, PATCH 0/5] Going forward with Resource Management - A cpu
 controller
References: <20060804050753.GD27194@in.ibm.com> <20060803223650.423f2e6a.akpm@osdl.org> <20060803224253.49068b98.akpm@osdl.org> <1154684950.23655.178.camel@localhost.localdomain> <20060804114109.GA28988@in.ibm.com> <44D35F0B.5000801@sw.ru>
In-Reply-To: <44D35F0B.5000801@sw.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> OpenVZ assumes that tasks can't move between task-groups for a single 
> reason:
> user shouldn't be able to escape from the container.
> But this have no implication on the design/implementation.

It does, for the memory controller at least. Things like shared
anon_vma's between tasks across containers make it somewhat harder.
It's much worse if you allow threads to split across containers.

> BTW, do you see any practical use cases for tasks jumping between 
> resource-containers?
