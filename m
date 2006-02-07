Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964956AbWBGDgt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964956AbWBGDgt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 22:36:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964959AbWBGDgt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 22:36:49 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:2950 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S964956AbWBGDgs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 22:36:48 -0500
To: Kirill Korotaev <dev@openvz.org>
Cc: Linus Torvalds <torvalds@osdl.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, frankeh@watson.ibm.com, clg@fr.ibm.com,
       haveblue@us.ibm.com, greg@kroah.com, alan@lxorguk.ukuu.org.uk,
       serue@us.ibm.com, arjan@infradead.org, riel@redhat.com,
       kuznet@ms2.inr.ac.ru, saw@sawoct.com, devel@openvz.org,
       "Dmitry Mishin" <dim@sw.ru>, Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 1/4] Virtualization/containers: introduction
References: <43E7C65F.3050609@openvz.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Mon, 06 Feb 2006 20:34:33 -0700
In-Reply-To: <43E7C65F.3050609@openvz.org> (Kirill Korotaev's message of
 "Tue, 07 Feb 2006 00:57:51 +0300")
Message-ID: <m1bqxju9iu.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kirill Korotaev <dev@openvz.org> writes:

> Hello,
>
> I tried to take into account all the comments from you guys (thanks a lot for
> them!) and prepared a new version of virtualization patches. I will send only 4
> patches today, just not to overflow everyone and keep it clear/tidy/possible to
> review.
>
> This patch introduces some abstract container kernel structure and a number of
> operations on it.

>
> The important properties of the proposed container implementation:
> - each container has unique ID in the system
What namespace does this ID live in?

> - each process in the kernel can belong to one container only
Reasonable.

> - effective container pointer (econtainer()) is used on the task to avoid
> insertion of additional argument "container" to all functions where it is
> required.

Why is that desirable?

> - kernel compilation with disabled virtualization should result in old good
> linux kernel
A reasonable goal.

Why do we need a container structure to hold pointers to other pointers?

> Patches following this one will be used for virtualization of the kernel
> resources based on this container infrastructure, including those VPID patches I
> sent before. Every virtualized resource can be given separate config option if
> needed (just give me to know if it is desired).
>
> Signed-Off-By: Kirill Korotaev <dev@openvz.org>
>
> Kirill
>
> P.S. I understand that this virtualization spam can be unintersting for some of
> you, just give me to know if you want to be removed from CC.

May I please be added to the CC list.

We are never going to form a consensus if all of the people doing implementations don't
talk.

Eric
