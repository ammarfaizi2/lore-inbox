Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265965AbTGDKRb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jul 2003 06:17:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265966AbTGDKRb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jul 2003 06:17:31 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:1036 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S265965AbTGDKRa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jul 2003 06:17:30 -0400
Date: Fri, 4 Jul 2003 11:31:56 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.21 and 2.5.74 freeze on cardmgr start
Message-ID: <20030704113156.E4374@flint.arm.linux.org.uk>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20030704090329.GA1975@wiggy.net> <20030704102018.A4374@flint.arm.linux.org.uk> <20030704093732.GA2159@wiggy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030704093732.GA2159@wiggy.net>; from wichert@wiggy.net on Fri, Jul 04, 2003 at 11:37:32AM +0200
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 04, 2003 at 11:37:32AM +0200, Wichert Akkerman wrote:
> Previously Russell King wrote:
> > Can you look in your /etc/pcmcia/config.opts and comment out/exclude
> > this IO range please?
> 
> That improves things a lot. I wonder why it decided I have 2 sockets;
> is that a general PCMCIA thing? This laptop only has a single PCMCIA
> socket, the second slot has a smartcard reader.

Ok, after discussing the problem with Arjan, can you try adding back
the 0x804 to 0x8ff io port range?  Arjan thinks there may be a SMM
port at 0x800 causing your grief.  If this is the case, we can then
add it to the pci quirks.

Thanks.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

