Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263369AbTJKTLl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Oct 2003 15:11:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263370AbTJKTLl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Oct 2003 15:11:41 -0400
Received: from web13001.mail.yahoo.com ([216.136.174.11]:43710 "HELO
	web13001.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263369AbTJKTLi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Oct 2003 15:11:38 -0400
Message-ID: <20031011191137.25190.qmail@web13001.mail.yahoo.com>
Date: Sat, 11 Oct 2003 12:11:37 -0700 (PDT)
From: retu <retu834@yahoo.com>
Subject: Re: 2.7 thoughts: common well-architected object model
To: Kenn Humborg <kenn@linux.ie>
Cc: Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org
In-Reply-To: <20031011190102.GA18624@excalibur.research.wombat.ie>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


you are right on - user-mode wrappers, a consistent
namespace is what's needed. Sun 'forgot' about that
for many many years and is now left with an OS that's
essentially the same as 20 years ago. 

Data access etc. classes could derive from a well
defined model framework. If someone defines a base
framework (not on the trivial side considering
simplicity/elegance, performance, security,
extensibility needs) then this could get going.    

> > System.Object
> >    System.MarshalByRefObject
> >       System.ComponentModel.Component
> >          System.Diagnostics.Process
>
> ... which is a _user-land_ wrapper around 
> CreateProcess.




--- Kenn Humborg <kenn@linux.ie> wrote:
> On Sat, Oct 11, 2003 at 11:34:05AM -0700, asdfd
> esadd wrote:
> > There is a connex, fork() might be a bad example,
> > 
> > it's simple - yes but 20 years have passed as
> Solaris
> > is finding:
> > 
> > pid_t fork(void); vs. 
> > 
> > the next step in the evolution CreateProcess
> 
> CreateProcess() did _not_ evolve from fork().  There
> is no fork() 
> equivalent in the Windows world.  If anything it
> came more from 
> $CREPRC in VMS.
> 
> > BOOL CreateProcess(
> >   LPCTSTR lpApplicationName,
> >   LPTSTR lpCommandLine,
> >   LPSECURITY_ATTRIBUTES lpProcessAttributes,
> >   LPSECURITY_ATTRIBUTES lpThreadAttributes,
> >   BOOL bInheritHandles,
> >   DWORD dwCreationFlags,
> >   LPVOID lpEnvironment,
> >   LPCTSTR lpCurrentDirectory,
> >   LPSTARTUPINFO lpStartupInfo,
> >   LPPROCESS_INFORMATION lpProcessInformation
> > 
> > evolved to .Net Process Class
> 
> "evolved to" is the wrong term - "wrapped by" is
> more accurate
> 
> > System.Object
> >    System.MarshalByRefObject
> >       System.ComponentModel.Component
> >          System.Diagnostics.Process
> 
> ... which is a _user-land_ wrapper around
> CreateProcess.
> 
> > So let me restate the need again for a:
> > 
> > * unified well architected core component model
> > which is extensible from OS services to
> application
> > objects
> 
> Which is a job for userland, in my opinion.
> 
> > * the object model should be defined from the
> kernel
> > layer for process/events/devices etc. up and not
> > started at the application layer
> 
> I still don't see why this needs to be in the
> kernel.
> Give a concrete example of something that cannot be
> done
> with the existing syscall interface and user-mode
> wrappers.
> Or something significant that can be done easier
> with what
> you are asking for.
> 
> Of course, your name "asdfd esadd" does look a bit
> troll-like...
> 
> Later,
> Kenn
> 
> -
> To unsubscribe from this list: send the line
> "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at 
> http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


__________________________________
Do you Yahoo!?
The New Yahoo! Shopping - with improved product search
http://shopping.yahoo.com
