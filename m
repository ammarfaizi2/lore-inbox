Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263368AbTJKTBK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Oct 2003 15:01:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263369AbTJKTBK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Oct 2003 15:01:10 -0400
Received: from mail1.mail.iol.ie ([194.125.2.192]:20412 "EHLO
	mail1.mail.iol.ie") by vger.kernel.org with ESMTP id S263368AbTJKTBF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Oct 2003 15:01:05 -0400
Date: Sat, 11 Oct 2003 20:01:02 +0100
From: Kenn Humborg <kenn@linux.ie>
To: asdfd esadd <retu834@yahoo.com>
Cc: Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org
Subject: Re: 2.7 thoughts: common well-architected object model
Message-ID: <20031011190102.GA18624@excalibur.research.wombat.ie>
References: <20031011175744.GA15610@excalibur.research.wombat.ie> <20031011183405.38980.qmail@web13007.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031011183405.38980.qmail@web13007.mail.yahoo.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 11, 2003 at 11:34:05AM -0700, asdfd esadd wrote:
> There is a connex, fork() might be a bad example,
> 
> it's simple - yes but 20 years have passed as Solaris
> is finding:
> 
> pid_t fork(void); vs. 
> 
> the next step in the evolution CreateProcess

CreateProcess() did _not_ evolve from fork().  There is no fork() 
equivalent in the Windows world.  If anything it came more from 
$CREPRC in VMS.

> BOOL CreateProcess(
>   LPCTSTR lpApplicationName,
>   LPTSTR lpCommandLine,
>   LPSECURITY_ATTRIBUTES lpProcessAttributes,
>   LPSECURITY_ATTRIBUTES lpThreadAttributes,
>   BOOL bInheritHandles,
>   DWORD dwCreationFlags,
>   LPVOID lpEnvironment,
>   LPCTSTR lpCurrentDirectory,
>   LPSTARTUPINFO lpStartupInfo,
>   LPPROCESS_INFORMATION lpProcessInformation
> 
> evolved to .Net Process Class

"evolved to" is the wrong term - "wrapped by" is more accurate

> System.Object
>    System.MarshalByRefObject
>       System.ComponentModel.Component
>          System.Diagnostics.Process

... which is a _user-land_ wrapper around CreateProcess.

> So let me restate the need again for a:
> 
> * unified well architected core component model
> which is extensible from OS services to application
> objects

Which is a job for userland, in my opinion.

> * the object model should be defined from the kernel
> layer for process/events/devices etc. up and not
> started at the application layer

I still don't see why this needs to be in the kernel.
Give a concrete example of something that cannot be done
with the existing syscall interface and user-mode wrappers.
Or something significant that can be done easier with what
you are asking for.

Of course, your name "asdfd esadd" does look a bit troll-like...

Later,
Kenn

