Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129548AbRBWP0a>; Fri, 23 Feb 2001 10:26:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129624AbRBWP0V>; Fri, 23 Feb 2001 10:26:21 -0500
Received: from [212.115.175.146] ([212.115.175.146]:59642 "EHLO
	ftrs1.intranet.FTR.NL") by vger.kernel.org with ESMTP
	id <S129548AbRBWP0E>; Fri, 23 Feb 2001 10:26:04 -0500
Message-ID: <27525795B28BD311B28D00500481B7601F0F02@ftrs1.intranet.ftr.nl>
From: "Heusden, Folkert van" <f.v.heusden@ftr.nl>
To: ahu@ds9a.nl, Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: random PID generation
Date: Fri, 23 Feb 2001 16:34:41 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> My code runs trough the whole task_list to see if a chosen pid is already

>> in use or not. 
> But it doesn't check for a recently used PID. Lets say your system is 
> exhausting 1000 PIDs/second, and that there is a window of 20ms between
you 
> determining which PID to send to, and the recipient process receiving it. 

Ah, I get your point. Good point :o)

I was thinking: I could split the PIDs up in 2...16383 and 16384-32767 and
then
switch between them when a process ends? nah, that doesn't help it.
hmmm.
I think random increments (instead of last_pid+1) would be the best thing to
do then?


