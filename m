Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268405AbTBNMvU>; Fri, 14 Feb 2003 07:51:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268406AbTBNMvU>; Fri, 14 Feb 2003 07:51:20 -0500
Received: from rwcrmhc52.attbi.com ([216.148.227.88]:26023 "EHLO
	rwcrmhc52.attbi.com") by vger.kernel.org with ESMTP
	id <S268405AbTBNMvT>; Fri, 14 Feb 2003 07:51:19 -0500
Subject: RE: Synchronous signal delivery..
From: Keith Adamson <keith.adamson@attbi.com>
To: Giuliano Pochini <pochini@shiny.it>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <XFMail.20030214115507.pochini@shiny.it>
References: <XFMail.20030214115507.pochini@shiny.it>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 14 Feb 2003 08:04:23 -0500
Message-Id: <1045227864.16047.14.camel@x1-6-00-d0-70-00-74-d1>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-02-14 at 05:55, Giuliano Pochini wrote:
> 
> > It's a generic "synchronous signal delivery" method, and it uses a
> > perfectly regular file descriptor to deliver an arbitrary set of signals
> > that are pending.
> >
> > It adds one new system call:
> >
> >       fd = sigfd(sigset_t * mask, unsigned long flags);
> 
> IMHO it's not simply a signal delivery system, it's a message queue. It's
> possible to deliver any kind of data to the process, and the fd can be
> used to send data to other processes as well.
> 

IMHO I agree, it would be real nice to be able to expose signals to 
other processes using a socket type of interface.  Even the kernel 
could expose certain internal signals to user space programs such 
as VM pressure.

