Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129177AbQKGHxO>; Tue, 7 Nov 2000 02:53:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129337AbQKGHwt>; Tue, 7 Nov 2000 02:52:49 -0500
Received: from vega.services.brown.edu ([128.148.19.202]:33483 "EHLO
	vega.brown.edu") by vger.kernel.org with ESMTP id <S129121AbQKGHwj>;
	Tue, 7 Nov 2000 02:52:39 -0500
Message-Id: <4.3.2.7.2.20001107024237.00ad7b00@postoffice.brown.edu>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Tue, 07 Nov 2000 02:55:28 -0500
To: linux-kernel@vger.kernel.org
From: David Feuer <David_Feuer@brown.edu>
Subject: Re: Persistent module storage [was Linux 2.4 Status / TODO
  page]
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've seen the same arguments over and over again here.  It seems that there 
are two feasible ways to accomplish persistence:  totally kernel and 
totally user-space

The totally kernel-space people want to make a way for modules to store 
persistent data, either in memory, or across boots on disk.  These people 
seem to debate whether modules should be unloaded/loaded upon suspend/resume.

Among the user-space people, there are some who want the status quo, where 
the driver initializes the card, and then a user proggy sets it up the way 
it really should be, which causes the gap problem.

There was also a suggestion (which sounded pretty interesting) where the 
driver would not initialize the card until prompted to do so by a 
user-space program, which would also give it the correct settings.  It 
seems that the big problem with this is that the card may not get 
initialized when it needs to be.  The initialization/state-saver proggy may 
have to be called: on boot, on suspend, on restore, when the hardware is 
physically removed and replaced, when something goes wrong and the user 
wants to reset things, and on shutdown.

I just wanted to try to get all the arguments together on one page.  I hope 
I didn't miss anything, or make any big mistakes.  My own guess is that the 
first option is the most reliable, and that the last one is the most flexible.
--
This message has been brought to you by the letter alpha and the number pi.
David Feuer
David_Feuer@brown.edu

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
