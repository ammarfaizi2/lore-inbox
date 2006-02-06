Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932280AbWBFSja@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932280AbWBFSja (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 13:39:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932281AbWBFSja
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 13:39:30 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:14828 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932280AbWBFSj3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 13:39:29 -0500
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Kirill Korotaev <dev@sw.ru>, Linus Torvalds <torvalds@osdl.org>,
       Kirill Korotaev <dev@openvz.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       frankeh@watson.ibm.com, clg@fr.ibm.com, greg@kroah.com,
       alan@lxorguk.ukuu.org.uk, serue@us.ibm.com, arjan@infradead.org,
       Rik van Riel <riel@redhat.com>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
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
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Mon, 06 Feb 2006 11:37:07 -0700
In-Reply-To: <1139243874.6189.71.camel@localhost.localdomain> (Dave Hansen's
 message of "Mon, 06 Feb 2006 08:37:54 -0800")
Message-ID: <m13biwnxkc.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen <haveblue@us.ibm.com> writes:

> On Mon, 2006-02-06 at 02:19 -0700, Eric W. Biederman wrote:
>> That you placed the namespaces in a separate structure from
>> task_struct.
>> That part seems completely unnecessary, that and the addition of a
>> global id in a completely new namespace that will be a pain to
>> virtualize
>> when it's time comes. 
>
> Could you explain a bit why the container ID would need to be
> virtualized?

As someone said to me a little bit ago, for migration or checkpointing
ultimately you have to capture the entire user/kernel interface if
things are going to work properly.  Now if we add this facility to
the kernel and it is a general purpose facility.  It is only a matter
of time before we need to deal with nested containers.

Not considering the case of having nested containers now is just foolish.
Maybe we don't have to implement it yet but not considering it is silly.

As far as I can tell there is a very reasonable chance that when we
are complete there is a very reasonable chance that software suspend
will just be a special case of migration, done complete in user space.
That is one of the more practical examples I can think of where this
kind of functionality would be used.

Eric

