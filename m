Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263011AbSJGMfo>; Mon, 7 Oct 2002 08:35:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263008AbSJGMfo>; Mon, 7 Oct 2002 08:35:44 -0400
Received: from web12407.mail.yahoo.com ([216.136.173.134]:59207 "HELO
	web12407.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S263011AbSJGMfn>; Mon, 7 Oct 2002 08:35:43 -0400
Message-ID: <20021007124121.37417.qmail@web12407.mail.yahoo.com>
Date: Mon, 7 Oct 2002 05:41:21 -0700 (PDT)
From: Amol Lad <dal_loma@yahoo.com>
Subject: wake_up from interrupt handler
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
 I have a kernel thread which did add_to_wait_queue()
to wait for an event. 
The event for which above thread is waiting occurs in
an interrupt handler that calls wake_up() to wake the
above thread. 
Now I am faced with a 'lost wakeup' problem, in which
the    
kernel thread checks whether event occured, he finds
it to be 'not-occured' but before calling
add_to_wait_queue(), interrupt handler detects that
the event has occured and calls wake_up().
My thread sleeps forever.

I know some new APIs are provided in recent 2.5
kernel, but how to avoid this in 2.4.18

please CC me 

Thanks
Amol


__________________________________________________
Do you Yahoo!?
Faith Hill - Exclusive Performances, Videos & More
http://faith.yahoo.com
