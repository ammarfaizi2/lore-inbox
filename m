Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262969AbUC2PYA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 10:24:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262971AbUC2PYA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 10:24:00 -0500
Received: from fed1mtao08.cox.net ([68.6.19.123]:18567 "EHLO
	fed1mtao08.cox.net") by vger.kernel.org with ESMTP id S262969AbUC2PX6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 10:23:58 -0500
Date: Mon, 29 Mar 2004 08:23:56 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-rc2-mm4
Message-ID: <20040329152356.GE2895@smtp.west.cox.net>
References: <20040326131816.33952d92.akpm@osdl.org> <16486.47012.649600.949669@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16486.47012.649600.949669@cargo.ozlabs.ibm.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 28, 2004 at 09:31:48PM +1000, Paul Mackerras wrote:
> With the patches that I have just sent, plus adding #include
> <linux/types.h> to include/linux/prefetch.h, since it uses size_t, -mm4
> compiles and runs on my powerbook (ppc32).  It does, however, freeze
> up shortly after waking up from sleep (suspend-to-ram).  I don't know
> why.
> 
> On ppc64 I got a compile error in arch/ppc64/kernel/eeh.c, because the
> -mm4 patch removes a #include <asm/machdep.h> that is needed.  When I
> put that back in, it compiles and runs on my G5.  That is with the
> include/linux/prefetch.h change and the ppc signal patch that I posted.

D'oh, sorry.  I thought I audited the ppc64 files that looked to be
using <asm/machdep.h> just for cmd_line/COMMAND_LINE_SIZE but missed
the real usage in that one.

-- 
Tom Rini
http://gate.crashing.org/~trini/
