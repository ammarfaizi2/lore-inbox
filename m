Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269104AbUJQM1O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269104AbUJQM1O (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 08:27:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269105AbUJQM1O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 08:27:14 -0400
Received: from a26.t1.student.liu.se ([130.236.221.26]:64929 "EHLO
	mail.drzeus.cx") by vger.kernel.org with ESMTP id S269104AbUJQM1N
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 08:27:13 -0400
Message-ID: <4172651A.3010406@drzeus.cx>
Date: Sun, 17 Oct 2004 14:27:06 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040919)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: IO-APIC missing interrupts
X-Enigmail-Version: 0.84.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm having some problems with the IO-APIC on a Acer Aspire 1501LMI 
laptop (AMD64). When the IO-APIC is enabled it misses some interrupts. 
Using noapic makes everything work fine.

The problem appears during fifo transfers when interrupts are frequent. 
My guess is that if a new interrupt is signaled while still in the 
interrupt handler, the new interrupt gets ignored.

The device in question is a LPC/ISA device.

Are there perhaps some special commands that need to be executed by the 
driver when on an APIC system?

Rgds
Pierre
