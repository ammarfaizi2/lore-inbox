Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262296AbSJJMQe>; Thu, 10 Oct 2002 08:16:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262310AbSJJMQd>; Thu, 10 Oct 2002 08:16:33 -0400
Received: from web21506.mail.yahoo.com ([66.163.169.17]:36425 "HELO
	web21506.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S262296AbSJJMQd>; Thu, 10 Oct 2002 08:16:33 -0400
Message-ID: <20021010122217.35033.qmail@web21506.mail.yahoo.com>
Date: Thu, 10 Oct 2002 05:22:17 -0700 (PDT)
From: oleg afanasjev <cplusplusprogrammar@yahoo.com>
Subject: race aware poll implementation on SMP
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

I'm writing a kernel module for 2.4 kernel. This
module serves 2 device files. One of them represents
hardware and the other is used to connect a software
emulation of that hardware if the read adapter 
is absent.
When an application accesses the first device it is
put to sleep till the software emulation supplies the
needed data.
Emulation sleeps in a poll when device ain't accessed.
It is supposed to work on SMP machine.
Should poll fileop be made race aware? What if the
wake_up happens between checking the poll status and
puting process in wait queue?


=====
Best regards,
Oleg Afanasjev

-

__________________________________________________
Do you Yahoo!?
Faith Hill - Exclusive Performances, Videos & More
http://faith.yahoo.com
