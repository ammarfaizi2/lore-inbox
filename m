Return-Path: <linux-kernel-owner+w=401wt.eu-S932422AbXARTGN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932422AbXARTGN (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 14:06:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932437AbXARTGN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 14:06:13 -0500
Received: from wylie.me.uk ([82.68.155.89]:55311 "EHLO mail.wylie.me.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932422AbXARTGN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 14:06:13 -0500
X-Greylist: delayed 1184 seconds by postgrey-1.27 at vger.kernel.org; Thu, 18 Jan 2007 14:06:12 EST
From: alan@wylie.me.uk (Alan J. Wylie)
To: linux-kernel@vger.kernel.org
Cc: "Daniel Gonzalez Schiller" <daniel.schiller@gmail.com>
Subject: Re: kernel 2.6.19 bug report --> "atkbd.c:spurious ACK on isa...." when boot from SATA hd, no way to start system
References: <c951f21e0701180539t623387edh5783abc795ea3c9f@mail.gmail.com>
	<c951f21e0701180542v22ce9ebaw69c36a1b2084daaa@mail.gmail.com>
Date: Thu, 18 Jan 2007 18:46:26 +0000
In-Reply-To: <c951f21e0701180542v22ce9ebaw69c36a1b2084daaa@mail.gmail.com>
	(Daniel Gonzalez Schiller's message of "Thu\, 18 Jan 2007 14\:50\:24
	+0100")
Message-ID: <87hcuoxjel.fsf@devnull.wylie.me.uk>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Jan 2007 14:50:24 +0100, "Daniel Gonzalez Schiller" <daniel.schiller@gmail.com> said:

> When boot with SATA HD --> "atkbd.c:spurious ACK on
> isa0060/serio0. Some program might be trying access hardware
> directly."

> When booting with normal hd no problem.

The problems are almost certainly to do with the driver (or lack of
driver) for your hard disc interface. There will be earlier messages
(and more importantly a lack of messages showing hardware being
detected) that end with failure to mount your root partition.

The configuration options for SATA moved in 2.6.19.

They are now under
  Device Drivers -> 
    Serial ATA (prod) and Parallel ATA (experimental) drivers 

> I've searched in changelog but nothing found.

The error messages are as a result of the keyboard LEDs being flashed.

Have a look at:

http://groups.google.co.uk/group/linux.kernel/msg/197ddf90dd6e5058
http://groups.google.com/group/fa.linux.kernel/msg/660c4d2dc419ee44

Try booting with i8042.panicblink=0

-- 
Alan J. Wylie                                          http://www.wylie.me.uk/
"Perfection [in design] is achieved not when there is nothing left to add,
but rather when there is nothing left to take away."
  -- Antoine de Saint-Exupery
