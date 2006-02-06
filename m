Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750814AbWBFJHH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750814AbWBFJHH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 04:07:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750811AbWBFJHH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 04:07:07 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:41331 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1750814AbWBFJHE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 04:07:04 -0500
Message-ID: <43E71219.90801@sw.ru>
Date: Mon, 06 Feb 2006 12:08:41 +0300
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: Hubertus Franke <frankeh@watson.ibm.com>
CC: Greg KH <greg@kroah.com>, Dave Hansen <haveblue@us.ibm.com>,
       Linus Torvalds <torvalds@osdl.org>, Kirill Korotaev <dev@openvz.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       clg@fr.ibm.com, alan@lxorguk.ukuu.org.uk, serue@us.ibm.com,
       arjan@infradead.org, Rik van Riel <riel@redhat.com>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       Andrey Savochkin <saw@sawoct.com>, devel@openvz.org,
       Pavel Emelianov <xemul@sw.ru>
Subject: Re: [RFC][PATCH 1/5] Virtualization/containers: startup
References: <43E38BD1.4070707@openvz.org> <Pine.LNX.4.64.0602030905380.4630@g5.osdl.org> <43E3915A.2080000@sw.ru> <Pine.LNX.4.64.0602030939250.4630@g5.osdl.org> <1138991641.6189.37.camel@localhost.localdomain> <20060203201945.GA18224@kroah.com> <43E3BE66.6050200@watson.ibm.com> <43E615BA.1080402@sw.ru> <43E61C47.8070905@watson.ibm.com>
In-Reply-To: <43E61C47.8070905@watson.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Just lazy's man's development version of a faked sys_call to create the 
> container
> without having to go through all architectures ...
> Nothing permanent..

>>> How about an additional sys_exec_container( exec_args + 
>>> "container_name").
>>> This does all the work like exec, but creates new container
>>> with name "..." and attaches task to new container.
>>> If name exists, an error -EEXIST will be raised !
>>
>>
>> Why do you need exec?
> 
> 
> (a) how do you create/destroy a container
> (b) how do you attach yourself to it?
a)
   create via syscall.
   destroyed when the last process dies in container.
b)
   syscall which changes container. you need to close unneeded 
resources, change context and fork(). That's it.
   The whole process is exactly the same as if you changes UID.

