Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269643AbRHAEvG>; Wed, 1 Aug 2001 00:51:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269642AbRHAEur>; Wed, 1 Aug 2001 00:50:47 -0400
Received: from mpdr0.chicago.il.ameritech.net ([206.141.239.142]:49118 "EHLO
	mailhost.chi.ameritech.net") by vger.kernel.org with ESMTP
	id <S269640AbRHAEue>; Wed, 1 Aug 2001 00:50:34 -0400
Message-ID: <3B678655.BADEDCD7@ameritech.net>
Date: Tue, 31 Jul 2001 23:32:21 -0500
From: paulr <reichp@ameritech.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Pete Zaitcev <zaitcev@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: REPOST by request: String literal patch  (was Re: 2.4.7 -- GCC-3.0 -- 
 "multiline string literals deprecated" -- PATCH)
In-Reply-To: <mailman.996555420.7957.linux-kernel2news@redhat.com> <200107310605.f6V65NZ26153@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

> Folks,
>
> While building both kernels 2.4.6 and 2.4.7,
> I encountered a series of compiler warnings,
>
> warning: multiline string literals are deprecated.
>
> The build environment was gcc3.0 and binutils-2.11.2.
> 
---------------------<etc>----------------

> Pete Zaitcev wrote:
> > 
> > > Content-Type: application/octet-stream;
> > >  name="checksum.h.patch"
> > > Content-Transfer-Encoding: base64
> > > Content-Disposition: attachment;
> > >  filename="checksum.h.patch"
> > >
> > > LS0tIGxpbnV4L2luY2x1ZGUvYXNtLWkzODYvY2hlY2tzdW0uaC5vcmlnCVNhdCBKdWwgMjgg
> > > MTM6NDM6MTYgMjAwMQorKysgbGludXgvaW5jbHVkZS9hc20taTM4Ni9jaGVja3N1bS5oCVNh
> >
> > How am I supposed to review this?
> > Besides, why did you sent THREE patches
> > instead of one?
> 
> -- Pete

Reposted in plain english... was Netscape
attachment.  Many many lines...

--------- cut here ----------- cut here ---------- cut here -----

--- linux/include/asm-i386/floppy.h.orig	Sat Jul 28 14:20:26 2001
+++ linux/include/asm-i386/floppy.h	Sat Jul 28 14:34:18 2001
@@ -75,28 +75,28 @@
 
 #ifndef NO_FLOPPY_ASSEMBLER
 	__asm__ (
-       "testl %1,%1
-	je 3f
-1:	inb %w4,%b0
-	andb $160,%b0
-	cmpb $160,%b0
-	jne 2f
-	incw %w4
-	testl %3,%3
-	jne 4f
-	inb %w4,%b0
-	movb %0,(%2)
-	jmp 5f
-4:     	movb (%2),%0
-	outb %b0,%w4
-5:	decw %w4
-	outb %0,$0x80
-	decl %1
-	incl %2
-	testl %1,%1
-	jne 1b
-3:	inb %w4,%b0
-2:	"
+"       testl %1,%1\n"
+"	je 3f\n"
+"1:	inb %w4,%b0\n"
+"	andb $160,%b0\n"
+"	cmpb $160,%b0\n"
+"	jne 2f\n"
+"	incw %w4\n"
+"	testl %3,%3\n"
+"	jne 4f\n"
+"	inb %w4,%b0\n"
+"	movb %0,(%2)\n"
+"	jmp 5f\n"
+"4:     movb (%2),%0\n"
+"	outb %b0,%w4\n"
+"5:	decw %w4\n"
+"	outb %0,$0x80\n"
+"	decl %1\n"
+"	incl %2\n"
+"	testl %1,%1\n"
+"	jne 1b\n"
+"3:	inb %w4,%b0\n"
+"2:"
        : "=a" ((char) st), 
        "=c" ((long) virtual_dma_count), 
        "=S" ((long) virtual_dma_addr)
--- linux/arch/i386/kernel/semaphore.c.orig	Sat Jul 28 13:57:29 2001
+++ linux/arch/i386/kernel/semaphore.c	Sat Jul 28 14:50:50 2001
@@ -181,56 +181,56 @@
 ".text\n"
 ".align 4\n"
 ".globl __down_failed\n"
-"__down_failed:\n\t"
-	"pushl %eax\n\t"
-	"pushl %edx\n\t"
-	"pushl %ecx\n\t"
-	"call __down\n\t"
-	"popl %ecx\n\t"
-	"popl %edx\n\t"
-	"popl %eax\n\t"
-	"ret"
+"__down_failed:\n"
+"	pushl %eax\n"
+"	pushl %edx\n"
+"	pushl %ecx\n"
+"	call __down\n"
+"	popl  %ecx\n"
+"	popl  %edx\n"
+"	popl  %eax\n"
+"	ret\n"
 );
 
 asm(
 ".text\n"
 ".align 4\n"
 ".globl __down_failed_interruptible\n"
-"__down_failed_interruptible:\n\t"
-	"pushl %edx\n\t"
-	"pushl %ecx\n\t"
-	"call __down_interruptible\n\t"
-	"popl %ecx\n\t"
-	"popl %edx\n\t"
-	"ret"
+"__down_failed_interruptible:\n"
+"	pushl %edx\n"
+"	pushl %ecx\n"
+"	call  __down_interruptible\n"
+"	popl  %ecx\n"
+"	popl  %edx\n"
+"	ret\n"
 );
 
 asm(
 ".text\n"
 ".align 4\n"
 ".globl __down_failed_trylock\n"
-"__down_failed_trylock:\n\t"
-	"pushl %edx\n\t"
-	"pushl %ecx\n\t"
-	"call __down_trylock\n\t"
-	"popl %ecx\n\t"
-	"popl %edx\n\t"
-	"ret"
+"__down_failed_trylock:\n"
+"	pushl %edx\n"
+"	pushl %ecx\n"
+"	call  __down_trylock\n"
+"	popl  %ecx\n"
+"	popl  %edx\n"
+"	ret\n"
 );
 
 asm(
 ".text\n"
 ".align 4\n"
 ".globl __up_wakeup\n"
-"__up_wakeup:\n\t"
-	"pushl %eax\n\t"
-	"pushl %edx\n\t"
-	"pushl %ecx\n\t"
-	"call __up\n\t"
-	"popl %ecx\n\t"
-	"popl %edx\n\t"
-	"popl %eax\n\t"
-	"ret"
+"__up_wakeup:\n"
+"	pushl %eax\n"
+"	pushl %edx\n"
+"	pushl %ecx\n"
+"	call  __up\n"
+"	popl  %ecx\n"
+"	popl  %edx\n"
+"	popl  %eax\n"
+"	ret\n"
 );
 
 /*
@@ -238,29 +238,29 @@
  */
 #if defined(CONFIG_SMP)
 asm(
-"
-.align	4
-.globl	__write_lock_failed
-__write_lock_failed:
-	" LOCK "addl	$" RW_LOCK_BIAS_STR ",(%eax)
-1:	cmpl	$" RW_LOCK_BIAS_STR ",(%eax)
-	jne	1b
-
-	" LOCK "subl	$" RW_LOCK_BIAS_STR ",(%eax)
-	jnz	__write_lock_failed
-	ret
-
-
-.align	4
-.globl	__read_lock_failed
-__read_lock_failed:
-	lock ; incl	(%eax)
-1:	cmpl	$1,(%eax)
-	js	1b
-
-	lock ; decl	(%eax)
-	js	__read_lock_failed
-	ret
-"
+
+".align		4\n"
+".globl		__write_lock_failed\n"
+"__write_lock_failed:\n\t"
+"		"LOCK "addl	$" RW_LOCK_BIAS_STR ",(%eax)\n"
+"1:		 cmpl		$" RW_LOCK_BIAS_STR ",(%eax)\n"
+"		jne		1b\n"
+
+"		" LOCK "subl	$" RW_LOCK_BIAS_STR ",(%eax)\n"
+"		jnz		__write_lock_failed\n"
+"		ret\n"
+
+
+".align		4\n"
+".globl		__read_lock_failed\n"
+"__read_lock_failed:\n"
+"		lock ; incl	(%eax)\n"
+"1:		cmpl		$1,(%eax)\n"
+"		js		1b\n"
+
+"		lock ; decl	(%eax)\n"
+"		js		__read_lock_failed\n"
+"		ret\n"
+
 );
 #endif

--------- cut here ----------- cut here ---------- cut here -----

-- 
*********************************************
Paul Reich              RF/Microwave Engineer

    Support the "Freedom To Innovate"...
                Just say "No".

*********************************************

