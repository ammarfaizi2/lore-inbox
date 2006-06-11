Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751182AbWFKX5v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751182AbWFKX5v (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jun 2006 19:57:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751191AbWFKX5v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jun 2006 19:57:51 -0400
Received: from waste.org ([64.81.244.121]:26081 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S1751182AbWFKX5v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jun 2006 19:57:51 -0400
Date: Sun, 11 Jun 2006 18:47:46 -0500
From: Matt Mackall <mpm@selenic.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: Re: [PATCH] x86 built-in command line
Message-ID: <20060611234746.GJ24227@waste.org>
References: <20060611215530.GH24227@waste.org> <Pine.LNX.4.61.0606120129230.8102@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0606120129230.8102@yvahk01.tjqt.qr>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2006 at 01:30:27AM +0200, Jan Engelhardt wrote:
> >
> >This patch allows building in a kernel command line on x86 as is
> >possible on several other arches.
> >
> >+config CMDLINE
> >+	  On some systems, there is no way for the boot loader to pass
> >+	  arguments to the kernel. For these platforms, you can supply
> >+	  some command-line options at build time by entering them
> >+	  here. In most cases you will need to specify the root device
> >+	  here.
> 
> Thank God x86 does not have that limitation. Or am I missing some exotic 
> bootloader that fails to pass in arguments?

Yes. Note that this depends on CONFIG_EMBEDDED. It's quite common for
embedded apps to roll their own trivial ROM-based boot loaders. It's
also quite common for embedded boxen to run up against the command
line length limit that's hardcoded in the boot protocol.

-- 
Mathematics is the supreme nostalgia of our time.
