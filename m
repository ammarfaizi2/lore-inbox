Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261843AbVCAJhW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261843AbVCAJhW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 04:37:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261844AbVCAJhW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 04:37:22 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:17171 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261843AbVCAJhO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 04:37:14 -0500
Date: Tue, 1 Mar 2005 09:37:09 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: updating mtime for char/block devices?
Message-ID: <20050301093709.A29817@flint.arm.linux.org.uk>
Mail-Followup-To: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>,
	Arjan van de Ven <arjan@infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <42225CEE.1030104@gmx.net> <1109576878.6298.49.camel@laptopd505.fenrus.org> <4223BB3B.4060309@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <4223BB3B.4060309@gmx.net>; from c-d.hailfinger.devel.2005@gmx.net on Tue, Mar 01, 2005 at 01:45:47AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 01, 2005 at 01:45:47AM +0100, Carl-Daniel Hailfinger wrote:
> Can I prevent mtime updates for all device files? Mounting /dev readonly
> would certainly help, but for that to work I'd have to move /dev to a
> different filesystem, right?

tty mtime updates aren't marked dirty, so aren't written back to disk.
Intentionally.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
