Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264310AbTLESmp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 13:42:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264320AbTLESmp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 13:42:45 -0500
Received: from mail.scitechsoft.com ([63.195.13.67]:64237 "EHLO
	mail.scitechsoft.com") by vger.kernel.org with ESMTP
	id S264310AbTLESml (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 13:42:41 -0500
From: "Kendall Bennett" <KendallB@scitechsoft.com>
Organization: SciTech Software, Inc.
To: Valdis.Kletnieks@vt.edu
Date: Fri, 05 Dec 2003 10:44:02 -0800
MIME-Version: 1.0
Subject: Re: Linux GPL and binary module exception clause? 
CC: linux-kernel@vger.kernel.org
Message-ID: <3FD06172.6022.4801EF76@localhost>
In-reply-to: <200312050513.hB55D1ps030713@turing-police.cc.vt.edu>
References: Your message of "Fri, 05 Dec 2003 15:23:10 +1100." <16336.2094.950232.375620@wombat.chubb.wattle.id.au> 
X-mailer: Pegasus Mail for Windows (v4.02)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Chubb <peter@chubb.wattle.id.au> wrote:

> > As far as I know, interfacing to a published API doesn't infringe
> > copyright.
> 
> Well, if the only thing in the .h files was #defines and structure
> definitions, it would probably be a slam dunk to decide that, yes.
> 
> Here's the part where people's eyes glaze over:
> 
> % cd /usr/src/linux-2.6.0-test10-mm1
> % find include -name '*.h' | xargs egrep 'static.*inline' | wc -l
>    6288
> 
> That's 6,288 chances for you to #include GPL code and end up
> with executable derived from it in *your* .o file, not the kernel's.
> 
> More to the point, look at include/linux/rwsem.h, and ask yourself
> how to call down_read(), down_write(), up_read(), and up_write()
> without getting little snippets of GPL all over your .o.  

Clearly that is easy to work around, because all you need to do is have a 
small GPL wrapper module that includes the Linux kernel headers and would 
end up having GPL code linked into it, and build the wrapper such that it 
makes calls via an API *you* define into your code. Then your code is 
simply interfacing via your own API to the GPL wrapper module and none of 
your code would be tainted. 

At least via direct inclusion and use of Linux kernel API header files 
anyway. There is still the issue of whether the specific binary module 
code you are linking into the kernel is Linux specific or not and would 
be considered a dervived work. If it is only for Linux and is not very 
useful for other platforms, one could argue that it is a derived work and 
hence should be GPL regardless of what API or GPL wrapper it uses.

Then again, if a module is completely Linux specific and the source for 
it has no use outside of Linux, I doubt a vendor could care less about 
keeping it proprietary anyway ;-)

Regards,

---
Kendall Bennett
Chief Executive Officer
SciTech Software, Inc.
Phone: (530) 894 8400
http://www.scitechsoft.com

~ SciTech SNAP - The future of device driver technology! ~

