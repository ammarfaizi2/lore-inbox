Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964915AbWBAJ3w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964915AbWBAJ3w (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 04:29:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964902AbWBAJ3w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 04:29:52 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:31757 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S964824AbWBAJ3u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 04:29:50 -0500
Date: Wed, 1 Feb 2006 09:29:34 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Purpose of MMC_DATA_MULTI?
Message-ID: <20060201092934.GB27735@flint.arm.linux.org.uk>
Mail-Followup-To: Pierre Ossman <drzeus-list@drzeus.cx>,
	LKML <linux-kernel@vger.kernel.org>
References: <43E057DA.7000909@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43E057DA.7000909@drzeus.cx>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2006 at 07:40:26AM +0100, Pierre Ossman wrote:
> I noticed that a new transfer flag was recently added to the MMC layer
> without any immediate users, the MMC_DATA_MULTI flag. I'm guessing the
> purpose of the flag is to indicate the difference between
> MMC_READ_SINGLE_BLOCK and MMC_READ_MULTIPLE_BLOCKS with just one block.
> If so, then that should probably be mentioned in a comment somewhere.

There are hosts out there (Atmel AT91-based) which need to know if the
transfer is going to be multiple block.  Rather than have them test
the op-code (which is what they're already doing), we provide a flag
instead.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
