Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751794AbWEEWPE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751794AbWEEWPE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 18:15:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751795AbWEEWPD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 18:15:03 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:54541 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751794AbWEEWPB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 18:15:01 -0400
Date: Fri, 5 May 2006 23:14:54 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Cc: Andrew Morton <akpm@osdl.org>, Greg Kroah-Hartman <gregkh@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] device core: remove redundant call to device_initialize.
Message-ID: <20060505221454.GH10974@flint.arm.linux.org.uk>
Mail-Followup-To: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>,
	Andrew Morton <akpm@osdl.org>, Greg Kroah-Hartman <gregkh@suse.de>,
	linux-kernel@vger.kernel.org
References: <20060505153907.12756.23295.stgit@zion.home.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060505153907.12756.23295.stgit@zion.home.lan>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 05, 2006 at 05:39:08PM +0200, Paolo 'Blaisorblade' Giarrusso wrote:
> From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
> 
> platform_device_add calls device_register which calls then again
> device_initialize, redundantly.

platform_device_add should be using device_add not device_register.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
