Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267339AbRGTUkl>; Fri, 20 Jul 2001 16:40:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267340AbRGTUkb>; Fri, 20 Jul 2001 16:40:31 -0400
Received: from archive.osdlab.org ([65.201.151.11]:21404 "EHLO fire.osdlab.org")
	by vger.kernel.org with ESMTP id <S267339AbRGTUkW>;
	Fri, 20 Jul 2001 16:40:22 -0400
Message-ID: <3B5896D3.341C36F5@osdlab.org>
Date: Fri, 20 Jul 2001 13:38:43 -0700
From: "Randy.Dunlap" <rddunlap@osdlab.org>
Organization: OSDL
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-ac5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: David CM Weber <dweber@backbonesecurity.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Simple LKM & copy_from_user question (followup)
In-Reply-To: <94FD5825A793194CBF039E6673E9AFE00B64A0@bbserver1.backbonesecurity.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hi-

I'll suggest a few things for you.

    cd to your linux tree and 'make modules'
    Look at the gcc compile string there.
    Try to copy it closely.

I added -I/path/to/linux/include and -D__KERNEL__
and compiled your module with no problem.

If you had included the complete messages, we could have
seen that it was using /usr/include/linux for header files
instead of header files from linux/include/* .
(at least that's what it did on my system)

~Randy


David CM Weber wrote:
> 
> Attached is the file I"m having problems with.  I'm compiling it w/
> 
> gcc -O3 -c main.c
> 
> Thanks in advance,
> 
> Dave Weber
> Backbone Security, Inc.
> 570-422-7900
> 
> > -----Original Message-----
> > From: David CM Weber
> > Sent: Friday, July 20, 2001 12:45 PM
> > To: linux-kernel@vger.kernel.org
> > Subject: Simple LKM & copy_from_user question
> >
> >
> > Hello all.  I've been lurking for a while, and I have a quick
> > question.
> > I'm in the process of writing my first LKM to mess with the
> > sys_socketcall function.  I'm looking at the original one for
> > guidance,
> > and it makes a call to copy_from_user() to get some
> > socket-related data.
> >
> > So, to use copy_from_user(), I've gathered that I need to #include
> > <asm/uaccess.h>, so I do so.
> >
> > After including this file, I'm getting the following errors:
> >
> >
> > .../linux/timer.h:21: field 'vec' has incomplete type
> >
> > .../asm/uaccess.h::63: dereferencing pointer to incomplete type
> >
> >
> > (This is not a full list of the error message that it's reporting)
> >
> > Am I not setting a define correctly?
> >
> > I'm using Redhat 7.1, on an Intel P3 system.  It's the latest stable
> > release (2.4.x ??) of the kernel.
> >
> > If you need more information, please let me know.  This has been
> > troubling me for several days now..
