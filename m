Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315722AbSETDIm>; Sun, 19 May 2002 23:08:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315726AbSETDIl>; Sun, 19 May 2002 23:08:41 -0400
Received: from beach.cise.ufl.edu ([128.227.205.211]:45809 "EHLO
	mail.cise.ufl.edu") by vger.kernel.org with ESMTP
	id <S315722AbSETDIk>; Sun, 19 May 2002 23:08:40 -0400
Date: Sun, 19 May 2002 23:08:36 -0400 (EDT)
From: Pradeep Padala <ppadala@cise.ufl.edu>
To: linux-kernel@vger.kernel.org
Subject: No PTRACE_READDATA for archs other than SPARC?
Message-ID: <Pine.GSO.4.05.10205192307500.26915-100000@rain.cise.ufl.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
   I was trying to understand ptrace code in kernel. It seems there's
no PTRACE_READDATA for architectures other than sparc and sparc64.
There's a function named ptrace_readdata() in kernel/ptrace.c but I
couldn't find a way to invoke it from user space. Is the feature
missing? or Is it intended?
   Another thing I noticed, the prototype for do_ptrace() in
   arch/sparc/kernel/ptrace.c is

   asmlinkage void do_ptrace(struct pt_regs *regs)

   I thought it should be some thing like
   asmlinkage int sys_ptrace(long request, long pid, long addr, long
data)

   It would be great if some one can answer it.

Thank You,
Pradeep Padala

-- 
Perfection is our goal, excellence will be tolerated. -- J. Yahl
--


