Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264137AbUAUT2P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 14:28:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264145AbUAUT2P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 14:28:15 -0500
Received: from fed1mtao07.cox.net ([68.6.19.124]:23231 "EHLO
	fed1mtao07.cox.net") by vger.kernel.org with ESMTP id S264137AbUAUT2O
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 14:28:14 -0500
Date: Wed, 21 Jan 2004 12:28:13 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.2-rc1
Message-ID: <20040121192813.GX13454@stop.crashing.org>
References: <Pine.LNX.4.58.0401202037530.2123@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0401202037530.2123@home.osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 20, 2004 at 08:43:53PM -0800, Linus Torvalds wrote:

> Ok, this is the next "big merge" with things from Andrew's -mm tree, along
> with a number of new drivers and arch updates.
[snip]
> Paul Mackerras:
>   o sort exception tables

And as more proof that Paul is leaving us ppc32 folks, *sniff*, the
following is needed for PPC32 to compile:

--- a/arch/ppc/kernel/setup.c	Wed Jan 21 12:27:24 2004
+++ b/arch/ppc/kernel/setup.c	Wed Jan 21 12:27:24 2004
@@ -668,7 +655,6 @@
 	if ( ppc_md.progress ) ppc_md.progress("arch: exit", 0x3eab);
 
 	paging_init();
-	sort_exception_table();
 
 	/* this is for modules since _machine can be a define -- Cort */
 	ppc_md.ppc_machine = _machine;

-- 
Tom Rini
http://gate.crashing.org/~trini/
