Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136571AbREDX17>; Fri, 4 May 2001 19:27:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136573AbREDX1u>; Fri, 4 May 2001 19:27:50 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:24583 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S136571AbREDX1e>;
	Fri, 4 May 2001 19:27:34 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Andreas Schwab <schwab@suse.de>
cc: Todd Inglett <tinglett@vnet.ibm.com>, Alexander Viro <viro@math.psu.edu>,
        linux-kernel@vger.kernel.org
Subject: Re: SMP races in proc with thread_struct 
In-Reply-To: Your message of "04 May 2001 15:11:37 +0200."
             <jer8y52r92.fsf@hawking.suse.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 05 May 2001 09:27:28 +1000
Message-ID: <12062.989018848@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 04 May 2001 15:11:37 +0200, 
Andreas Schwab <schwab@suse.de> wrote:
>Keith Owens <kaos@ocs.com.au> writes:
>|> Wrap the reference to the parent task structure with exception table
>|> recovery code, like copy_from_user().
>
>Exception tables only protect accesses to user virtual memory.  Kernel
>memory references must always be valid in the first place.

Wrong.  Exception tables say that if the kernel gets an exception
between labels A and B then branch to fixup label C.  See show_regs()
in arch/i386/kernel/process.c and wrmsr_eio() in arch/i386/kernel/msr.c
for examples which do not depend on user virtual memory.

