Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267354AbUJGJIO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267354AbUJGJIO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 05:08:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269757AbUJGJIO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 05:08:14 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:6157 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S267354AbUJGJIJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 05:08:09 -0400
Date: Thu, 7 Oct 2004 10:07:57 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Thayne Harbaugh <tharbaugh@lnxi.com>,
       =?iso-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>,
       Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Console: fall back to /dev/null when no console is availlable
Message-ID: <20041007100757.A10716@flint.arm.linux.org.uk>
Mail-Followup-To: Geert Uytterhoeven <geert@linux-m68k.org>,
	Thayne Harbaugh <tharbaugh@lnxi.com>,
	=?iso-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>,
	Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>
References: <20041005185214.GA3691@wohnheim.fh-wedel.de> <20041006173823.GA26740@kroah.com> <20041006180421.GD10153@wohnheim.fh-wedel.de> <20041006181958.GB27300@kroah.com> <20041006192335.GH10153@wohnheim.fh-wedel.de> <1097097771.3845.28.camel@tubarao> <Pine.GSO.4.61.0410071017020.9319@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.4.61.0410071017020.9319@waterleaf.sonytel.be>; from geert@linux-m68k.org on Thu, Oct 07, 2004 at 10:18:51AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 07, 2004 at 10:18:51AM +0200, Geert Uytterhoeven wrote:
> What about letting the kernel open the console without going through
> /dev/console? Since the kernel knows /dev/console is the device with major 5
> minor 1, why can't it just open (5, 1)? Then we don't need a /dev/console node,
> and things will never break.

Famous last words.  What about the case where you don't have a console
device registered (eg in the case of an embedded device) ?  Currently,
opening /dev/console fails in that circumstance.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
