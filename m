Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261786AbVACS0y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261786AbVACS0y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 13:26:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261522AbVACRuK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 12:50:10 -0500
Received: from holomorphy.com ([207.189.100.168]:52892 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261766AbVACRrS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 12:47:18 -0500
Date: Mon, 3 Jan 2005 09:47:13 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Subject: [8/8] fix module_param() type mismatch in drivers/char/n_hdlc.c
Message-ID: <20050103174713.GJ29332@holomorphy.com>
References: <20050103172013.GA29332@holomorphy.com> <20050103172303.GB29332@holomorphy.com> <20050103172615.GD29332@holomorphy.com> <20050103172839.GE29332@holomorphy.com> <20050103173406.GF29332@holomorphy.com> <20050103173643.GG29332@holomorphy.com> <20050103173952.GH29332@holomorphy.com> <20050103174521.GI29332@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050103174521.GI29332@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

maxframe is a variable of type ssize_t; this patch repairs the warning
arising from the type mismatch in the module_param() declaration.

Signed-off-by: William Irwin <wli@holomorphy.com>

Index: mm1-2.6.10/drivers/char/n_hdlc.c
===================================================================
--- mm1-2.6.10.orig/drivers/char/n_hdlc.c	2005-01-03 06:46:06.000000000 -0800
+++ mm1-2.6.10/drivers/char/n_hdlc.c	2005-01-03 08:35:57.000000000 -0800
@@ -976,5 +976,5 @@
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Paul Fulghum paulkf@microgate.com");
 module_param(debuglevel, int, 0);
-module_param(maxframe, int, 0);
+module_param(maxframe, ssize_t, 0);
 MODULE_ALIAS_LDISC(N_HDLC);
