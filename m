Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262949AbUCSNQN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 08:16:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262938AbUCSNQN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 08:16:13 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:45328 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262951AbUCSNQM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 08:16:12 -0500
Date: Fri, 19 Mar 2004 13:16:08 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Jamie Lokier <jamie@shareable.org>
Cc: Robert_Hentosh@Dell.com, linux-kernel@vger.kernel.org
Subject: Re: spurious 8259A interrupt
Message-ID: <20040319131608.A14431@flint.arm.linux.org.uk>
Mail-Followup-To: Jamie Lokier <jamie@shareable.org>,
	Robert_Hentosh@Dell.com, linux-kernel@vger.kernel.org
References: <6C07122052CB7749A391B01A4C66D31E014BEA49@ausx2kmps304.aus.amer.dell.com> <20040319130609.GE2650@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040319130609.GE2650@mail.shareable.org>; from jamie@shareable.org on Fri, Mar 19, 2004 at 01:06:10PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 19, 2004 at 01:06:10PM +0000, Jamie Lokier wrote:
> For those rare occasions when an interrupt handler wants to re-enable
> interrupts (sti), _then_ it could mask the interrupt that called the handler.

Interrupt handlers generally run with the CPU interrupt disable flag
cleared, so other interrupts can be serviced.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
