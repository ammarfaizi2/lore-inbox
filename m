Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265027AbUELGXh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265027AbUELGXh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 02:23:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264994AbUELGW6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 02:22:58 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:39068 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S264995AbUELGTd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 02:19:33 -0400
To: Ulrich Drepper <drepper@redhat.com>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, fastboot@lists.osdl.org,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [Fastboot] Re: [announce] kexec for linux 2.6.6
References: <20040511212625.28ac33ef.rddunlap@osdl.org>
	<40A1AF53.3010407@redhat.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 12 May 2004 00:18:12 -0600
In-Reply-To: <40A1AF53.3010407@redhat.com>
Message-ID: <m13c66qicb.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Drepper <drepper@redhat.com> writes:

> Randy.Dunlap wrote:
> 
> > And if anyone has suggestions for handling a variable/moving
> > syscall number (target), I'm interested in hearing them.
> 
> If all architectures would finally get a vdso implementation you could
> just add the necessary stub in the vdso, add a symbol in the symbol
> table of the vdso, and use in the userlevel code
> 
>   sym = dlsym (RTLD_DEFAULT, "the_symbol_name")
> 
> If the returned value is not NULL the symbol exists.
> 
> I've described this many times as one of the huge advantages of vdsos,
> hopefully this time it clicks.

For the momen the only finished port is x86, so we should be able
to do that, it would make the kernel patch a little bigger though.
Last time I saw that conversation I thought you didn't like symbols in
the vdso for syscalls because it slowed things down.

If no one is opposed that sounds like a fairly sane idea.

Eric
