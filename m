Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264917AbRFULF1>; Thu, 21 Jun 2001 07:05:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264918AbRFULFR>; Thu, 21 Jun 2001 07:05:17 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:12303 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S264917AbRFULFL>; Thu, 21 Jun 2001 07:05:11 -0400
Subject: Re: Is it useful to support user level drivers
To: balbir_soni@yahoo.com (Balbir Singh)
Date: Thu, 21 Jun 2001 12:04:34 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010621104132.91801.qmail@web13609.mail.yahoo.com> from "Balbir Singh" at Jun 21, 2001 03:41:32 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15D2GI-00019a-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> level drivers (via ioperm, etc). However interrupts
> at user level are not supported, does anyone think
> it would be a good idea to add user level interrupt
> support ? I have a framework for it, but it still
> needs
> a lot of work.

The problem is that the IRQ has to be cleared in kernel space, because otherwise
you may deadlock. 

