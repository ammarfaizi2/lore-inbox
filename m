Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284334AbRLXCZA>; Sun, 23 Dec 2001 21:25:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284335AbRLXCYu>; Sun, 23 Dec 2001 21:24:50 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:61457 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S284334AbRLXCYf>; Sun, 23 Dec 2001 21:24:35 -0500
Subject: Re: Total system lockup with Alt-SysRQ-L
To: rmk@arm.linux.org.uk (Russell King)
Date: Mon, 24 Dec 2001 02:34:20 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011223175846.B27993@flint.arm.linux.org.uk> from "Russell King" at Dec 23, 2001 05:58:46 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16IKwX-0002U3-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> When pid1 exits (maybe due to a kill signal), we lockup hard in (iirc)
> exit_notify.  I don't remember the details I'm afraid.

pid1 ends up trying to kill pid1 and it goes deeply down the toilet from
that point onwards. The Unix traditional world reboots when pid 1 dies.
