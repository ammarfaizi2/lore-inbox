Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261942AbUDSUMh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 16:12:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261832AbUDSUMh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 16:12:37 -0400
Received: from web20210.mail.yahoo.com ([216.136.226.65]:49679 "HELO
	web20210.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261942AbUDSUMb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 16:12:31 -0400
Message-ID: <20040419201230.45125.qmail@web20210.mail.yahoo.com>
Date: Mon, 19 Apr 2004 17:12:30 -0300 (ART)
From: =?iso-8859-1?q?Fabiano=20Ramos?= <ramos_fabiano@yahoo.com.br>
Subject: Re: task switching at Page Faults
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0404192146330.31901@artax.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 --- Mikulas Patocka
<mikulas@artax.karlin.mff.cuni.cz> escreveu: > > Hi
all.
> >
> > 	I am in doubt about the linux kernel behaviour is
> this situation:
> > supose a have the process A, with the highest
> realtime
> > priority and SCHED_FIFO policy. The process then
> issues a syscall,
> > say read():
> >
> > 	1) Can I be sure that there will be no process
> switch during the
> > syscall processing, even if the system call causes
> a page fault?
> 
> No. If the data read is not in cache and if read
> operations causes page
> fault there will be process switch.
> 
> Additionally, if you don't mlock memory, there can
> be process switch at
> any place, because of page faults on code pages or
> swapping of data pages.

    I was reading the book "Understanding the Linux
kernel", about 2.4, and the authors: 
    1)assure that there is no process switch during
the execution of an eception handler (aka syscall).
they emphasize it.
    2) say that the execption handler may not generate
exceptions, except for page faults.

     So, if process switching occurs at page faults, I
was wondering which statement is true of if I am
missing sth. 
     You mentioned page faults due to code. Aren´t the
syscall handlers located in mlocked?

Thanks again
Fabiano



> 
> > 	2) What if the process was a non-realtime
> processes (ordinary
> > one, SCHED_OTHER)?
> 
> There can be process switches too.
> 
> Mikulas
> 
>  

=====
Fabiano Ramos
Mestrando em Engenharia de Sistemas e Computação
COPPE / UFRJ
http://www.cos.ufrj.br/~ramosf
ramosf@cos.ufrj.br

______________________________________________________________________

Yahoo! Messenger - Fale com seus amigos online. Instale agora! 
http://br.download.yahoo.com/messenger/
