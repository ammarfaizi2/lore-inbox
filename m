Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263354AbTJKSeN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Oct 2003 14:34:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263355AbTJKSeN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Oct 2003 14:34:13 -0400
Received: from web13007.mail.yahoo.com ([216.136.174.17]:10503 "HELO
	web13007.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263354AbTJKSeG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Oct 2003 14:34:06 -0400
Message-ID: <20031011183405.38980.qmail@web13007.mail.yahoo.com>
Date: Sat, 11 Oct 2003 11:34:05 -0700 (PDT)
From: asdfd esadd <retu834@yahoo.com>
Subject: Re: 2.7 thoughts: common well-architected object model
To: Kenn Humborg <kenn@linux.ie>
Cc: Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org
In-Reply-To: <20031011175744.GA15610@excalibur.research.wombat.ie>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is a connex, fork() might be a bad example,

it's simple - yes but 20 years have passed as Solaris
is finding:

pid_t fork(void); vs. 

the next step in the evolution CreateProcess

BOOL CreateProcess(
  LPCTSTR lpApplicationName,
  LPTSTR lpCommandLine,
  LPSECURITY_ATTRIBUTES lpProcessAttributes,
  LPSECURITY_ATTRIBUTES lpThreadAttributes,
  BOOL bInheritHandles,
  DWORD dwCreationFlags,
  LPVOID lpEnvironment,
  LPCTSTR lpCurrentDirectory,
  LPSTARTUPINFO lpStartupInfo,
  LPPROCESS_INFORMATION lpProcessInformation

evolved to .Net Process Class

System.Object
   System.MarshalByRefObject
      System.ComponentModel.Component
         System.Diagnostics.Process
[C#]
public class Process : Component
[C++]
public __gc class Process : public Component


with a full list of members mapping to the overall
model per se (link to hell, but they've got a point) 

http://msdn.microsoft.com/library/en-us/cpref/html/frlrfsystemdiagnosticsprocessmemberstopic.asp


So let me restate the need again for a:

* unified well architected core component model
which is extensible from OS services to application
objects

* the object model should be defined from the kernel
layer for process/events/devices etc. up and not
started at the application layer



--- Kenn Humborg <kenn@linux.ie> wrote:
> On Sat, Oct 11, 2003 at 09:06:21AM -0700, asdfd
> esadd wrote:
> > 
> > the other OS has an at this stage highly
> consistent
> > object model user along the lines of COM+ from the
> > kernel up encompassing a single event, thread etc.
> > model. Things are quite consistently wrapped, user
> > mode exposed if needed etc. If people were to
> fully
> > draw on it and the simpler .net BCL and not ride
> win32
> > that would (will be) a killer.  
> 
> I'm a Win32 developer by day, and I'm pretty
> familiar with
> the innards of COM.  But I can't think of a _single_
> instance
> of anything in COM or COM+ which is dependent on the
> kernel,
> or which lives on the kernel-side of the
> kernel-mode/usr-mode
> boundary.
> 
> COM and COM+ (and even .NET) are user-mode libraries
> and
> conventions.
> 
> The closest thing _inside_ the WinNT/2K/XP kernel to
> your
> "object model" is the hierarchical directory of
> refcounted
> and ACLed objects inside the kernel (which is
> basically sysfs
> with ACLs).
> 
> Can you give me _one_ example of a "consistent
> object model"
> between kernel and user mode in Windows?  Maybe then
> we'll
> have a better understanding of what you're really
> looking
> for.
> 
> Later,
> Kenn
> 
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
