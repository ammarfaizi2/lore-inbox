Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274299AbRJAAaY>; Sun, 30 Sep 2001 20:30:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274305AbRJAAaO>; Sun, 30 Sep 2001 20:30:14 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:37641 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S274299AbRJAAaH>; Sun, 30 Sep 2001 20:30:07 -0400
Subject: Re: PNPBios & lm_sensors don't mix on 440GX w/2.4.9-ac18
To: sduchene@mindspring.com
Date: Mon, 1 Oct 2001 01:35:32 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010930194909.Y14910@lapsony.mydomain.here> from "sduchene@mindspring.com" at Sep 30, 2001 07:49:09 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15nr3U-00085h-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Today I updated a system with a Intel 440GX (Lancewood) motherboard to 2.4.9-ac18
> and normally I have PNP support turned on. Later I updated to the current i2c and
> lm_sensors code and discovered that the PNPBios support allocates IO port 0x1040.
> Since the i2c-piix4 wants to use the same port range, this module would not load
> on the system. A modprobe of i2c-piix4 resulted in:

Yep. I know. The Pnpbios code needs fixing to allocate the regions as
present but unused - so we dont map pci crap over them but at the same
time we dont stop drivers allocating it.

Its a bug.

Alan
