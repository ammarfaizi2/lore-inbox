Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262881AbTIQWma (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 18:42:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262884AbTIQWm3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 18:42:29 -0400
Received: from mail.kroah.org ([65.200.24.183]:18849 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262881AbTIQWm2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 18:42:28 -0400
Date: Wed, 17 Sep 2003 15:41:10 -0700
From: Greg KH <greg@kroah.com>
To: Meelis Roos <mroos@linux.ee>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB IR Dongle Serial Driver broken
Message-ID: <20030917224110.GA6902@kroah.com>
References: <Pine.GSO.4.44.0309171807100.19495-100000@math.ut.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.44.0309171807100.19495-100000@math.ut.ee>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 17, 2003 at 06:09:35PM +0300, Meelis Roos wrote:
> Just tried to compile USB IR Dongle Serial Driver, it breaks with
> 
> ir-usb.c: In function `ir_set_termios':
> ir-usb.c:571: error: `B4000000' undeclared (first use in this function)
> 
> 2.4.23-pre4 on sparc64

Looks like someone needs to fix up include/asm-sparc64/termbits.h:

/* These have totally bogus values and nobody uses them
   so far. Later on we'd have to use say 0x10000x and
   adjust CBAUD constant and drivers accordingly.
#define B2500000  0x00001010
#define B3000000  0x00001011
#define B3500000  0x00001012
#define B4000000  0x00001013  */


thanks,

greg k-h
