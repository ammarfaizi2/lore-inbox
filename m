Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261287AbTCJLCC>; Mon, 10 Mar 2003 06:02:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261289AbTCJLCB>; Mon, 10 Mar 2003 06:02:01 -0500
Received: from mail2.space2u.com ([62.20.1.161]:21704 "EHLO mail2.space2u.com")
	by vger.kernel.org with ESMTP id <S261287AbTCJLCA>;
	Mon, 10 Mar 2003 06:02:00 -0500
Message-ID: <004b01c2e6f6$ace35c80$827ba8c0@mttw.net>
Illegal-Object: Syntax error in From: address found on vger.kernel.org:
	From:	"Carl =?ISO-8859-1?Q?=D6berg=22?= <webmaster@gitte.nu>"
			^-missing closing '"' in token
From: linux-kernel-owner@vger.kernel.org
To: <linux-kernel@vger.kernel.org>
Subject: PROBLEM: Intruders kidnapping PIDs of server processes
Date: Mon, 10 Mar 2003 12:17:44 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Intruders kidnapping PIDs of server processes

Problem/Background:
Recently our system was under attack by intruders using trojan code to
gain access to our system. Apparently they where trying to get one of
our servers to route IRC-traffic using psyBNC.

It seems like the intruders, probably using reppid to take over processes,
could hide their own processes in existing ones. Doing something like
ps -gaux won't show anything strange at all!
This makes it impossible to find and shut off unwanted processes.
Using netstat I could clearly see that "something" was listening on
ports that I didn't recognize. Doing netstat -ap only showed a dash '-'
instead of any process owning the socket.

Software:
The server was running Linux Redhat 7.2 (Kernel 2.4.7-10). Unfortunately
I cannot get anymore specific because the intruders seems to have rendered
the system unbootable before I had any chance of gathering info for
this report. But this bug (or feature) seems to affect all kernels,
regardless
of version.

Solution?
Is there anyway to fix this "bug" or is it a built-in feature. So that
software
like reppid simply can't take over an existing PID.

Sources:
Probably the intruders have been using something similar to the program
Reppid found at http://www.psychoid.lam3rz.de/reppid.c.

I would be grateful for an answer, even a simple "No,
it's not a bug, it's a feature" would help.

TIA
Carl Oeberg, (webmaster@gitte.nu)

