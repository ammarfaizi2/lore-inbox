Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261771AbRFBWFg>; Sat, 2 Jun 2001 18:05:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261783AbRFBWF0>; Sat, 2 Jun 2001 18:05:26 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:4625 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S261771AbRFBWFQ>; Sat, 2 Jun 2001 18:05:16 -0400
Subject: Re: Reading from /dev/fb0 very slow?
To: pavel@suse.cz (Pavel Machek)
Date: Sat, 2 Jun 2001 23:03:24 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (kernel list)
In-Reply-To: <20010602105249.A979@bug.ucw.cz> from "Pavel Machek" at Jun 02, 2001 10:52:49 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E156JUS-0002DC-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I did some benchmarks, and my framebuffer is *way* faster when writing
> than when reading:

That is quite normal.

> That is 6 times slower! This is also very visible in X, where moving
> regions is expensive, while just drawing regions is fast. For example
> gnome-terminal is *way* faster *with* transparent background option.
> 
> Any idea why such assymetry? [This is toshiba 4030cdt with vesafb and
> 2.4.5]

Writes to a PCI device can be queued or posted. Reads from a PCI device for
obvious reasons have to stall the CPU until the data returns. 

