Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319649AbSIMNzd>; Fri, 13 Sep 2002 09:55:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319647AbSIMNzd>; Fri, 13 Sep 2002 09:55:33 -0400
Received: from copper.ftech.net ([212.32.16.118]:56003 "EHLO relay5.ftech.net")
	by vger.kernel.org with ESMTP id <S319589AbSIMNzc>;
	Fri, 13 Sep 2002 09:55:32 -0400
Message-ID: <7C078C66B7752B438B88E11E5E20E72E0EF512@GENERAL.farsite.co.uk>
From: Kevin Curtis <kevin.curtis@farsite.co.uk>
To: linux-newbie@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Preventing signal interrupt in Kernel module code
Date: Fri, 13 Sep 2002 14:54:19 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
	I have written a Kernel module and I'm having a small problem with
signals that I hope someone can steer me through.  The signal in question
are SIGCHILD, but that is not really relevant.  I must be able to handle any
signal that the process has enabled.

	My module has several wait queues, most of which I can cope with
being interrupted by a signal (returning EINTR to the process).  However,
there are some hardware operations that I need to wait for completion of, as
it would be impossible to restart them or pick up where we left off.  I
still want to use a wait queue so other things can run.  Is there some
system call I can make to mask signals until the operation has completed.
Would I still call signal_pending() to see if one had occurred while they
were blocked?

I'm sure the answer is really simple but I haven't stumbled across it yet.

TIA

Kevin
