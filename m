Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289291AbSAXAfc>; Wed, 23 Jan 2002 19:35:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289729AbSAXAfW>; Wed, 23 Jan 2002 19:35:22 -0500
Received: from stone.protocoloweb.com.br ([200.185.63.34]:41485 "EHLO
	smtp.ieg.com.br") by vger.kernel.org with ESMTP id <S289291AbSAXAfJ>;
	Wed, 23 Jan 2002 19:35:09 -0500
Message-ID: <003801c1a46e$f4c65140$0e63c0c8@P4William>
From: "William Voorsluys" <voor@ieg.com.br>
To: "Linux Kernel" <linux-kernel@vger.kernel.org>
Subject: Blocked processes queue
Date: Wed, 23 Jan 2002 22:34:53 -0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a doubt about how to obtain the number of processes that are blocked
due to I/O operations.
As we know, a process can be on three different states: running, ready to
run, and blocked. The linux kernel classifies them as RUNNING (R), that also
comprises the process that are ready to run, SLEPPING (S), that comprises
all processes that are waiting for an interruption. My doubt is about the
processes that are on state (D). Is this equivalent to the processes that
are blocked due to I/O operations? Is I/O the only situation that can make a
process to be on state 'D'?
I've written some code to count how many processes are on this state because
I wanted to know how many were blocked. For me, that would mean that the
host is overloaded with I/O operations (disk access, message sending and
receiving), and the CPU wouldn't beeing used so much. What I want to know is
whether the amount of processes that are on 'D' state is the correct
information which tells me how many processes are waiting for a resource. If
not, how can obtain it? I'm obtaining all this information from /proc
filesystem, by reading each process directory and counting how many are on
'D' state (just like vmstat does). Is there any other way to obtain such
kind of information?
One last question... How can I simulate a code that makes a process to be on
'D' state. I've tried putting one scanf(), but while I don't type anything
the process is slepping, it should be blocked waiting for I/O.

Thank you all.

William



