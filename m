Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267552AbUIPKRP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267552AbUIPKRP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 06:17:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267701AbUIPKRP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 06:17:15 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:49928 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S267552AbUIPKRN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 06:17:13 -0400
Date: Thu, 16 Sep 2004 11:17:09 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: "Randy.Dunlap" <randy.dunlap@verizon.net>
Cc: mgreer@mvista.com, akpm <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: review MPSC driver
Message-ID: <20040916111709.C31029@flint.arm.linux.org.uk>
Mail-Followup-To: "Randy.Dunlap" <randy.dunlap@verizon.net>,
	mgreer@mvista.com, akpm <akpm@osdl.org>,
	lkml <linux-kernel@vger.kernel.org>
References: <20040915150247.37706f7c.rddunlap@osdl.org> <20040915214301.53a68379.randy.dunlap@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040915214301.53a68379.randy.dunlap@verizon.net>; from randy.dunlap@verizon.net on Wed, Sep 15, 2004 at 09:43:01PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2004 at 09:43:01PM -0700, Randy.Dunlap wrote:
> 3.  + select SERIAL_CORE
>     + select SERIAL_CORE_CONSOLE
> 
> Please don't use "select".  Use "depends on" instead.

This is actually (one of the few) correct uses of select.  These two
symbols are *not* user visible, and are derived from the configuration
settings of the hardware drivers.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
