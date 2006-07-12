Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750787AbWGLHaj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750787AbWGLHaj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 03:30:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750792AbWGLHaj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 03:30:39 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:8709 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750787AbWGLHaj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 03:30:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=npgN9Jf/mASfbPArPLynCW2xJ5JlbkKM0SGNL8+lpa6Oyky2ZY50eZX7t7LW5TaYp3zh0xFnQ/TW14FHdHNgDMkiZfeobuCSsIidWMt1b4lHId5tfiujylkwx8DlfZFYCNWup/OuClXuddB5Hy+UjlzyNvHglYf1pILhEGICZ1g=
Date: Wed, 12 Jul 2006 11:37:18 +0400
From: Paul Drynoff <pauldrynoff@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] 2.6.18-rc1-mm1: as usual can not boot
Message-Id: <20060712113718.8e5e3af7.pauldrynoff@gmail.com>
In-Reply-To: <20060712001232.a31285e3.akpm@osdl.org>
References: <20060712095933.57d2a595.pauldrynoff@gmail.com>
	<20060712001232.a31285e3.akpm@osdl.org>
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.12; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jul 2006 00:12:32 -0700
Andrew Morton <akpm@osdl.org> wrote:

> On Wed, 12 Jul 2006 09:59:33 +0400
> Paul Drynoff <pauldrynoff@gmail.com> wrote:
> 
> > I try boot 2.6.18-rc1-mm1,
> > here is result:
> > 
> > show_stack_log_lve
> > show_registers
> > die
> > do_trap
> > do_invalid_op
> > error_code
> > buffered_rmqueue
> > get_page_from_freelist
> > __alloc_pages
> > get_zeroed_page
> > sysenter_setup
> > identify_cpu
> > check_bugs
> > start_kernel
> > 
> > EIP:... prep_new_page
> 
> Don't know, sorry.  Your config works ok here (well, gets a lot further).
> 
> It's dying quite late in boot there - the page allocator has already been
> used a bit, but then it falls over in a heap.
> 
> I notice you're set up for an i386.  Is the target CPU really an i386?  If
> not, and if you change this, does it affect anything?

My CPU is:
$ cat /proc/cpuinfo 
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 10
model name      : AMD Athlon(tm) XP 2600+
stepping        : 0
cpu MHz         : 1913.456
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow ts
bogomips        : 3833.86


First of all I booted with Athlon/Duron/K7 option,
and get this error.
After that I rebuild it as i386,
nothing changed.
I rebuild it with gcc-4.1.1 instead of gcc-3.3.6.
Nothing changed.

But the more interesting thing, that when I try this kernel with qemu (0.8.1),
I got the same error. Sorry, I can not sent it image, it is too big: 3 GB.

But I can sent screenshots or gdb output if somebody interesting.
