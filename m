Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264610AbTA2ErN>; Tue, 28 Jan 2003 23:47:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264001AbTA2ErN>; Tue, 28 Jan 2003 23:47:13 -0500
Received: from web14201.mail.yahoo.com ([216.136.172.143]:40112 "HELO
	web14201.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S264610AbTA2ErM>; Tue, 28 Jan 2003 23:47:12 -0500
Message-ID: <20030129045633.45161.qmail@web14201.mail.yahoo.com>
Date: Tue, 28 Jan 2003 20:56:33 -0800 (PST)
From: Dhruv Gami <dhruvgami@yahoo.com>
Subject: module programming blues
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Everyone,

I am trying to develop a kernel module that will read
some user input (being given to a file) and perform
certain flag settings based on the information dumped
in the file.

After reading up on the basics of kernel programming
etc (im a newbie), i wrote a code that creates a
character device, and uses ioctl to read and write
from the file kept in user space.

I got sample code from The Linux Kernel Module
Programming Guide by Ori Pomerantz. In chapter 5, it
talks about talking to character devices.

I am able to compile the code, and insmod my module.
The problem is that the function device_open is not
being called on accessing it. It calls device_release
TWICE, and thus reduces  reference count by 2, taking
the count in negatives. That way im unable to rmmod
this module. 

Also, I am not able to figure out how to interact with
this module. If i cat something onto it, it goes into
an infinite loop echo'ing the file again n again.

If i do "/dev/char_dev < params" where /dev/char_dev
is the device i made using mknod(and giving major
number returned by my module), it gives an error
saying Permission Denied.

Can somebody tell me what i'm doing wrong ? Or give me
some pointers to text that can explain how things work
in a module. I dont know how control flows within a
module once init_module has been called.

Kindly CC replies to dhruvgami@yahoo.com as i am not
subscribed to the list.

thanks in advance
regards,
Gami

__________________________________________________
Do you Yahoo!?
Yahoo! Mail Plus - Powerful. Affordable. Sign up now.
http://mailplus.yahoo.com
