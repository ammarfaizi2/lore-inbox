Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272064AbTHFTek (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 15:34:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271751AbTHFTdY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 15:33:24 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:54024 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S270995AbTHFTcV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 15:32:21 -0400
Date: Wed, 6 Aug 2003 20:32:17 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Pavel Roskin <proski@gnu.org>
Cc: linux-pcmcia <linux-pcmcia@lists.infradead.org>,
       Daniel Ritz <daniel.ritz@gmx.ch>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6] ToPIC specific init for yenta_socket
Message-ID: <20030806203217.F16116@flint.arm.linux.org.uk>
Mail-Followup-To: Pavel Roskin <proski@gnu.org>,
	linux-pcmcia <linux-pcmcia@lists.infradead.org>,
	Daniel Ritz <daniel.ritz@gmx.ch>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <200308062025.08861.daniel.ritz@gmx.ch> <20030806194430.D16116@flint.arm.linux.org.uk> <Pine.LNX.4.56.0308061452310.3849@marabou.research.att.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.56.0308061452310.3849@marabou.research.att.com>; from proski@gnu.org on Wed, Aug 06, 2003 at 03:07:21PM -0400
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 06, 2003 at 03:07:21PM -0400, Pavel Roskin wrote:
> I read the PCMCIA list, but not LKML, and I have no idea what problems you
> are talking about.  Could you please explain of give a pointer to a
> previous post?  I could cross-check the problem against plx9052 driver.

It's fairly complex.  Let's just summerise it as "yenta texas instruments
IRQ routing fucked up" 8)  The chip has a bunch of registers to control
what signals get routed to which physical pins, and it seems that between
June 2002 and today, some bad changes happened.  I'm currently trying to
track down each one, but, as there have been several levels of patching
going on, it isn't simple.

> The same is done for TI and Ricoh bridges.  Just search the sources for
> "socket->socket.ops->init".  You may have a good reason to be unhappy, but
> coherent code is normally easier to fix than a bunch of different hacks.

Yep, and I'm going to fix them as part of my present work.

Think about what happens to ->init with the current system when you
have two different cardbus controllers in the same machine.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

