Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263806AbUEMGIT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263806AbUEMGIT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 02:08:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263802AbUEMGIT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 02:08:19 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:21937 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S263806AbUEMGIN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 02:08:13 -0400
To: Christoph Hellwig <hch@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, rddunlap@osdl.org, davidm@hpl.hp.com,
       fastboot@lists.osdl.org, linux-kernel@vger.kernel.org,
       drepper@redhat.com
Subject: Re: [Fastboot] Re: [announce] kexec for linux 2.6.6
References: <m13c66qicb.fsf@ebiederm.dsl.xmission.com>
	<40A243C8.401@redhat.com> <m1brktod3f.fsf@ebiederm.dsl.xmission.com>
	<40A2517C.4040903@redhat.com>
	<m17jvhoa6g.fsf@ebiederm.dsl.xmission.com>
	<20040512143233.0ee0405a.rddunlap@osdl.org>
	<16546.41076.572371.307153@napali.hpl.hp.com>
	<20040512152815.76280eac.akpm@osdl.org>
	<16546.42537.765495.231960@napali.hpl.hp.com>
	<20040512161603.44c50cec.akpm@osdl.org>
	<20040513053051.A5286@infradead.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 13 May 2004 00:06:08 -0600
In-Reply-To: <20040513053051.A5286@infradead.org>
Message-ID: <m1lljwsvxr.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> writes:

> On Wed, May 12, 2004 at 04:16:03PM -0700, Andrew Morton wrote:
> > But if we need additional infrastructure to "add new syscalls via VDSO" then
> > this should be in the base kernel, even if it's empty, yes?
> 
> Linus has vetoed dynamic syscall registration a few times.  And I agree
> with him, dynamic syscalls are the best way to get completely crappy
> interfaces.

The only thing I was thinking of doing was to export the symbol
__kernel__NR_kexec_load.  With a little care we could probably export
the system call numbers just as easily from /proc/kallsyms.

At this point that idea seems to add no real benefit.  Except for
allowing for a user space that can more easily track syscall renumber in
the kernel, which seems to be the wrong problem to solve.

So if kexec could actually get a reserved system call number that
would be the best solution I have seen in this thread.

Andrew how close are we to a point where we can look at kexec inclusion?

Eric
