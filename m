Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261478AbVDDX2B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261478AbVDDX2B (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 19:28:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261508AbVDDX1h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 19:27:37 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:54656 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261501AbVDDXYY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 19:24:24 -0400
Date: Tue, 5 Apr 2005 00:24:19 +0100
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.12-rc2
Message-ID: <20050404232419.GA8859@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.58.0504040945100.32180@ppc970.osdl.org> <Pine.LNX.4.58.0504041430070.2215@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504041430070.2215@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 04, 2005 at 02:32:52PM -0700, Linus Torvalds wrote:
> This is also the point where I ask people to calm down, and not send me
> anything but clear bug-fixes etc. We're definitely well into -rc land. So 
> keep it quiet out there,

	* missing include in arm/kernel/time.c - see #ifdef CONFIG_PM
further down in the file.

diff -urN RC12-rc2-base/arch/arm/kernel/time.c current/arch/arm/kernel/time.c
--- RC12-rc2-base/arch/arm/kernel/time.c	2005-04-04 18:20:42.000000000 -0400
+++ current/arch/arm/kernel/time.c	2005-04-04 19:17:12.446004816 -0400
@@ -28,6 +28,7 @@
 #include <linux/profile.h>
 #include <linux/sysdev.h>
 #include <linux/timer.h>
+#include <linux/pm.h>
 
 #include <asm/hardware.h>
 #include <asm/io.h>
