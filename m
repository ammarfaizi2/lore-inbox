Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293187AbSDMS2B>; Sat, 13 Apr 2002 14:28:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293196AbSDMS2A>; Sat, 13 Apr 2002 14:28:00 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:45574 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S293187AbSDMS17>; Sat, 13 Apr 2002 14:27:59 -0400
Subject: Re: BUG: 2.4.19pre1 & journal_thread & open filehandles
To: marek@bmlv.gv.at (Ph. Marek)
Date: Sat, 13 Apr 2002 19:45:36 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3.0.6.32.20020412121109.0090fd80@pop3.bmlv.gv.at> from "Ph. Marek" at Apr 12, 2002 12:11:09 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16wSWm-0000rD-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I think I have discovered a bug in the way the kernel journal thread is
> created.
> I tested with ext3 but believe that every fs using jbd has this bug.

It should be sufficient to use daemonize() and reparent_to_init() to hand
off the inherited handles

