Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129308AbQJ3RTp>; Mon, 30 Oct 2000 12:19:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129374AbQJ3RTf>; Mon, 30 Oct 2000 12:19:35 -0500
Received: from mail.intrex.net ([209.42.192.246]:57870 "EHLO intrex.net")
	by vger.kernel.org with ESMTP id <S129128AbQJ3RT0>;
	Mon, 30 Oct 2000 12:19:26 -0500
Message-ID: <39FDAE74.2AED0C74@bktech.com>
Date: Mon, 30 Oct 2000 12:23:00 -0500
From: Brett Smith <brett.smith@bktech.com>
Organization: B & K Technology, Inc.
X-Mailer: Mozilla 4.7 [en] (Win98; I)
X-Accept-Language: en
MIME-Version: 1.0
To: linux kernel <linux-kernel@vger.kernel.org>
Subject: installing an ISR from user code
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


We have written a char driver for our proprietary h/w.  This driver
handles a
multitude of interrupts from the h/w in the following fashion:  The ISR
reads/saves the status register (indication of which int was hit) in
global, and the marks the BH to run.  The BH uses the global to call one
of 32 "ISRs" (an array of func ptrs).  I would like to be able to
install an "ISR" dynamically from user code (the module has already been
installed).  Is this possible?

If it is possible, how does the build/link work?

thanks,
brett.smith@bktech.com


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
