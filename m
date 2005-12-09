Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964808AbVLIRIx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964808AbVLIRIx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 12:08:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964805AbVLIRIw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 12:08:52 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:38923 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S964797AbVLIRIv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 12:08:51 -0500
Date: Fri, 9 Dec 2005 17:08:42 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Erik Mouw <erik@harddisk-recovery.com>
Cc: Olaf Hering <olh@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Sachin Sant <sachinp@in.ibm.com>
Subject: Re: [PATCH] Adding ctrl-o sysrq hack support to 8250 driver
Message-ID: <20051209170841.GB31708@flint.arm.linux.org.uk>
Mail-Followup-To: Erik Mouw <erik@harddisk-recovery.com>,
	Olaf Hering <olh@suse.de>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, Sachin Sant <sachinp@in.ibm.com>
References: <20051209140559.GA23868@suse.de> <20051209152530.GE15372@harddisk-recovery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051209152530.GE15372@harddisk-recovery.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 09, 2005 at 04:25:31PM +0100, Erik Mouw wrote:
> If you really want to use ctrl-o, could you make a way that pressing
> ctrl-o twice sends a single ctrl-o to the process attached to the
> console?

That's already handled by adding uart_handle_break() - the first call
to this function will set sysrq status and return 1 (ignore character).
The second call will clear sysrq status and return 0 (don't ignore).

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
