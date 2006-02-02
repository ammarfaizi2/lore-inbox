Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751100AbWBBOsY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751100AbWBBOsY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 09:48:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751103AbWBBOsY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 09:48:24 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:19216 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1751100AbWBBOsX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 09:48:23 -0500
Message-ID: <43E21BF3.1080204@sw.ru>
Date: Thu, 02 Feb 2006 17:49:23 +0300
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, "Serge E. Hallyn" <serue@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       Hubertus Franke <frankeh@watson.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>
Subject: Re: RFC [patch 13/34] PID Virtualization Define new task_pid api
References: <20060117143258.150807000@sergelap>	 <20060117143326.283450000@sergelap>	 <1137511972.3005.33.camel@laptopd505.fenrus.org>	 <20060117155600.GF20632@sergelap.austin.ibm.com>	 <1137513818.14135.23.camel@localhost.localdomain> <1137518714.5526.8.camel@localhost.localdomain>
In-Reply-To: <1137518714.5526.8.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

>>>The virtual pid is different depending on who is asking.  So simply
>>>storing current->realpid and current->pid isn't helpful, as we would
>>>still need to call a function when a pid crosses user->kernel boundary.
>>
>>This is an obscure, weird piece of functionality for some special case
>>usages most of which are going to be eliminated by Xen. I don't see the
>>kernel side justification for it at all.
> 
> 
> At least OpenVZ and vserver want very similar functionality.  They're
> both working with out-of-tree patch sets.  We each want to do subtly
> different things with tsk->pid, and task_pid() seemed to be a decent
> place to start.  OpenVZ has a very similar concept in its pid_task()
> function.
But our VPID patch is much less intrusive and shorter (thanks to Alexey 
Kuznetsov).
I will send a broken-out patches today CC-ing you.

BTW, have you tested it somehow (LTP, etc.)?

> Arjan had a very good point last time we posted these: we should
> consider getting rid of as many places in the kernel where pids are used
> to uniquely identify tasks, and just stick with task_struct pointers.  

Kirill

