Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261461AbTCOOhY>; Sat, 15 Mar 2003 09:37:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261463AbTCOOhY>; Sat, 15 Mar 2003 09:37:24 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:7 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id <S261461AbTCOOhX>; Sat, 15 Mar 2003 09:37:23 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200303151450.h2FEo1eX001775@81-2-122-30.bradfords.org.uk>
Subject: Re: SCSI errors in logs
To: smpcomputing@free.fr (Philip Dodd)
Date: Sat, 15 Mar 2003 14:50:01 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3E725DA5.4070108@free.fr> from "Philip Dodd" at Mar 14, 2003 11:54:29 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Running debian testing with 2.4.20 + preempt + bttv kernel patches with 
> 1GB of RAM - high memory enabled, I get big bunches of the following in 
> /var/log/messages.
> 
> 
> Mar 14 20:41:08 gandalf kernel: scsi0: Transceiver State Has Changed to 
> SE mode
> Mar 14 20:41:08 gandalf kernel: scsi0: Transceiver State Has Changed to 
> LVD mode
> Mar 14 20:41:08 gandalf kernel: scsi0: Transceiver State Has Changed to 
> SE mode
> Mar 14 20:41:27 gandalf kernel: scsi0: Transceiver State Has Changed to 
> LVD mode
> 
> On several occasions my logs have been filled with theses messages. 
> Adaptec driver is compiled in the kernel, and scsi0 is unused (scsi1 is 
> the other channel on my adaptec 39160, scsi2 is ide-scsi).  Nothing is 
> physically plugged in to this channel (yet!).
> 
> I'd be grateful for any ideas - is this hardware?

Plug a device in to it, make sure it's properly terminated, and it
should work :-).

I suspect that the SE/LVD negotiation is confused, because there are
no devices on the bus.

John.
