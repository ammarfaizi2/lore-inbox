Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262527AbUKRQnS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262527AbUKRQnS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 11:43:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262535AbUKRQnR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 11:43:17 -0500
Received: from web51903.mail.yahoo.com ([206.190.39.46]:38740 "HELO
	web51903.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262527AbUKRQmF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 11:42:05 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=YTZa43fLK62AXGZ/LRRAxG8CplKq6IWv5/rTzTvfAKhU/1TMK0mbBxH0NJS+ahPc1XxujmSi4nxRu3QatA/n04OD4jmiCcIbGX0ZoSaYML9abO/PIfGa7Jv7NK7OBTSgoQCPV4mDVDtTUBZysn9gG1a0oid7zhUqRKtUJX/ZN2Y=  ;
Message-ID: <20041118150952.4528.qmail@web51903.mail.yahoo.com>
Date: Thu, 18 Nov 2004 07:09:52 -0800 (PST)
From: A M <alim1993@yahoo.com>
Subject: Re: Accessing program counter registers from within C or Assembler. 
To: Valdis.Kletnieks@vt.edu
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200411162133.iAGLXn7v018578@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for your reply, please see my answers
embedded below: 
--- Valdis.Kletnieks@vt.edu wrote:

> On Tue, 16 Nov 2004 13:20:15 PST, A M said:
> 
> > Does anybody know how to access the address of the
> > current executing instruction in C while the
> program
> > is executing?
> 
> For what processor?  x86, itanium, sparc, s390 all
> do it differently.
I am targeting an x86 machines. 
> 
> Also, the answer to "this *very* instruction" is
> different from
> "where this instruction was when we
> trapped/kdbg/interrupt/whatever
> it so we could look at the current
> process/thread/worker state".
> 
> In other words, are you trying to answer "Where in
> memory am *I*?"
> or "Where in memory is <that very recent code I want
> to look at>?"
it is close to the second scenario ("Where in memory
is...") the basic idea is to come up with a
passive-software based data bus analyzer that can be
used to monitor/sample instructions of a process (a
section of a process) or a thread while executing. 
> 
> (Hint - for the former, you can probably get very
> good approximations
> by just looking at the entry point address for the
> function:
> 
> 	(void *) where = &__FUNCTION__;
> 
> > Also, is there a method to load a program image
> from
> > memory not a file (an exec that works with a
> memory
> > address)? Mainly I am looking for a method that
> brings
> > a program image into memory modify parts of it and
> > start the in-memory modified version.
> 
> In user space, you probably want either mmap() or
> dlopen(), depending what it
> is you're trying to do, most likely...
> 
> In kernel space, you'll have to be more specific as
> to what you're
> trying to do, but you're always welcome to write a
> replacement for
> fs/binfmt_elf.c :)
> 
> > Can anybody think of a method to replace a thread
> > image without replacing the whole process image? 
> 
> What are you trying to achieve here?  It's unclear
> what you're
> hoping will happen....
The ability to create threads and replace the
functionality of one of the threads with a previously
compiled program (a complete process). 
> 

> ATTACHMENT part 2 application/pgp-signature 




		
__________________________________ 
Do you Yahoo!? 
The all-new My Yahoo! - Get yours free! 
http://my.yahoo.com 
 

