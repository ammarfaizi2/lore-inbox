Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265852AbUAKMA6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 07:00:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265860AbUAKMA6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 07:00:58 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:10508 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S265852AbUAKMA4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 07:00:56 -0500
Date: Sun, 11 Jan 2004 12:00:53 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: martin f krafft <madduck@madduck.net>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: kernel 2.6: can't get 3c575/PCMCIA working - other PCMCIA card work
Message-ID: <20040111120053.C1931@flint.arm.linux.org.uk>
Mail-Followup-To: martin f krafft <madduck@madduck.net>,
	linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <20040106111939.GA2046@piper.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040106111939.GA2046@piper.madduck.net>; from madduck@madduck.net on Tue, Jan 06, 2004 at 12:19:39PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 06, 2004 at 12:19:39PM +0100, martin f krafft wrote:
> I have an ancient laptop with a yenta_socket PCMCIA bridge and three
> cards, each with Hinds' pcmcia-cs driver indicated:
> 
>   Orinico Wireless LAN (wvlan_cs)
>   3COM 3c575 (3c575_cs)
>   Psion Gold Card Modem (serial_cs)

What is 3c575_cs ?  I think you actually mean 3c574_cs.  Or maybe you
mean you have a 3com 3ccfe575 Cardbus card?  The above is rather too
ambiguous.

> However, the 3c575 card won't be recognised. All
> I get from the hotplug system is:
> 
>   pci.agent: ... no modules for PCI slot 0000:06:00.0

This indicates that the card you inserted is a Cardbus card.  In which
case, the PCMCIA driver "3c574_cs" is definitely not what you want.
You want to use the 3c59x driver, though the hotplug subsystem should
automatically pick that up from the PCI ids.

Could you insert the card, and then provide the output of lspci -vx ?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
