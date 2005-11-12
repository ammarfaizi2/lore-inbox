Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932432AbVKLRqJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932432AbVKLRqJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 12:46:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932433AbVKLRqJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 12:46:09 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:38674 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932430AbVKLRqH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 12:46:07 -0500
Date: Sat, 12 Nov 2005 17:46:01 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-rc1: IDE: fix potential data corruption with SL82C105 interfaces
Message-ID: <20051112174601.GC28987@flint.arm.linux.org.uk>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20051112165548.GB28987@flint.arm.linux.org.uk> <1131818615.18258.6.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1131818615.18258.6.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 12, 2005 at 06:03:34PM +0000, Alan Cox wrote:
> On Sad, 2005-11-12 at 16:55 +0000, Russell King wrote:
> > We must _never_ _ever_ on pain of death enable IDE DMA on SL82C105
> > chipsets where the southbridge revision is <= 5, otherwise data
> > corruption will occur.
> 
> If you are fixing this driver also set ->serialize = 1; before someone
> with dual channel device gets burned.

Thanks for reminding me - I've included that as well.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
