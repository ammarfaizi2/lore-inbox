Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261646AbVCRP0J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261646AbVCRP0J (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 10:26:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261642AbVCRPZr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 10:25:47 -0500
Received: from mail-gw0.york.ac.uk ([144.32.128.245]:47558 "EHLO
	mail-gw0.york.ac.uk") by vger.kernel.org with ESMTP id S261639AbVCRPXp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 10:23:45 -0500
Subject: Floppy drive LED
From: Alan Jenkins <aj504@student.cs.york.ac.uk>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Fri, 18 Mar 2005 15:23:37 +0000
Message-Id: <1111159417.6915.6.camel@host-172-19-5-120.sns.york.ac.uk>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
X-York-MailScanner: Found to be clean
X-York-MailScanner-From: aj504@student.cs.york.ac.uk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I compiled my kernel (2.6.11) with the floppy driver as a module - so it
is not loaded on boot.  When the floppy driver is laoded, the LED
behaves as expected.  When I unload it, the LED stays in its current
state.  So if I do this...

# modprobe floppy; sleep 5; dd if=/dev/fd0 count=1 of=/dev/null; rmmod
floppy

...then the LED will be on when the driver is unloaded, so it will stay
that way until the driver is loaded again.

Its not at all important, and its probably known, but it doesn't look
very professional :).  Any thoughts?  Would it be possible to tell
whether the LED is on or not, and wait until its off?

Alan

