Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751447AbWGLV5T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751447AbWGLV5T (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 17:57:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751457AbWGLV5T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 17:57:19 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:38349 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751447AbWGLV5T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 17:57:19 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Arjan van de Ven <arjan@infradead.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Jakub Jelinek <jakub@redhat.com>,
       Ulrich Drepper <drepper@redhat.com>, Roland McGrath <roland@redhat.com>,
       "Randy.Dunlap" <rdunlap@xenotime.net>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, libc-alpha@sourceware.org
Subject: Re: [PATCH] Use uname not sysctl to get the kernel revision
References: <20060712184412.2BD57180061@magilla.sf.frob.com>
	<44B54EA4.5060506@redhat.com>
	<20060712195349.GW3823@sunsite.mff.cuni.cz>
	<44B556E5.5000702@zytor.com>
	<m1k66i8ql5.fsf@ebiederm.dsl.xmission.com>
	<1152739766.3217.83.camel@laptopd505.fenrus.org>
Date: Wed, 12 Jul 2006 15:56:13 -0600
In-Reply-To: <1152739766.3217.83.camel@laptopd505.fenrus.org> (Arjan van de
	Ven's message of "Wed, 12 Jul 2006 23:29:26 +0200")
Message-ID: <m1bqru8p36.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjan@infradead.org> writes:

> On Wed, 2006-07-12 at 15:23 -0600, Eric W. Biederman wrote:
>> "H. Peter Anvin" <hpa@zytor.com> writes:
>> 
>> > Jakub Jelinek wrote:
>> >> On Wed, Jul 12, 2006 at 12:33:56PM -0700, Ulrich Drepper wrote:
>> >>> Roland McGrath wrote:
>> >>>> We could also put the uname info (modulo nodename) into the vDSO.
>> >>> Or even better: real topology information.
>> >> AND rather than OR would be even better.  So glibc could find kernel
>> >> version, etc. and topology in the vDSO cheaply.
>> >
>> > Wouldn't it make more sense for this to be in ELF tags, rather than the
> vdso?
>> > Another alternative, I guess, would be to put a pointer in the ELF tags,
> which
>> > may point into the vdso.
>> 
>> Cheap and simple access to topology information would be interesting.
>> 
>> Glibc just wants to know if our kernel is SMP so it can know if it is
>> ok to busy wait for a bit waiting for a mutex.  Or if busy waiting is
>> a complete loss.
>
>
> with current power management... busy waiting pretty much is a loss even
> on UP

It is a short busy wait before falling asleep.  I assume you mean
busy wait is a loss even on SMP?

Eric

