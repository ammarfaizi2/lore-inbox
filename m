Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752513AbWAFRlj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752513AbWAFRlj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 12:41:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752517AbWAFRli
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 12:41:38 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:58637 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1752513AbWAFRlh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 12:41:37 -0500
Date: Fri, 6 Jan 2006 17:41:28 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] don't allow users to set CONFIG_BROKEN=y
Message-ID: <20060106174127.GE16093@flint.arm.linux.org.uk>
Mail-Followup-To: Adrian Bunk <bunk@stusta.de>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20060106173547.GR12131@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060106173547.GR12131@stusta.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 06, 2006 at 06:35:47PM +0100, Adrian Bunk wrote:
> Do not allow people to create configurations with CONFIG_BROKEN=y.
> 
> The sole reason for CONFIG_BROKEN=y would be if you are working on 
> fixing a broken driver, but in this case editing the Kconfig file is 
> trivial.
> 
> Never ever should a user enable CONFIG_BROKEN.

NACK.  MTD_OBSOLETE_CHIPS still hasn't been fixed and must be fixed
_before_ this patch can go in.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
