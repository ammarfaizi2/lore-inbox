Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161130AbWJPGe1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161130AbWJPGe1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 02:34:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161193AbWJPGe1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 02:34:27 -0400
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:57232 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S1161130AbWJPGe0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 02:34:26 -0400
Message-ID: <453327EC.1000402@drzeus.cx>
Date: Mon, 16 Oct 2006 08:34:20 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.7 (X11/20061004)
MIME-Version: 1.0
To: Timo Teras <timo.teras@solidboot.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MMC: Select only one voltage bit in OCR response
References: <20061009150044.GB1637@mail.solidboot.com> <20061009165317.GA6431@flint.arm.linux.org.uk> <20061009172350.GC1637@mail.solidboot.com>
In-Reply-To: <20061009172350.GC1637@mail.solidboot.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timo Teras wrote:
> I see. But if we do send an OCR with an unsupported bit set, the card will
> go to inactive state and is unusable. This problem is masked on controllers
> with only 3.3V support, but I'm working with a controller supporting several
> different voltages.
>
> For example, I have a card giving an OCR reply of 0x0ff80080. The current
> code will reply to this with 0x00000180 which is clearly incorrect.
>
> Maybe something like "ocr &= 3 << bit;" would be more approriate?
>   

Russell? Comments? Do you still have the offending card?

-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org
  OLPC, developer                     http://www.laptop.org

