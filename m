Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262609AbRFNNah>; Thu, 14 Jun 2001 09:30:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262618AbRFNNa1>; Thu, 14 Jun 2001 09:30:27 -0400
Received: from beta.dmz-eu.st.com ([164.129.1.35]:5779 "HELO
	beta.dmz-eu.st.com") by vger.kernel.org with SMTP
	id <S262609AbRFNNaQ>; Thu, 14 Jun 2001 09:30:16 -0400
From: Philippe.LAFFONT@st.com
X-OpenMail-Hops: 2
Date: Thu, 14 Jun 2001 15:19:17 +0200
Message-Id: <H00006240b52eb6d@MHS>
Subject: Strange behaviour of the Round Robin policy
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=US-ASCII; name="cc:Mail"
Content-Disposition: inline; filename="cc:Mail"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

     I'm using RedHat Linux V2.2.13 and I made the following test:
     
     I launched 10 times the same program with priority 10 of Round Robin 
     policy (from a shell having priority 20 of FIFO policy). Each program 
     does an infinite busy loop (while (1)).
     One minute later, I launched the "ps" command and I was expected that 
     the TIME values of all these processes are in an interval which is T 
     large, where T is given by sched_rr_get_interval() i.e. T=150ms in 
     this release.
     
     But the ps result was:
     PID TTY          TIME CMD
     652 tty1     00:00:00 login
     1549 tty1     00:00:00 bash
     1566 tty1     00:00:00 bash
     1596 tty1     00:01:12 my_program
     1597 tty1     00:00:02 my_program
     1598 tty1     00:00:01 my_program
     1599 tty1     00:00:01 my_program
     1600 tty1     00:00:05 my_program
     1601 tty1     00:00:01 my_program
     1602 tty1     00:00:00 my_program
     1603 tty1     00:00:16 my_program
     1604 tty1     00:00:01 my_program
     1605 tty1     00:00:00 my_program
     1610 tty1     00:00:00 ps
     
     Does someone have any explanation of this behavior? Thanks in advance.
     
     
     

