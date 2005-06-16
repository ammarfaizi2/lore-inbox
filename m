Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261665AbVFPOzt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261665AbVFPOzt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 10:55:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261669AbVFPOzt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 10:55:49 -0400
Received: from anchor-post-34.mail.demon.net ([194.217.242.92]:8979 "EHLO
	anchor-post-34.mail.demon.net") by vger.kernel.org with ESMTP
	id S261665AbVFPOzl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 10:55:41 -0400
Message-ID: <42B192E9.40903@superbug.co.uk>
Date: Thu, 16 Jun 2005 15:55:37 +0100
From: James Courtier-Dutton <James@superbug.co.uk>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Bug in pcmcia-core
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have tried conacting the mailing list for the PCMCIA subsystem in 
Linux, but no-one seems to respond.

PCMCIA SUBSYSTEM
L:      http://lists.infradead.org/mailman/listinfo/linux-pcmcia
S:      Unmaintained

I am trying to write a Linux ALSA driver for the Creative Audigy 2 NX 
Notebook PCMCIA card.
This is a cardbus card, that uses ioports.
When it is inserted into the laptop, the entry appears in "lspci -vv " 
showing ioports used by the card.
As soon as my driver uses "outb()" to anything in the address range 
shown in "lspci -vv" , the PC hangs.

I can only conclude from this that ioport resources are not being 
allocated correctly to the PCMCIA card.

Can anybody help me track this down. If someone could tell me which 
PCMCIA and PCI registers should be set for it to work, I could then find 
out which pcmcia registers have not been set correctly, and fix the bug.

It seems that the PCMCIA specification is not open and free, so I cannot 
refer to it in order to fix this myself.

Can anybody help me?

James

