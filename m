Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265062AbRFURdC>; Thu, 21 Jun 2001 13:33:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265063AbRFURcw>; Thu, 21 Jun 2001 13:32:52 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:46866 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S265062AbRFURci>; Thu, 21 Jun 2001 13:32:38 -0400
Subject: Re: Is it useful to support user level drivers
To: abramo@alsa-project.org (Abramo Bagnara)
Date: Thu, 21 Jun 2001 18:27:14 +0100 (BST)
Cc: D.A.Fedorov@inp.nsk.su, Oliver.Neukum@lrz.uni-muenchen.de (Oliver Neukum),
        balbir_soni@yahoo.com (Balbir Singh), linux-kernel@vger.kernel.org
In-Reply-To: <3B322224.91E17820@alsa-project.org> from "Abramo Bagnara" at Jun 21, 2001 06:34:44 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15D8Ec-0001lL-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> (i.e. counted). An alternative to queuing (user selectable) is to block
> interrupt generation at hardware level in kernel space immediately
> before notification.
> 
> I'm missing something?

IRQ 9 shared between user space app and disk. IRQ arrives is disabled and
reported, app wakes up, app wants to page in code, IRQ is disabled, box dies

You have to handle that in kernel space, at least enough to handle the
irq event, ack it and queue the data


