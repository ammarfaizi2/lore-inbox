Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261879AbVFQBb7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261879AbVFQBb7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 21:31:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261884AbVFQBb6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 21:31:58 -0400
Received: from animx.eu.org ([216.98.75.249]:11151 "EHLO animx.eu.org")
	by vger.kernel.org with ESMTP id S261879AbVFQBbo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 21:31:44 -0400
Date: Thu, 16 Jun 2005 21:48:20 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Bug in pcmcia-core
Message-ID: <20050617014820.GA15045@animx.eu.org>
Mail-Followup-To: James Courtier-Dutton <James@superbug.demon.co.uk>,
	linux-kernel@vger.kernel.org
References: <42B1FF2A.2080608@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42B1FF2A.2080608@superbug.demon.co.uk>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Courtier-Dutton wrote:
> I am trying to write a Linux ALSA driver for the Creative Audigy 2 NX
> Notebook PCMCIA card.
> This is a cardbus card, that uses ioports.
> When it is inserted into the laptop, the entry appears in "lspci -vv "
> showing ioports used by the card.
> As soon as my driver uses "outb()" to anything in the address range
> shown in "lspci -vv" , the PC hangs.
> 
> I can only conclude from this that ioport resources are not being
> allocated correctly to the PCMCIA card.
> 
> Can anybody help me track this down. If someone could tell me which
> PCMCIA and PCI registers should be set for it to work, I could then find
> out which pcmcia registers have not been set correctly, and fix the bug.
> 
> It seems that the PCMCIA specification is not open and free, so I cannot
> refer to it in order to fix this myself.

I thought drivers for the cardbus cards were the same as standard PCI cards. 
I know that as far as networking goes, the same driver runs a cardbus 3com
3c575 and the pci 3c905.  Same with netgear's cardbus FA510 and PCI FA310.

I'm not a kernel developer, but this is what I've understood.

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
