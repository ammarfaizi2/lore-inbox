Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313479AbSC2QbW>; Fri, 29 Mar 2002 11:31:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313480AbSC2QbM>; Fri, 29 Mar 2002 11:31:12 -0500
Received: from web21307.mail.yahoo.com ([216.136.128.232]:50728 "HELO
	web21307.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S313479AbSC2QbE>; Fri, 29 Mar 2002 11:31:04 -0500
Message-ID: <20020329163103.71534.qmail@web21307.mail.yahoo.com>
Date: Fri, 29 Mar 2002 08:31:03 -0800 (PST)
From: chiranjeevi vaka <cvaka_kernel@yahoo.com>
Subject: problems with timers
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have a problem regarding timers. I am trying to add
a new timer in TCP layer which will start in the 3-way
handshaking of TCP. In that timer driven function I am
just modifying the timer using mod_timer and I am
printing some debug message. 

I am deleting the timer whenever I receive FIN from
either peer. On one side when I receive a FIN in
TCP_FIN_WAIT1 or TCP_FIN_WAIT2 I am deleting the timer
and on the other side when I am in TCP_ESTABLISHED
state if I receive a FIN I am deleting the timer. 

This is working fine if I am calling the system call
cloase(sockid) from user level. But if I don't use
that system call or if I just press ctrl+c from user
level while data is passing between peers, then after
some time the timer is keep om triggering infinitely
and the system is hanging. Can you suggest me where
will I delete the timer in these cases.


Thank you,
Chiranjeevi

__________________________________________________
Do You Yahoo!?
Yahoo! Greetings - send holiday greetings for Easter, Passover
http://greetings.yahoo.com/
