Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265960AbUFJFbL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265960AbUFJFbL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 01:31:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266115AbUFJFbL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 01:31:11 -0400
Received: from web14201.mail.yahoo.com ([216.136.172.143]:3425 "HELO
	web14201.mail.yahoo.com") by vger.kernel.org with SMTP
	id S265960AbUFJFbI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 01:31:08 -0400
Message-ID: <20040610053107.4952.qmail@web14201.mail.yahoo.com>
Date: Wed, 9 Jun 2004 22:31:07 -0700 (PDT)
From: "j.random.programmer" <javadesigner@yahoo.com>
Subject: Re: Threading behavior in 2.6.5 may be broken ?
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all:

This is a followup to my earlier post about
threading in 2.6.5

After more experimenting, I have found the following
behavior:

Specifying the per-thread maximum stack size to
the java JVM allows one to create more threads.
For example, specifying 128k of stack per thread
(max), allows me to create 6000 threads. By
default, I think 2 MB per thread is assigned for
that thread's stack space. I don't know if the 2MB
is the default in the JVM, glibc, or the kernel.

However, even if I am using 2 MB * 10,000 threads
(=20 GB of RAM), the machine _should_ give an
out of memory error but should _not_ get totally
wedged (so that ctrl-c doesn't work in that shell
to break out of the program or ssh is inoperative
so I cannot ssh into another shell and kill the jvm).

Best regards,

--j


	
		
__________________________________
Do you Yahoo!?
Friends.  Fun.  Try the all-new Yahoo! Messenger.
http://messenger.yahoo.com/ 
