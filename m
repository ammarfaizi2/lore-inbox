Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263646AbUAZPQO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 10:16:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263679AbUAZPQO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 10:16:14 -0500
Received: from opersys.com ([64.40.108.71]:24325 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S263646AbUAZPQM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 10:16:12 -0500
Message-ID: <4015303F.1030003@opersys.com>
Date: Mon, 26 Jan 2004 10:20:31 -0500
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: Rik van Riel <riel@redhat.com>
CC: Nuno Silva <nuno.silva@vgertech.com>, JustFillBug <mozbugbox@yahoo.com.au>,
       linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Cooperative Linux
References: <Pine.LNX.4.44.0401260633280.26321-100000@chimarrao.boston.redhat.com>
In-Reply-To: <Pine.LNX.4.44.0401260633280.26321-100000@chimarrao.boston.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Rik van Riel wrote:
>>So, for example, Xen assumes that all OSes are going to use the same
>>devices for I/O: same disk, same NIC, etc. It therefore implements lots
>>of virtual devices for these.
> 
> 
> Consolidation means more efficient hardware use ...

In the case of a UP system, it may ... depending on what you're
trying to do. On an SMP system or an SMP-cluster, however,
consilidation is likely to mean loss of performance.

>>Wouldn't it be just better to reuse the existing work on the hotplug
>>hardware (hotplug CPU, hotplug memory, etc.) to have the kernels
>>get/return hardware resources to the nanokernel?
> 
> 
> That means a loss of flexibility.

It depends on your setup. In the case of an SMP-cluster where all
OS instances are launched at startup, where runtime setup
modification can be costly because of global table changes, and
where centralization is to be avoided in as much as possible, then
the hotplug capabilities are probably the best way to go. If there's
a desire to have both capabilities (fine-grain allocation and
gross-grain allocation) in whatever is finally adopted, then that's
something to keep in mind. I guess I'm just saying that there are pros
and cons, depending on your setup.

>  Furthermore, these hotplug
> patches don't seem ready yet.

Yes, I'm aware of this. There are other components of a truely
generic virtualization interface which are missing. Does that mean
we shouldn't think ahead?

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546

