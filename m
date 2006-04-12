Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751092AbWDLFAl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751092AbWDLFAl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 01:00:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750831AbWDLFAl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 01:00:41 -0400
Received: from smtpout.mac.com ([17.250.248.44]:20178 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1751092AbWDLFAk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 01:00:40 -0400
In-Reply-To: <443C716C.1060103@rtr.ca>
References: <20060411063127.97362.qmail@web54314.mail.yahoo.com> <20060411230642.GV23222@vasa.acc.umu.se> <bda6d13a0604111938j5ece401cid364582fe9d6cf76@mail.gmail.com> <443C716C.1060103@rtr.ca>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <0919DCE8-35FE-4686-A6A0-1D4638047B2F@mac.com>
Cc: Joshua Hudson <joshudson@gmail.com>,
       Ramakanth Gunuganti <rgunugan@yahoo.com>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: GPL issues
Date: Wed, 12 Apr 2006 01:00:20 -0400
To: Mark Lord <lkml@rtr.ca>
X-Mailer: Apple Mail (2.746.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 11, 2006, at 23:18:04, Mark Lord wrote:
> Joshua Hudson wrote:
>> On 4/11/06, David Weinehall <tao@acc.umu.se> wrote:
>>> OK, simplified rules; if you follow them you should generally be OK:
> ..
>>> 3. Userspace code that uses interfaces that was not exposed to  
>>> userspace before you change the kernel --> GPL (but don't do it;  
>>> there's almost always a reason why an interface is not exported  
>>> to userspace)
>>>
>>> 4. Userspace code that only uses existing interfaces --> choose  
>>> license yourself (but of course, GPL would be nice...)
>
> Err.. there is ZERO difference between situations 3 and 4.   
> Userspace code can be any license one wants, regardless of where or  
> when or how the syscalls are added to the kernel.

Not necessarily, there may be grey area.  The new splice() syscall,  
for example; does any other software have a syscall that even  
remotely resembles it?  Could a piece of software that uses the splice 
() syscall be said to stand on its own as a separate work?  Those are  
the questions you should be asking.  For that particular case, the  
answers are probably yes; _especially_ if the program in question has  
an abstraction library for file IO.  Now let's discuss a binary  
program specifically designed to read and write several sysfs files.   
Does any other operating system have anything like sysfs?  Could that  
program be said to stand on its own?  Would it work without  
linux-2.6?  It doesn't even work on linux-2.4!  Would that be  
considered a "derivative work"??  I don't know the answers to these  
questions, and I suspect it would depend a _lot_ on what the software  
did with those interfaces, how it used the functionality, etc.

A program that doesn't use more than standard SysV/UNIX/POSIX/ANSI/ 
etc functionality, or provides an abstraction layer so that it works  
on more than just Linux is definitely OK.  It stands distinct from  
the kernel; does not strictly depend on a particular version of a  
particular operating system.  A module that links directly into the  
kernel and messes with its internals is most certainly NOT ok.  The  
grey area in between is exceptionally unclear.  I don't think we can  
state for certain until a legal case comes up in the courts, but  
let's just hope it never comes to that.

Cheers,
Kyle Moffett

