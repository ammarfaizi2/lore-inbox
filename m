Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288593AbSADKgd>; Fri, 4 Jan 2002 05:36:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288591AbSADKgO>; Fri, 4 Jan 2002 05:36:14 -0500
Received: from web20308.mail.yahoo.com ([216.136.226.89]:3344 "HELO
	web20308.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S288589AbSADKfz>; Fri, 4 Jan 2002 05:35:55 -0500
Message-ID: <20020104103554.31340.qmail@web20308.mail.yahoo.com>
Date: Fri, 4 Jan 2002 02:35:54 -0800 (PST)
From: Amber Palekar <amber_palekar@yahoo.com>
Subject: Thread Insomnia !!!
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
