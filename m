Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270472AbTHETqQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 15:46:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270534AbTHETqQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 15:46:16 -0400
Received: from mauve.demon.co.uk ([158.152.209.66]:41130 "EHLO
	mauve.demon.co.uk") by vger.kernel.org with ESMTP id S270472AbTHETqP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 15:46:15 -0400
From: root@mauve.demon.co.uk
Message-Id: <200308051946.UAA24947@mauve.demon.co.uk>
Subject: Re: 2.6.0-test2 pegasus USB ethernet system lockup.
To: greg@kroah.com (Greg KH)
Date: Tue, 5 Aug 2003 20:46:22 +0100 (BST)
Cc: root@mauve.demon.co.uk, linux-kernel@vger.kernel.org
In-Reply-To: <20030803041144.GA18501@kroah.com> from "Greg KH" at Aug 02, 2003 09:11:44 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> On Sun, Aug 03, 2003 at 01:22:07AM +0100, root@mauve.demon.co.uk wrote:
> > Occasionally I also get 
> > Aug  1 01:47:37 mauve kernel: Debug: sleeping function called from invalid context at drivers/usb/core/hcd.c:1350
> 
> This is fixed in Linus's tree.
> 
> > I am unable to say if lights are flashing on the keyboard, as there are 
> > no lights on the keyboard.
> 
> Can you use a serial debug console and/or the nmi watchdog to see if you
> can capture where things went wrong?


I have not gotten any results from nmi watchdog (unable to get it working)
or serial console (I have found that the kernel has stopped responding to
DMA requests, as a sound playing at the time just loops at the size of the
DMA buffer).

However, I have found another way to trigger it.
Simply 
rmmod pegasus
while there is a configured interface on it, will cause the exact same
symptoms.

I intend to try various kernel versions when I can.

