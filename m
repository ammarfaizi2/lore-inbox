Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267379AbRGTUob>; Fri, 20 Jul 2001 16:44:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267382AbRGTUoW>; Fri, 20 Jul 2001 16:44:22 -0400
Received: from [24.229.53.66] ([24.229.53.66]:6182 "HELO
	bbserver1.backbonesecurity.com") by vger.kernel.org with SMTP
	id <S267379AbRGTUoM> convert rfc822-to-8bit; Fri, 20 Jul 2001 16:44:12 -0400
Subject: RE: Simple LKM & copy_from_user question (followup)
Date: Fri, 20 Jul 2001 16:52:32 -0400
Message-ID: <94FD5825A793194CBF039E6673E9AFE00B64A1@bbserver1.backbonesecurity.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Thread-Topic: Simple LKM & copy_from_user question (followup)
Thread-Index: AcERXVYrRVVd45CIQnGgrxqo2TQ6mQAADOSw
content-class: urn:content-classes:message
From: "David CM Weber" <dweber@backbonesecurity.com>
X-MimeOLE: Produced By Microsoft Exchange V6.0.4417.0
Cc: <linux-kernel@vger.kernel.org>
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

God(Allah, Ganesh, or whom/whatever) bless you all.  Turns out I am a
dumba** and forgot to define __KERNEL__

Thanks to all for your help.  It's a valuable lesson that I'm sure
newbies make lots of..

Thanks,


Dave Weber
(Feeling somewhat idiotic)

Backbone Security, Inc.
570-422-7900





> -----Original Message-----
> From: Randy.Dunlap [mailto:rddunlap@osdlab.org]
> Sent: Friday, July 20, 2001 4:39 PM
> To: David CM Weber
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: Simple LKM & copy_from_user question (followup)
> 
> 
> Hi-
> 
> I'll suggest a few things for you.
> 
>     cd to your linux tree and 'make modules'
>     Look at the gcc compile string there.
>     Try to copy it closely.
> 
> I added -I/path/to/linux/include and -D__KERNEL__
> and compiled your module with no problem.
> 
> If you had included the complete messages, we could have
> seen that it was using /usr/include/linux for header files
> instead of header files from linux/include/* .
> (at least that's what it did on my system)
> 
> ~Randy
> 
> 
> David CM Weber wrote:
> > 
> > Attached is the file I"m having problems with.  I'm compiling it w/
> > 
> > gcc -O3 -c main.c
> > 
> > Thanks in advance,
> > 
> > Dave Weber
> > Backbone Security, Inc.
> > 570-422-7900
> > 
> > > -----Original Message-----
> > > From: David CM Weber
> > > Sent: Friday, July 20, 2001 12:45 PM
> > > To: linux-kernel@vger.kernel.org
> > > Subject: Simple LKM & copy_from_user question
> > >
> > >
> > > Hello all.  I've been lurking for a while, and I have a quick
> > > question.
> > > I'm in the process of writing my first LKM to mess with the
> > > sys_socketcall function.  I'm looking at the original one for
> > > guidance,
> > > and it makes a call to copy_from_user() to get some
> > > socket-related data.
> > >
> > > So, to use copy_from_user(), I've gathered that I need to #include
> > > <asm/uaccess.h>, so I do so.
> > >
> > > After including this file, I'm getting the following errors:
> > >
> > >
> > > .../linux/timer.h:21: field 'vec' has incomplete type
> > >
> > > .../asm/uaccess.h::63: dereferencing pointer to incomplete type
> > >
> > >
> > > (This is not a full list of the error message that it's reporting)
> > >
> > > Am I not setting a define correctly?
> > >
> > > I'm using Redhat 7.1, on an Intel P3 system.  It's the 
> latest stable
> > > release (2.4.x ??) of the kernel.
> > >
> > > If you need more information, please let me know.  This has been
> > > troubling me for several days now..
> 
