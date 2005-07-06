Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262497AbVGFXq4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262497AbVGFXq4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 19:46:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262493AbVGFUHn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 16:07:43 -0400
Received: from tag.witbe.net ([81.88.96.48]:401 "EHLO tag.witbe.net")
	by vger.kernel.org with ESMTP id S262465AbVGFSgg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 14:36:36 -0400
Message-Id: <200507061836.j66IaWD27125@tag.witbe.net>
Reply-To: <rol@as2917.net>
From: "Paul Rolland" <rol@as2917.net>
To: <linux-kernel@vger.kernel.org>
Cc: <rol@as2917.net>
Subject: Spy'ing characters sent to serial port.
Date: Wed, 6 Jul 2005 20:36:32 +0200
Organization: AS2917
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Thread-Index: AcWCWaGEKSLPIe2NSZuIDBdWjyoVMQ==
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

