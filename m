Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261183AbUC1Le2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 06:34:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261184AbUC1Le2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 06:34:28 -0500
Received: from ozlabs.org ([203.10.76.45]:48566 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261183AbUC1LeY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 06:34:24 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16486.47012.649600.949669@cargo.ozlabs.ibm.com>
Date: Sun, 28 Mar 2004 21:31:48 +1000
From: Paul Mackerras <paulus@samba.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-rc2-mm4
In-Reply-To: <20040326131816.33952d92.akpm@osdl.org>
References: <20040326131816.33952d92.akpm@osdl.org>
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With the patches that I have just sent, plus adding #include
<linux/types.h> to include/linux/prefetch.h, since it uses size_t, -mm4
compiles and runs on my powerbook (ppc32).  It does, however, freeze
up shortly after waking up from sleep (suspend-to-ram).  I don't know
why.

On ppc64 I got a compile error in arch/ppc64/kernel/eeh.c, because the
-mm4 patch removes a #include <asm/machdep.h> that is needed.  When I
put that back in, it compiles and runs on my G5.  That is with the
include/linux/prefetch.h change and the ppc signal patch that I posted.

Paul.
