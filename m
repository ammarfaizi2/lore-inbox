Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964828AbWBGB70@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964828AbWBGB70 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 20:59:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932440AbWBGB70
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 20:59:26 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:58500 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932439AbWBGB7Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 20:59:25 -0500
To: Cedric Le Goater <clg@fr.ibm.com>
Cc: Dave Hansen <haveblue@us.ibm.com>, Kirill Korotaev <dev@sw.ru>,
       Linus Torvalds <torvalds@osdl.org>, Kirill Korotaev <dev@openvz.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       frankeh@watson.ibm.com, greg@kroah.com, alan@lxorguk.ukuu.org.uk,
       serue@us.ibm.com, arjan@infradead.org, Rik van Riel <riel@redhat.com>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       Andrey Savochkin <saw@sawoct.com>, devel@openvz.org,
       Pavel Emelianov <xemul@sw.ru>
Subject: Re: [RFC][PATCH 1/5] Virtualization/containers: startup
References: <43E38BD1.4070707@openvz.org>
	<Pine.LNX.4.64.0602030905380.4630@g5.osdl.org>
	<43E3915A.2080000@sw.ru>
	<Pine.LNX.4.64.0602030939250.4630@g5.osdl.org>
	<m1lkwoubiw.fsf@ebiederm.dsl.xmission.com> <43E71018.8010104@sw.ru>
	<m1hd7condi.fsf@ebiederm.dsl.xmission.com>
	<1139243874.6189.71.camel@localhost.localdomain>
	<m13biwnxkc.fsf@ebiederm.dsl.xmission.com>
	<43E7D077.2090903@fr.ibm.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Mon, 06 Feb 2006 18:57:05 -0700
In-Reply-To: <43E7D077.2090903@fr.ibm.com> (Cedric Le Goater's message of
 "Mon, 06 Feb 2006 23:40:55 +0100")
Message-ID: <m1wtg8gccu.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cedric Le Goater <clg@fr.ibm.com> writes:

> Eric W. Biederman wrote:
>
>> As someone said to me a little bit ago, for migration or checkpointing
>> ultimately you have to capture the entire user/kernel interface if
>> things are going to work properly.  Now if we add this facility to
>> the kernel and it is a general purpose facility.  It is only a matter
>> of time before we need to deal with nested containers.
>>
>> Not considering the case of having nested containers now is just foolish.
>> Maybe we don't have to implement it yet but not considering it is silly.
>
> That could be restricted. Today, process groups are not nested. Why do you
> think nested containers are inevitable ?

process groups are a completely different kind of beast.
A closer analogy are hierarchical name spaces and mounts.
If we didn't need things like waitpid outside one pid namespace
to wait for a nested namespace they would be complete disjoint
and the implementation would be trivial.


>> As far as I can tell there is a very reasonable chance that when we
>> are complete there is a very reasonable chance that software suspend
>> will just be a special case of migration, done complete in user space.
>
> Being able to sofware suspend one container among many would be a very
> interesting feature to have.

That is what checkpointing.  And that is simply the persistent form of
migration.

Eric

