Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751769AbWBEPj6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751769AbWBEPj6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 10:39:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751770AbWBEPj6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 10:39:58 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:45282 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751769AbWBEPj5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 10:39:57 -0500
Message-ID: <43E61C47.8070905@watson.ibm.com>
Date: Sun, 05 Feb 2006 10:39:51 -0500
From: Hubertus Franke <frankeh@watson.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kirill Korotaev <dev@sw.ru>
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
References: <43E38BD1.4070707@openvz.org> <Pine.LNX.4.64.0602030905380.4630@g5.osdl.org> <43E3915A.2080000@sw.ru> <Pine.LNX.4.64.0602030939250.4630@g5.osdl.org> <1138991641.6189.37.camel@localhost.localdomain> <20060203201945.GA18224@kroah.com> <43E3BE66.6050200@watson.ibm.com> <43E615BA.1080402@sw.ru>
In-Reply-To: <43E615BA.1080402@sw.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kirill Korotaev wrote:
>> How do we want to create the container?
>> In our patch we did it through a /proc/container filesystem.
>> Which created the container object and then on fork/exec switched over.
> 
> this doesn't look good for a full virtualization solution, since proc 
> should be virtualized as well :)

Just lazy's man's development version of a faked sys_call to create the container
without having to go through all architectures ...
Nothing permanent..


> 
>> How about an additional sys_exec_container( exec_args + 
>> "container_name").
>> This does all the work like exec, but creates new container
>> with name "..." and attaches task to new container.
>> If name exists, an error -EEXIST will be raised !
> 
> Why do you need exec?

(a) how do you create/destroy a container
(b) how do you attach yourself to it?

-- Hubertus

