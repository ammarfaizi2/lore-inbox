Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932323AbWBUQqa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932323AbWBUQqa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 11:46:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932750AbWBUQqa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 11:46:30 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:16902 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S932323AbWBUQq3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 11:46:29 -0500
Message-ID: <43FB3FDD.6030406@sw.ru>
Date: Tue, 21 Feb 2006 19:29:17 +0300
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: Herbert Poetzl <herbert@13thfloor.at>
CC: "Serge E. Hallyn" <serue@us.ibm.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       linux-kernel@vger.kernel.org, vserver@list.linux-vserver.org,
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
References: <m1fymwmgk0.fsf_-_@ebiederm.dsl.xmission.com> <m1bqxkmgcv.fsf_-_@ebiederm.dsl.xmission.com> <43ECF803.8080404@sw.ru> <m1psluw1jj.fsf@ebiederm.dsl.xmission.com> <43F04FD6.5090603@sw.ru> <m1wtfytri1.fsf@ebiederm.dsl.xmission.com> <43F31972.3030902@sw.ru> <20060215133131.GD28677@MAIL.13thfloor.at> <20060216134447.GA12039@sergelap.austin.ibm.com> <43F98B67.60800@sw.ru> <20060220170448.GG18841@MAIL.13thfloor.at>
In-Reply-To: <20060220170448.GG18841@MAIL.13thfloor.at>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>I would prefer:
>>- sys_ns_create()
>>  creates namespace and makes a task to inherit this namespace. 
>>  If _needed_, it _can_ fork inside.

> I don't see why not have both, the auto-created
> *space on clone() and the ability to create empty
> *spaces which can be populated and/or entered
Can you give more details on what you mean by auto-created *space and 
empty *space?
I see no much difference...

>>- sys_ns_inherit()
>>  change active namespace.
> hmm, sounds like a misnomer to me ...
sys_ns_change ? :)

>>But how should we reference namespace? by globabl ID?
> definitely by some system-unique identifier ...
Should it be integer or path as Eric proposes?

Thanks,
Kirill

