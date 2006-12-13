Return-Path: <linux-kernel-owner+w=401wt.eu-S1750969AbWLMUQp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750969AbWLMUQp (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 15:16:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750856AbWLMUQp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 15:16:45 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:59805 "EHLO
	ebiederm.dsl.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750714AbWLMUQn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 15:16:43 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: [patch] Add allowed_affinity to the irq_desc to make it possible to have restricted irqs
References: <1166018020.27217.805.camel@laptopd505.fenrus.org>
	<m1lklbport.fsf@ebiederm.dsl.xmission.com>
	<1166040131.27217.888.camel@laptopd505.fenrus.org>
Date: Wed, 13 Dec 2006 13:16:28 -0700
In-Reply-To: <1166040131.27217.888.camel@laptopd505.fenrus.org> (Arjan van de
	Ven's message of "Wed, 13 Dec 2006 21:02:11 +0100")
Message-ID: <m1ac1rpn4z.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjan@linux.intel.com> writes:

>> .
>> 
>> In addition the cases I can think of allowed_affinity is the wrong
>> name.  suggested_affinity sounds like what you are trying to implement
>> and when it is merely a suggestion and not a hard limit it doesn't
>> make sense to export like this.
>
> it really IS a hard limit. 

Ok.  Which generally makes it uninteresting.  The only cases that I know
with a hard limit are completely unrouteable.

In addition upon reflection you don't handle PER_CPU irqs properly.  As
I recall ia64 uses a different per cpu irq source to target each
individual processor.  But because they are the same the share the
irq source.

I don't think allowed_affinity can even describe the case above.

Eric


