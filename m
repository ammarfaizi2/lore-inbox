Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262674AbTI1SpW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 14:45:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262675AbTI1SpV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 14:45:21 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:62735 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262674AbTI1SpP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 14:45:15 -0400
Date: Sun, 28 Sep 2003 19:45:11 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Roman Zippel <zippel@linux-m68k.org>
Subject: Re: CONFIG_I8042
Message-ID: <20030928194511.C1428@flint.arm.linux.org.uk>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Linux Kernel List <linux-kernel@vger.kernel.org>,
	Roman Zippel <zippel@linux-m68k.org>
References: <20030928161059.B1428@flint.arm.linux.org.uk> <Pine.LNX.4.44.0309281136141.15408-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0309281136141.15408-100000@home.osdl.org>; from torvalds@osdl.org on Sun, Sep 28, 2003 at 11:37:18AM -0700
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 28, 2003 at 11:37:18AM -0700, Linus Torvalds wrote:
> On Sun, 28 Sep 2003, Russell King wrote:
> > If we have an AT Keyboard, that does _NOT_ mean that we have an I8042.
> 
> Well, it does require us to have at least SERIO. Also, we need to have 
> some way to make sure that I8042 does get selected on a PC.
>
> Apart from that, it doesn't matter how it's solved..

It appears that "select" doesn't accept conditionals as the kconfig
language stands - jejb also ran into this issue, and tried various
ways around.  The only solution which seems to work is to remove this
select line entirely.

Maybe RZ can comment further.

(Problem Summary: several architectures need to be able to select
KEYBOARD_ATKBD without automatically selecting I8042.)

-- 
Russell King (rmk@arm.linux.org.uk)	http://www.arm.linux.org.uk/personal/
      Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
      maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                      2.6 Serial core
