Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269181AbUIRKnP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269181AbUIRKnP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Sep 2004 06:43:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269218AbUIRKnP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Sep 2004 06:43:15 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:26384 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S269181AbUIRKnN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Sep 2004 06:43:13 -0400
Date: Sat, 18 Sep 2004 11:43:10 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] MMC compatibility fix - OCR mask
Message-ID: <20040918114310.A13733@flint.arm.linux.org.uk>
Mail-Followup-To: Pierre Ossman <drzeus-list@drzeus.cx>,
	linux-kernel@vger.kernel.org
References: <414C0730.3020503@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <414C0730.3020503@drzeus.cx>; from drzeus-list@drzeus.cx on Sat, Sep 18, 2004 at 12:00:16PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 18, 2004 at 12:00:16PM +0200, Pierre Ossman wrote:
> This patch avoids using a emtpy OCR mask for the initial power up. Since 
> some cards do not like a one bit-mask a routine has been added which 
> grows the mask to three bits (one extra bit on each side) if necessary.

As I already replied on this topic, this will not work on hosts
which support a wide range of supplies.  If you send an OP_COND
command with bits set outside the MMC cards allowable range, they
go gaga.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
