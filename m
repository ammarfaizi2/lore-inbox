Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274239AbRI3W4v>; Sun, 30 Sep 2001 18:56:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274241AbRI3W4l>; Sun, 30 Sep 2001 18:56:41 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:62472 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S274239AbRI3W4f>; Sun, 30 Sep 2001 18:56:35 -0400
Subject: Re: [PATCH] yet another yenta resource allocation fix
To: lists@mdiehl.de (Martin Diehl)
Date: Mon, 1 Oct 2001 00:00:27 +0100 (BST)
Cc: torvalds@transmeta.com (Linus Torvalds), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0110010001520.746-100000@notebook.diehl.home> from "Martin Diehl" at Oct 01, 2001 12:40:10 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15npZT-0007s7-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm asking for application of a patch I'm using since 2.4.0. Issue was the
> BIOS of my OB-800 mapped the memory regions of the cardbus bridges into
> legacy 1M-area (0xe6000 e.g.). Despite being pretty bogus this used to
> work after a reboot just until the first pm-suspend/resume, where the
> hostbridge somehow looses access to this area.

At a guess your bios doesnt restore the shadow ram disables right.

> Following your suggestion, I've modified pci_socket.c to detect and fix
> the wrong mapping. However, I'm not sure whether there is some general
> rule if such fixes should be considered cardbus-specific or general
> pci-quirks.

Would a generic

	pci_fixup_device()

type function not be more appropriate
