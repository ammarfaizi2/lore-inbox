Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265883AbTGDJFz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jul 2003 05:05:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265888AbTGDJFz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jul 2003 05:05:55 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:47882 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S265883AbTGDJFy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jul 2003 05:05:54 -0400
Date: Fri, 4 Jul 2003 10:20:18 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.21 and 2.5.74 freeze on cardmgr start
Message-ID: <20030704102018.A4374@flint.arm.linux.org.uk>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20030704090329.GA1975@wiggy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030704090329.GA1975@wiggy.net>; from wichert@wiggy.net on Fri, Jul 04, 2003 at 11:03:29AM +0200
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 04, 2003 at 11:03:29AM +0200, Wichert Akkerman wrote:
> When I start cardmgr I see log messages for IO port probes and than the
> machine is completely frozen:
> 
> Starting PCMCIA services: cardmgr[309]: watching 2 sockets
> cs: IO port probe 0x0c00-0x0cff: clean
> cs: IO probt probe 0x0800-0x08ff:

Can you look in your /etc/pcmcia/config.opts and comment out/exclude
this IO range please?

My guess is that you have some hardware in that range which is taking
offense to pcmcia probing it.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

