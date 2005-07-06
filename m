Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262304AbVGFT6O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262304AbVGFT6O (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 15:58:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261938AbVGFTzb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 15:55:31 -0400
Received: from tag.witbe.net ([81.88.96.48]:22146 "EHLO tag.witbe.net")
	by vger.kernel.org with ESMTP id S262337AbVGFPGk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 11:06:40 -0400
Message-Id: <200507061506.j66F6dR25621@tag.witbe.net>
Reply-To: <rol@as2917.net>
From: "Paul Rolland" <rol@as2917.net>
To: <linux-kernel@vger.kernel.org>
Subject: "Spy'ing" characters sent thru serial port ?
Date: Wed, 6 Jul 2005 17:06:30 +0200
Organization: AS2917
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Thread-Index: AcWCPEpS7mk3jJ76TJ651zTfN4P+ag==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

We have a machine connected to a modem using the serial port, and from
time to time, the modem complains the machine sent him a full 2K buffer
(in fact, 2047 bytes) which were already sent.

We've been investigating at the application level, using strace to 
monitor what is sent to the serial port, and at no time such a buffer is
sent.

This problem is occuring on a random basis, and attempts to reproduce
it in a test environment failed to date.

Is it possible to '(log|copy|...)' the chars that are sent on the
serial port to some other place (without altering too much the performance
of the machine, we are running the port a 9600bps), at the lowest level ?

Or is there a known issue of the serial port (or tty) buffer being 
resent on the line in some weird conditions ? Any change done on 
->head and ->tail handling that could fix that ?

This problem is with Linux 2.4.27 (I know 2.4.31 is out, but nothing 
related to that is present in the Changelog)

Regards,
Paul

Paul Rolland, rol(at)as2917.net
ex-AS2917 Network administrator and Peering Coordinator

--

Please no HTML, I'm not a browser - Pas d'HTML, je ne suis pas un navigateur
"Some people dream of success... while others wake up and work hard at it" 

"I worry about my child and the Internet all the time, even though she's 
too young to have logged on yet. Here's what I worry about. I worry that 
10 or 15 years from now, she will come to me and say 'Daddy, where were 
you when they took freedom of the press away from the Internet?'"
--Mike Godwin, Electronic Frontier Foundation 
 

