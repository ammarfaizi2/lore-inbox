Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266725AbUIVTPq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266725AbUIVTPq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 15:15:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266749AbUIVTPq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 15:15:46 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:54023 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S266725AbUIVTPo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 15:15:44 -0400
Date: Wed, 22 Sep 2004 20:15:41 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] MMC compatibility fix - GO_IDLE
Message-ID: <20040922201541.G2347@flint.arm.linux.org.uk>
Mail-Followup-To: Pierre Ossman <drzeus-list@drzeus.cx>,
	linux-kernel@vger.kernel.org
References: <414C065A.7000602@drzeus.cx> <20040922151735.D2347@flint.arm.linux.org.uk> <4151BA3F.8040406@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <4151BA3F.8040406@drzeus.cx>; from drzeus-list@drzeus.cx on Wed, Sep 22, 2004 at 07:45:35PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 22, 2004 at 07:45:35PM +0200, Pierre Ossman wrote:
> Russell King wrote:
> >How about this patch?
>
> Looks ok. You sure we don't need to put all cards into an idle state 
> before issuing a new SEND_OP_COND?

We aren't sending that to the existing cards - they are still in
whatever state they were when they were previously detected.  In
addition, we aren't actually changing or detecting the operational
conditions, we're merely informing the new cards about the existing
setup.

> Can a rescan be done while a card is in a selected state?

Yes - any cards not already in idle state will ignore the command
as intended.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
