Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267403AbUIFCNa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267403AbUIFCNa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 22:13:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267404AbUIFCNa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 22:13:30 -0400
Received: from rproxy.gmail.com ([64.233.170.193]:27711 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S267403AbUIFCN2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 22:13:28 -0400
Message-ID: <9e473391040905191384ace49@mail.gmail.com>
Date: Sun, 5 Sep 2004 22:13:28 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Intel ICH - sound/pci/intel8x0.c
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jaroslav Kysela <perex@suse.cz>
In-Reply-To: <1094417386.1911.0.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20040905184852.GA25431@linux.ensimag.fr>
	 <9e47339104090514244873fd05@mail.gmail.com>
	 <1094417386.1911.0.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 05 Sep 2004 21:49:50 +0100, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> Nobody else currently needs to attach to it so why make life needlessly
> complicated.

I just read the relevant parts of the ICH manual. This driver is
definitely misnamed. It should be called an "LPC bridge" driver and
moved out of the sound directory. The config words that it is using
control the joystick and midi, but they also control the floppy,
parallel port, serial ports, MSS, SB16, USB, SMbus, IDE, etc.

Shouldn't the BIOS have set these up correctly, does the driver really
need to mess with them?

I also don't see how this is related to hotplug. Just because a LPC
bridge is plugged in doesn't mean that I should immediatle enable
joystick/midi ports, what if I already have those ports on a different
device?

-- 
Jon Smirl
jonsmirl@gmail.com
