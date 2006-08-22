Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932105AbWHVHnB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932105AbWHVHnB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 03:43:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932108AbWHVHnB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 03:43:01 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:13363 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S932105AbWHVHnA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 03:43:00 -0400
Message-ID: <44EAB5B6.2020406@sw.ru>
Date: Tue, 22 Aug 2006 11:43:50 +0400
From: "Pavel V. Emelianov" <xemul@sw.ru>
User-Agent: Thunderbird 1.5 (X11/20060317)
MIME-Version: 1.0
To: rohitseth@google.com
CC: Kirill Korotaev <dev@sw.ru>, Rik van Riel <riel@redhat.com>,
       ckrm-tech@lists.sourceforge.net, Dave Hansen <haveblue@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Christoph Hellwig <hch@infradead.org>,
       Andrey Savochkin <saw@sw.ru>, devel@openvz.org, hugh@veritas.com,
       Ingo Molnar <mingo@elte.hu>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Pavel Emelianov <xemul@openvz.org>
Subject: Re: [ckrm-tech] [RFC][PATCH 5/7] UBC:	kernel	memory	accounting	(core)
References: <44E33893.6020700@sw.ru>  <44E33C8A.6030705@sw.ru>	 <1155754029.9274.21.camel@localhost.localdomain>	 <1155755729.22595.101.camel@galaxy.corp.google.com>	 <1155758369.9274.26.camel@localhost.localdomain>	 <1155774274.15195.3.camel@localhost.localdomain>	 <1155824788.9274.32.camel@localhost.localdomain>	 <1155835003.14617.45.camel@galaxy.corp.google.com>	 <1155835401.9274.64.camel@localhost.localdomain>	 <1155836198.14617.61.camel@galaxy.corp.google.com>	<44E58059.6020605@sw.ru>	 <1155922680.23242.7.camel@galaxy.corp.google.com>  <44E99904.80205@sw.ru> <1156211280.11127.41.camel@galaxy.corp.google.com>
In-Reply-To: <1156211280.11127.41.camel@galaxy.corp.google.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rohit Seth wrote:

[snip]
>>>> inodes can belong to multiple containers and so do the pages.
>>>>
>>>
>>> I'm still thinking that inodes should belong to one container (or may be
>>> have it configurable based on some flag).
>> this is not true for OpenVZ nor Linux-VServer.
>
>
> Well, it is still useful.  Just like an anonymous page get charged to
> container where the object (task) belong to, file page seems appropriate
> to belong to container where the object (inode) belongs to.
>
> -rohit
Making inodes belong to one container only significantly shrinks
container density. Sharing of glibc only saves up to 4Mb per container.
For the case of 100 containers it is 400Mb of booth - the disk space
and (what is more important) - RAM.

Pavel.

