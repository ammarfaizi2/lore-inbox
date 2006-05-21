Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964939AbWEUXKZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964939AbWEUXKZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 19:10:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751558AbWEUXKZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 19:10:25 -0400
Received: from smtp.osdl.org ([65.172.181.4]:57521 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751556AbWEUXKZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 19:10:25 -0400
Date: Sun, 21 May 2006 16:09:44 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andi Kleen <ak@suse.de>
Cc: davej@redhat.com, drepper@gmail.com, cw@f00f.org, dragoran@feuerpokemon.de,
       linux-kernel@vger.kernel.org
Subject: Re: IA32 syscall 311 not implemented on x86_64
Message-Id: <20060521160944.7172977a.akpm@osdl.org>
In-Reply-To: <200605220019.08902.ak@suse.de>
References: <44702650.30507@feuerpokemon.de>
	<20060521185000.GB8250@redhat.com>
	<20060521185610.GC8250@redhat.com>
	<200605220019.08902.ak@suse.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> wrote:
>
> On Sunday 21 May 2006 20:56, Dave Jones wrote:
> > On Sun, May 21, 2006 at 02:50:00PM -0400, Dave Jones wrote:
> >  > On Sun, May 21, 2006 at 11:35:12AM -0700, Ulrich Drepper wrote:
> >  >  > On 5/21/06, Dave Jones <davej@redhat.com> wrote:
> >  >  > >It's a glibc problem really.
> >  >  > 
> >  >  > It's not a glibc problem really.  The problem is this stupid error
> >  >  > message in the kernel.  We rely in many dozens of places on the kernel
> >  >  > returning ENOSYS in case a syscall is not implemented and we deal with
> >  >  > it appropriately.  There is absolutely no justification to print these
> >  >  > messages except perhaps in debug kernels.  IMO the sys32_ni_syscall
> >  >  > functions should just return ENOSYS unless you select a special debug
> >  >  > kernel.  One doesn't need the kernel to detect missing syscall
> >  >  > implementations, strace can do this as well.
> >  > 
> >  > You make a good point.  In fact, given it's unthrottled, someone
> >  > with too much time on their hands could easily fill up a /var
> >  > just by calling unimplemented syscalls this way.
> 
> I never bought this argument because there are tons of printks in the kernel
> that can be triggered by everybody.
>  

Any time anyone identifies such a printk it gets instantly nuked.  So if
you know of more, please tell.

