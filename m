Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263041AbUDYTQD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263041AbUDYTQD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Apr 2004 15:16:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263219AbUDYTQD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Apr 2004 15:16:03 -0400
Received: from waste.org ([209.173.204.2]:13967 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S263041AbUDYTQA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Apr 2004 15:16:00 -0400
Date: Sun, 25 Apr 2004 14:15:43 -0500
From: Matt Mackall <mpm@selenic.com>
To: Jeff Moyer <jmoyer@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: netconsole hangs w/ alt-sysrq-t
Message-ID: <20040425191543.GV28459@waste.org>
References: <16519.58589.773562.492935@segfault.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16519.58589.773562.492935@segfault.boston.redhat.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2004 at 11:29:33AM -0400, Jeff Moyer wrote:
> If netconsole is enabled, and you hit Alt-Sysrq-t, then it will print a
> small amount of output to the console(s) and then hang the system.  In this
> case, I'm using the e100 driver, and we end up exhausting the available
> cbs.  Since we are in interrupt context, the driver's poll routine is never
> run, and we loop infinitely waiting for resources to free up that never
> will.  Kernel version is 2.6.5.

Can you try 2.6.6-rc2? It has a fix to congestion handling that should
address this.

-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
