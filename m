Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131059AbRCGNRm>; Wed, 7 Mar 2001 08:17:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131060AbRCGNRc>; Wed, 7 Mar 2001 08:17:32 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:4358 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131059AbRCGNR0>; Wed, 7 Mar 2001 08:17:26 -0500
Subject: Re: spinlock help
To: shmulik.hen@intel.com (Hen, Shmulik)
Date: Wed, 7 Mar 2001 13:19:06 +0000 (GMT)
Cc: manojs@sasken.com ('Manoj Sontakke'), shmulik.hen@intel.com (Hen Shmulik),
        nigel@nrg.org ('nigel@nrg.org'), linux-kernel@vger.kernel.org
In-Reply-To: <07E6E3B8C072D211AC4100A0C9C5758302B27153@hasmsx52.iil.intel.com> from "Hen, Shmulik" at Mar 07, 2001 02:44:30 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14adqP-0000zL-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> spin_lock_bh() won't block interrupts and we need them blocked to prevent
> more indications.
> spin_lock_irq() could do the trick but it's counterpart spin_unlock_irq()
> enables all interrupts by calling sti(), and this is even worse for us.

Why dont you queue your indications then. The eepro100 driver doesnt end up
with large locked sections so its obviously possible to handle it sanely

