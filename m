Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264083AbTIIM2Z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 08:28:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264091AbTIIM2Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 08:28:25 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:26899 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264083AbTIIM2X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 08:28:23 -0400
Date: Tue, 9 Sep 2003 13:28:09 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.0-test5: CONFIG_PCMCIA_WL3501 build fails
Message-ID: <20030909132809.B4216@flint.arm.linux.org.uk>
Mail-Followup-To: Eyal Lebedinsky <eyal@eyal.emu.id.au>,
	Linus Torvalds <torvalds@osdl.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0309081319380.1666-100000@home.osdl.org> <3F5DC39B.39F16803@eyal.emu.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3F5DC39B.39F16803@eyal.emu.id.au>; from eyal@eyal.emu.id.au on Tue, Sep 09, 2003 at 10:12:11PM +1000
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 09, 2003 at 10:12:11PM +1000, Eyal Lebedinsky wrote:
> allmodconfig, i386:
> 
>   CC [M]  drivers/net/wireless/wl3501_cs.o
> drivers/net/wireless/wl3501_cs.c: In function `wl3501_mgmt_join':
> drivers/net/wireless/wl3501_cs.c:641: unknown field `id' specified in
> initializer

I notice that this driver uses .foo.bar = baz type initialisers.  These
do not work on gcc 2.95 (and last time I checked, the kernels minimum
compiler version was still 2.95.x)

-- 
Russell King (rmk@arm.linux.org.uk)	http://www.arm.linux.org.uk/personal/
Linux kernel maintainer of:
  2.6 ARM Linux   - http://www.arm.linux.org.uk/
  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
  2.6 Serial core
