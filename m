Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265196AbUGLPTk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265196AbUGLPTk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 11:19:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266870AbUGLPTk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 11:19:40 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:44734 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S265196AbUGLPTj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 11:19:39 -0400
Date: Mon, 12 Jul 2004 08:19:37 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Der Herr Hofrat <der.herr@hofr.at>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: TQM in 2.6.X
Message-ID: <20040712151937.GM28002@smtp.west.cox.net>
References: <200407110948.i6B9msv17520@hofr.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200407110948.i6B9msv17520@hofr.at>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 11, 2004 at 11:48:54AM +0200, Der Herr Hofrat wrote:

>  arch/ppc/platforms/tqm8260_setup.c
>  
>  looks like it is truncated in the 2.6.X tar.bz2 archives from kernel.org
>  (checked 2.6.0/5/6) - am I doing something stupid or is vanilla 2.6.X 
>  just not ready for TQM8260 ?

The file is supposed to be short.  But yes, TQM8260 support has never been
tested in 2.5 or 2.6, so there might be other problems lurking.

Andrew, please apply.

Signed-off-by: Tom Rini <trini@kernel.crashing.org>

--- 1.3/arch/ppc/platforms/tqm8260_setup.c	2004-06-16 10:56:13 -07:00
+++ edited/tqm8260_setup.c	2004-07-12 08:17:30 -07:00
@@ -77,3 +77,4 @@
 
 	callback_setup_arch	= ppc_md.setup_arch;
 	ppc_md.setup_arch	= tqm8260_setup_arch;
+}

-- 
Tom Rini
http://gate.crashing.org/~trini/
