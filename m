Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263171AbUELXPl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263171AbUELXPl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 19:15:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263089AbUELXPl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 19:15:41 -0400
Received: from fw.osdl.org ([65.172.181.6]:50102 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263171AbUELXOG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 19:14:06 -0400
Date: Wed, 12 May 2004 16:16:03 -0700
From: Andrew Morton <akpm@osdl.org>
To: davidm@hpl.hp.com
Cc: rddunlap@osdl.org, ebiederm@xmission.com, drepper@redhat.com,
       fastboot@lists.osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] Re: [announce] kexec for linux 2.6.6
Message-Id: <20040512161603.44c50cec.akpm@osdl.org>
In-Reply-To: <16546.42537.765495.231960@napali.hpl.hp.com>
References: <20040511212625.28ac33ef.rddunlap@osdl.org>
	<40A1AF53.3010407@redhat.com>
	<m13c66qicb.fsf@ebiederm.dsl.xmission.com>
	<40A243C8.401@redhat.com>
	<m1brktod3f.fsf@ebiederm.dsl.xmission.com>
	<40A2517C.4040903@redhat.com>
	<m17jvhoa6g.fsf@ebiederm.dsl.xmission.com>
	<20040512143233.0ee0405a.rddunlap@osdl.org>
	<16546.41076.572371.307153@napali.hpl.hp.com>
	<20040512152815.76280eac.akpm@osdl.org>
	<16546.42537.765495.231960@napali.hpl.hp.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Mosberger <davidm@napali.hpl.hp.com> wrote:
>
> >>>>> On Wed, 12 May 2004 15:28:15 -0700, Andrew Morton <akpm@osdl.org> said:
> 
>   >> ia64 does have VDSO (and has had it for some time).
> 
>   >> I quite like Uli's idea.
> 
>   Andrew> Is anyone doing VDSO development for x86?  I don't recall
>   Andrew> seeing anything.
> 
> It's already there?

But it needs work for the kexec requirement.  If that work is purely the
addition of the kexec entry point then OK, that can be part of the kexec
patch.

But if we need additional infrastructure to "add new syscalls via VDSO" then
this should be in the base kernel, even if it's empty, yes?
