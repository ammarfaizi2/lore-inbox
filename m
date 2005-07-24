Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261953AbVGXLk6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261953AbVGXLk6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Jul 2005 07:40:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261948AbVGXLk5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Jul 2005 07:40:57 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:34321 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261949AbVGXLkv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Jul 2005 07:40:51 -0400
Date: Sun, 24 Jul 2005 12:40:40 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Noah Misch <noah@cs.caltech.edu>, linux-pcmcia@lists.infradead.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.13-rc3] pcmcia: pcmcia_request_irq for !IRQ_HANDLE_PRESENT
Message-ID: <20050724124040.C4908@flint.arm.linux.org.uk>
Mail-Followup-To: Noah Misch <noah@cs.caltech.edu>,
	linux-pcmcia@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20050717035124.GC13529@orchestra.cs.caltech.edu> <20050723201113.GA12537@dominikbrodowski.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050723201113.GA12537@dominikbrodowski.de>; from linux@dominikbrodowski.net on Sat, Jul 23, 2005 at 10:11:13PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 23, 2005 at 10:11:13PM +0200, Dominik Brodowski wrote:
> Thanks for the excellent debugging. Your patch seems to work, however it
> might be better to do just this:

This can be racy if two drivers are simultaneously trying to request an
IRQ.  'data' must be unique to different threads if they are to avoid
interfering with each other.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
