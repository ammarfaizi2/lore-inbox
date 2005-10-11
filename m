Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932356AbVJKUBg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932356AbVJKUBg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 16:01:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932357AbVJKUBg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 16:01:36 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:52631 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S932356AbVJKUBg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 16:01:36 -0400
Date: Tue, 11 Oct 2005 13:01:57 -0700
From: Deepak Saxena <dsaxena@plexity.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] [ARM] Add missing EXPORT_SYMBOL in ixp2000 core
Message-ID: <20051011200157.GA31641@plexity.net>
Reply-To: dsaxena@plexity.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Plexity Networks
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


IXP2000 I2C driver cannot be used as a loadable module w/o this symbol
exported.

Signed-off-by: Deepak Saxena <dsaxena@plexity.net>

diff --git a/arch/arm/mach-ixp2000/core.c b/arch/arm/mach-ixp2000/core.c
--- a/arch/arm/mach-ixp2000/core.c
+++ b/arch/arm/mach-ixp2000/core.c
@@ -303,6 +303,7 @@ void gpio_line_config(int line, int dire
 	}
 	local_irq_restore(flags);
 }
+EXPORT_SYMBOL_GPL(gpio_line_config);
 
 
 /*************************************************************************

-- 
Deepak Saxena - dsaxena@plexity.net - http://www.plexity.net

Even a stopped clock gives the right time twice a day.
