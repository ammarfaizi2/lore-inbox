Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264300AbTLESou (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 13:44:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264325AbTLESny
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 13:43:54 -0500
Received: from mail.scitechsoft.com ([63.195.13.67]:1006 "EHLO
	mail.scitechsoft.com") by vger.kernel.org with ESMTP
	id S264320AbTLESmu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 13:42:50 -0500
From: "Kendall Bennett" <KendallB@scitechsoft.com>
Organization: SciTech Software, Inc.
To: Linus Torvalds <torvalds@osdl.org>
Date: Fri, 05 Dec 2003 10:44:02 -0800
MIME-Version: 1.0
Subject: RE: Linux GPL and binary module exception clause? 
CC: linux-kernel@vger.kernel.org
Message-ID: <3FD06172.28193.4801EF18@localhost>
References: <MDEHLPKNGKAHNMBLJOLKMEIDIHAA.davids@webmaster.com>
In-reply-to: <Pine.LNX.4.58.0312042245350.9125@home.osdl.org>
X-mailer: Pegasus Mail for Windows (v4.02)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:

> So you can run the kernel and create non-GPL'd programs while running it
> to your hearts content. You can use it to control a nuclear submarine, and
> that's totally outside the scope of the license (but if you do, please
> note that the license does not imply any kind of warranty or similar).
> 
> BUT YOU CAN NOT USE THE KERNEL HEADER FILES TO CREATE NON-GPL'D BINARIES.
> 
> Comprende?

Right, and by extension of the same argument you cannot use kernel 
headers to create non-GPL'ed binaries that run IN USER SPACE! Just 
because a program runs in user space does not mean that it is not a 
dervived work. There is nothing special about a user mode program 
compared to a module just because it uses Linux system calls. The same 
principles you apply to determine whether a module is a derived work also 
apply to user space programs, *ESPECIALLY* if you consider that the GPL 
kernel header files contains code (inline C or assembler) that probably 
gets linked either directly or indirectly (through the C runtime library) 
into *EVERY* Linux user mode program. 

This exact reasoning is what RedHat (aka Cygnus) has been using for years 
with the Cygwin toolkit for Windows. Although 99% of the code built with 
the GNU compilers and Cygwin includes the glibc runtime library that is 
LGPL, every program *must* include the C runtime library startup code or 
it cannot function. *That* code is pure GPL, and by extension any program 
using the Cygwin libraries is a derived work and must be GPL. If you 
don't like that, by a commercially licensed version of Cygwin from 
RedHat/Cygnus instead.

This is also IMHO why so few people outside of Red Hat contribute to 
Cygwin, but that is a different issue ;-)

Regards,

---
Kendall Bennett
Chief Executive Officer
SciTech Software, Inc.
Phone: (530) 894 8400
http://www.scitechsoft.com

~ SciTech SNAP - The future of device driver technology! ~

