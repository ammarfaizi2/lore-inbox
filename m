Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265288AbUFAVBP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265288AbUFAVBP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 17:01:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265261AbUFAVBO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 17:01:14 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:26123 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S265288AbUFAVA6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 17:00:58 -0400
Date: Tue, 1 Jun 2004 22:00:52 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Paul Fulghum <paulkf@microgate.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.6 synclink_cs.c
Message-ID: <20040601220051.G31301@flint.arm.linux.org.uk>
Mail-Followup-To: Paul Fulghum <paulkf@microgate.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040527174509.GA1654@quadpro.stupendous.org> <1085769769.2106.23.camel@deimos.microgate.com> <20040528160612.306c22ab.akpm@osdl.org> <1086123182.2171.15.camel@deimos.microgate.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1086123182.2171.15.camel@deimos.microgate.com>; from paulkf@microgate.com on Tue, Jun 01, 2004 at 03:53:02PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 01, 2004 at 03:53:02PM -0500, Paul Fulghum wrote:
> Patch to drivers/char/pcmcia/synclink_cs.c against 2.6.6
> to cleanup properly on errors during
> driver initialization.

To put my PCMCIA hat on, are you sure you should be registering with
a subsystem which can cause you to create tty devices before you've
registered with the tty subsystem?

Eg, what could happen if you register with PCMCIA, PCMCIA hands you
a card to drive and register a tty for, and you do all of that
_before_ you've registered with the tty subsystem?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
