Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265027AbUGNPGR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265027AbUGNPGR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 11:06:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265510AbUGNPGQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 11:06:16 -0400
Received: from core.ece.northwestern.edu ([129.105.5.1]:17659 "EHLO
	core.ece.northwestern.edu") by vger.kernel.org with ESMTP
	id S265027AbUGNPGM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 11:06:12 -0400
Message-ID: <1089817172.40f54a540e0c1@core.ece.northwestern.edu>
Date: Wed, 14 Jul 2004 09:59:32 -0500
From: lya755@ece.northwestern.edu
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: question about ramdisk
References: <1089651469.40f2c30d44364@core.ece.northwestern.edu>  <ccugqu$tun$1@terminus.zytor.com>  <1089727279.40f3eb2f82a6c@core.ece.northwestern.edu>  <1089749203.22026.17.camel@mindpipe>  <1089753034.40f44fca074c2@core.ece.northwestern.edu> <1089753955.22175.8.camel@mindpipe>
In-Reply-To: <1089753955.22175.8.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.1
X-Originating-IP: 138.15.107.179
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am now thinking of a way to verify what H. Peter Anvin says about the 
ramdisk, so that I can watch what is going on when the executable is running. 
Is there any way to achieve that besides kernel debugging? I don't really want 
to debug the kernel for now.

Can I get the physical address of the text section with it's virtual address? 
If I can know the physical address of the code in ramdisk and can know the 
physical address of the text section of process address space, maybe this can 
be done.

Any suggestions?

Lei

Quoting Lee Revell <rlrevell@joe-job.com>:

> Sorry, wrong book, s/Programming/Development/.
> 
> http://www.amazon.com/exec/obidos/tg/detail/-
/0672325128/ref=pd_sim_books_2/002-8634838-0327232?v=glance&s=books
> 
> Lee
> 
> On Tue, 2004-07-13 at 17:10, lya755@ece.northwestern.edu wrote:
> > BTW, is the second book you mentioned this one?
> > 
> >
> http://www.amazon.com/exec/obidos/tg/detail/-/0201719754/102-1381649-9278501?
> > v=glance
> > 
> > 
> > Quoting Lee Revell <rlrevell@joe-job.com>:
> > 
> > > "Unix Internals", by Uresh Vahalia (sp?).  This book went everywhere I
> > > did for a year.  I cannot praise it highly enough.  Read that, then get
> > > Robert Love's 'Linux Kernel Programming'.
> > > 
> > > Lee
> > > 
> > > On Tue, 2004-07-13 at 10:01, lya755@ece.northwestern.edu wrote:
> > > > Thank you! Can you pls tell me where I can find related references?
> I've
> > > been 
> > > > looking into several books about kernel and part of the kernel code,
> but no
> > > 
> > > > luck so far.. 
> > > > 
> > > > Thanks for any comments!
> > > > 
> > > > Quoting "H. Peter Anvin" <hpa@zytor.com>:
> > > > 
> > > > > Followup to:  <1089651469.40f2c30d44364@core.ece.northwestern.edu>
> > > > > By author:    lya755@ece.northwestern.edu
> > > > > In newsgroup: linux.dev.kernel
> > > > > >
> > > > > > Hi all,
> > > > > > 
> > > > > > I am learning linux kernel and have a question about ramdisk. When
> > > loading
> > > > > an 
> > > > > > executable in ramdisk, is the kernel loading the code all at a time
> to
> > > > > memory 
> > > > > > and then execute, or is it loading only a page at one time and
> > > generating a
> > > > > 
> > > > > > page fault to fetch another page?
> > > > > > 
> > > > > > Thanks for any comments! Waiting desprately for your help.
> > > > > > 
> > > > > 
> > > > > Neither.  The code is already in RAM.  It's mapped into the process
> > > > > address space and run in place.
> > > > > 
> > > > > 	-hpa
> > > > > -
> > > > > To unsubscribe from this list: send the line "unsubscribe
> linux-kernel"
> > > in
> > > > > the body of a message to majordomo@vger.kernel.org
> > > > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > > > Please read the FAQ at  http://www.tux.org/lkml/
> > > > > 
> > > > 
> > > > 
> > > > 
> > > > _________________________________________________________
> > > > This message was sent through the NU ECE webmail gateway.
> > > > -
> > > > To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> in
> > > > the body of a message to majordomo@vger.kernel.org
> > > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > > Please read the FAQ at  http://www.tux.org/lkml/
> > > > 
> > > 
> > 
> > 
> > 
> > _________________________________________________________
> > This message was sent through the NU ECE webmail gateway.
> > 
> 



_________________________________________________________
This message was sent through the NU ECE webmail gateway.
