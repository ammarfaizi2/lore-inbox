Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288549AbSADIj5>; Fri, 4 Jan 2002 03:39:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288548AbSADIjr>; Fri, 4 Jan 2002 03:39:47 -0500
Received: from web20306.mail.yahoo.com ([216.136.226.87]:7185 "HELO
	web20306.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S288549AbSADIjo>; Fri, 4 Jan 2002 03:39:44 -0500
Message-ID: <20020104083943.4180.qmail@web20306.mail.yahoo.com>
Date: Fri, 4 Jan 2002 00:39:43 -0800 (PST)
From: Amber Palekar <amber_palekar@yahoo.com>
Subject: interruptible_sleep_on_timeout hangs my m/c
To: kernel list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,
  i want to do a non-blocking sock_recvmsg in a
module(2.4.4 on an i386) .( i am usign MSG_DONTWAIT
for that ) I am doing this inside a kernel
thread.After this stmt , i put the thread to sleep by
doing :-

 while(1)
{
   .....
   .....
   ret = sock_recvmsg(.....,MSG_DONTWAIT);
   if(ret < 0)
   {
	DECLARE_WAIT_QUEUE_HEAD(wait);
	interruptible_sleep_on_timeout(&wait,HZ);
   }
   else
   {
	/* print the mesg and get out of loop */
   }
 }
      As soon as i insmod this module my m/c just
hangs after it reaches the sleep stmt( i used printk
debugging to get this ) Any solutions ????

TIA,
Amber
      
 




__________________________________________________
Do You Yahoo!?
Send your FREE holiday greetings online!
http://greetings.yahoo.com
