Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316893AbSGSQcT>; Fri, 19 Jul 2002 12:32:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316895AbSGSQcT>; Fri, 19 Jul 2002 12:32:19 -0400
Received: from w089.z209220022.nyc-ny.dsl.cnc.net ([209.220.22.89]:11656 "HELO
	yucs.org") by vger.kernel.org with SMTP id <S316893AbSGSQcS>;
	Fri, 19 Jul 2002 12:32:18 -0400
Subject: Re: more thoughts on a new jail() system call
From: Shaya Potter <spotter@cs.columbia.edu>
To: linux-kernel@vger.kernel.org
In-Reply-To: <200207190306.g6J366956014@saturn.cs.uml.edu>
References: <200207190306.g6J366956014@saturn.cs.uml.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.7 
Date: 19 Jul 2002 12:35:19 -0400
Message-Id: <1027096520.2635.56.camel@zaphod>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-07-18 at 23:06, Albert D. Cahalan wrote:
> 
> >> sys_vhangup) NOT SURE -  Should be fine, right?
> >
> > Seems ok to me.
> 
> Have fun with devpts.

what would happen if a jail had virtualized ttys? i.e. they each had
tty1,2,3,4..... and this was transalted to an open real tty when needed,
and the transalation mapping being kept in the prison struct?

> 
> >> sys_getsid) NOT SURE - whats it for?
> >
> > You shouldn't be able to call getsid() on some other
> > process outside the jail.  Also, calling getsid() on
> > yourself might reveal information about your parent,
> > like getppid() or getpgid() (minor).
> 
> Your parent ought to be 1.

yes.

