Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268999AbUINFZ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268999AbUINFZ2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 01:25:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269014AbUINFZ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 01:25:28 -0400
Received: from ps11.kent.dot.net.au ([202.147.78.203]:11225 "EHLO
	ps11.kent.dot.net.au") by vger.kernel.org with ESMTP
	id S268999AbUINFZ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 01:25:27 -0400
From: James Roper <u3205097@anu.edu.au>
To: linux-kernel@vger.kernel.org
Subject: Kernel semaphores
Date: Tue, 14 Sep 2004 15:25:24 +1000
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200409141525.24296.u3205097@anu.edu.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm very new to kernel development.  I'm implementing a mechanism in the CIFS 
VFS client to ensure that the maximum number of outstanding requests is not 
exceeded.  To do this I'm using a semaphore.  It works for a while, but 
eventually (while doing some torture tests that send/receive many > 10MB 
files simultaneously by multiple threads) my computer freezes.  The logs show 
the message "bad: scheduling while atomic!" followed by a trace.  I'm 
guessing this is where the problem is.  So my question is, if my semaphore is 
causing that error, what possible things could be triggering it?  Could it be 
an interrupt while waiting to acquire the semaphore?  I'm using the 
down_interruptible() to acquire and up() to release.

Thanks,

James
