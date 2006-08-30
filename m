Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751356AbWH3TQd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751356AbWH3TQd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 15:16:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751355AbWH3TQd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 15:16:33 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:25779 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751341AbWH3TQc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 15:16:32 -0400
Subject: Re: Interrupt handler registration for multiple devices
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Rick Brown <rick.brown.3@gmail.com>
Cc: linux-newbie@vger.kernel.org, kernelnewbies@nl.linux.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <7783925d0608300812j2175164dja401b4e763a5ac43@mail.gmail.com>
References: <7783925d0608300812j2175164dja401b4e763a5ac43@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 30 Aug 2006 20:38:35 +0100
Message-Id: <1156966715.6271.211.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-08-30 am 20:42 +0530, ysgrifennodd Rick Brown:
> Hi,
> 
> I want to write a driver that will handle multiple devices. These
> devices will share the IRQ line. Do I need to register my (same)
> interrupt handler as many times as the number of devices(by calling
> request_irq())?

Up to you. If you are working with standard devices that need no special
handling to share interrupts (eg PCI bus), the device model makes it
more natural to do that and let the kernel call your handler once for
each device (passing a different dev_id).


