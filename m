Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964772AbWBFUZU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964772AbWBFUZU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 15:25:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964773AbWBFUZU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 15:25:20 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:16769 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S964772AbWBFUZT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 15:25:19 -0500
To: Dave Hansen <haveblue@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, vserver@list.linux-vserver.org,
       Herbert Poetzl <herbert@13thfloor.at>,
       "Serge E. Hallyn" <serue@us.ibm.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Arjan van de Ven <arjan@infradead.org>,
       Suleiman Souhlal <ssouhlal@FreeBSD.org>,
       Hubertus Franke <frankeh@watson.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>, Kyle Moffett <mrmacman_g4@mac.com>,
       Kirill Korotaev <dev@sw.ru>, Greg <gkurz@fr.ibm.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Greg KH <greg@kroah.com>, Rik van Riel <riel@redhat.com>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       Andrey Savochkin <saw@sawoct.com>, Kirill Korotaev <dev@openvz.org>,
       Andi Kleen <ak@suse.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Jes Sorensen <jes@sgi.com>
Subject: Re: [RFC][PATCH 03/20] pid: Introduce a generic helper to test for
 init.
References: <m11wygnvlp.fsf@ebiederm.dsl.xmission.com>
	<m1vevsmgvz.fsf@ebiederm.dsl.xmission.com>
	<m1lkwomgoj.fsf_-_@ebiederm.dsl.xmission.com>
	<m1fymwmgk0.fsf_-_@ebiederm.dsl.xmission.com>
	<1139255772.6189.106.camel@localhost.localdomain>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Mon, 06 Feb 2006 13:22:18 -0700
In-Reply-To: <1139255772.6189.106.camel@localhost.localdomain> (Dave
 Hansen's message of "Mon, 06 Feb 2006 11:56:11 -0800")
Message-ID: <m17j88jkzp.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen <haveblue@us.ibm.com> writes:

> On Mon, 2006-02-06 at 12:29 -0700, Eric W. Biederman wrote:
>> Introduce is_init to capture this case.  
>> 
>> With multiple pid spaces for all of the cases affected we are looking
>> for only the first process on the system, not some other process that
>> has pid == 1. 
>
> If we have cases where each container has its own init (like vserver,
> right?), will this naming get confusing?  Will we have pseudo-init tasks
> as well?

Agreed.  That is a potential issue.  I couldn't think of a better name.
Suggestions?

Eric
