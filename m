Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264685AbUHGXaY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264685AbUHGXaY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 19:30:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264085AbUHGXaX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 19:30:23 -0400
Received: from the-village.bc.nu ([81.2.110.252]:40900 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S264685AbUHGX32 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 19:29:28 -0400
Subject: Re: ide-cs using 100% CPU
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Hamie <hamish@travellingkiwi.com>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <4113DD20.1010808@travellingkiwi.com>
References: <40FA4328.4060304@travellingkiwi.com>
	 <20040806202747.H13948@flint.arm.linux.org.uk>
	 <4113DD20.1010808@travellingkiwi.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1091917597.19077.38.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 07 Aug 2004 23:26:38 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-08-06 at 20:33, Hamie wrote:
> Is 100% CPU not excessive? IIRC my PIII-750 used to use less CPU doing 
> the same job as quick, or even slightly faster...

PCMCIA IDE is PIO only so it burns CPU. This is one case where
hyperthreading is nice. Cardbus IDE is a lot better but very little
exists and we don't currently support hotplug IDE controllers.

> And should it not use system CPU rather than user CPU?

Yes - but figure out please if the kernel or userspace is getting that
wrong ;)

Alan

