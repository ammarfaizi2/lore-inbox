Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129478AbRCABeY>; Wed, 28 Feb 2001 20:34:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129498AbRCAB2h>; Wed, 28 Feb 2001 20:28:37 -0500
Received: from zeus.kernel.org ([209.10.41.242]:51676 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129443AbRCAB2U>;
	Wed, 28 Feb 2001 20:28:20 -0500
Subject: Re: time drift and fb comsole activity
To: cort@fsmlabs.com (Cort Dougan)
Date: Thu, 1 Mar 2001 00:01:01 +0000 (GMT)
Cc: morton@nortelnetworks.com (Andrew Morton), ebuddington@wesleyan.edu,
        linux-kernel@vger.kernel.org
In-Reply-To: <20010228165026.K28471@ftsoj.fsmlabs.com> from "Cort Dougan" at Feb 28, 2001 04:50:26 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14YGWo-0006nP-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> We have the same trouble on PPC but we make sure to re-sync on each
> interrupt.  We can see several lost timer interrupts after a ^L in emacs
> running on the fb console.  The resync lets us catch up on those interrupts
> (and not lose time) but we still spend a lot of time not servicing
> interrupts.
> Does x86 not resync on timer interrupts?

The fbdev console problem is too horrible to pretend to solve by resyncing
on timer interrupts. At least for the x86 the fix is to sort out the fb
locking properly

