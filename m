Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751641AbWBMIvy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751641AbWBMIvy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 03:51:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751625AbWBMIvy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 03:51:54 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:25009 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1751242AbWBMIvx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 03:51:53 -0500
Message-ID: <43F04909.40202@sw.ru>
Date: Mon, 13 Feb 2006 11:53:29 +0300
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: linux-kernel@vger.kernel.org, vserver@list.linux-vserver.org,
       Herbert Poetzl <herbert@13thfloor.at>,
       "Serge E. Hallyn" <serue@us.ibm.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Hansen <haveblue@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Suleiman Souhlal <ssouhlal@FreeBSD.org>,
       Hubertus Franke <frankeh@watson.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>, Kyle Moffett <mrmacman_g4@mac.com>,
       Greg <gkurz@fr.ibm.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       Rik van Riel <riel@redhat.com>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       Andrey Savochkin <saw@sawoct.com>, Kirill Korotaev <dev@openvz.org>,
       Andi Kleen <ak@suse.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Jes Sorensen <jes@sgi.com>
Subject: Re: [RFC][PATCH 04/20] pspace: Allow multiple instaces of the process
 id namespace
References: <m11wygnvlp.fsf@ebiederm.dsl.xmission.com>	<m1vevsmgvz.fsf@ebiederm.dsl.xmission.com>	<m1lkwomgoj.fsf_-_@ebiederm.dsl.xmission.com>	<m1fymwmgk0.fsf_-_@ebiederm.dsl.xmission.com>	<m1bqxkmgcv.fsf_-_@ebiederm.dsl.xmission.com> <43ECF803.8080404@sw.ru> <m13biqxjj5.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m13biqxjj5.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>+static inline int pspace_task_visible(struct pspace *pspace, struct
>>
>>task_struct *tsk)
>>
>>>+{
>>>+	return (tsk->pspace == pspace) ||
>>>+		((tsk->pspace->child_reaper.pspace == pspace) &&
>>>+		 (tsk->pspace->child_reaper.task == tsk));
>>
>><<< the logic with child_reaper which can be somehow partly inside pspace... and
>>this check is not that abvious.
> 
> 
> This is the check for what shows up in /proc.
> 
> Given that is how I have explicitly documented things to work, (the
> init process straddles the boundary) I fail to see how it is not obvious.  
I was confused by the fact that child_reaper.pspace is actually a parent 
pspace.

Kirill

