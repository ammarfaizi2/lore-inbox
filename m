Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966304AbWKNTln@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966304AbWKNTln (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 14:41:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966305AbWKNTln
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 14:41:43 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:13229 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S966304AbWKNTlm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 14:41:42 -0500
Date: Tue, 14 Nov 2006 19:41:37 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Miguel Ojeda Sandonis <maxextreme@gmail.com>,
       Luming Yu <Luming.yu@intel.com>, Andrew Zabolotny <zap@homelink.ru>,
       Jamey Hicks <jamey.hicks@hp.com>
Subject: ACPI output/lcd/auxdisplay mess
Message-ID: <Pine.LNX.4.64.0611141939050.6957@pentafluge.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have noticed a bunch of patches coming in dealing with the same problem. How to handle displays 
i.e LCD, CRT etc. We have a lcd class in video/backlight which no one is using. Because no one was
aware of it auxdisplay was created instead. Then we have the acpi code which wants a output class
to handle powering down the display device. Plus the acpi layer does something very similar to the
framebuffer with getting edids and data relating to the display device. We really should place all
this handling in one standard place. To do this I need to know what all of you require.
