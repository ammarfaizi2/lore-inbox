Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751168AbWCMOn4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751168AbWCMOn4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 09:43:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751237AbWCMOn4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 09:43:56 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:15576 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751168AbWCMOnz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 09:43:55 -0500
Subject: Re: [patch] Require VM86 with VESA framebuffer
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Antonino Daplas <adaplas@pol.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Adrian Bunk <bunk@stusta.de>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <200603130917_MC3-1-BA83-2167@compuserve.com>
References: <200603130917_MC3-1-BA83-2167@compuserve.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 13 Mar 2006 14:44:56 +0000
Message-Id: <1142261096.25773.19.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2006-03-13 at 09:13 -0500, Chuck Ebbert wrote:
> Force VM86 when VESA framebuffer is enabled and fix a typo
> in the VM86 config entry. If VM86 is disabled there will
> be problems when starting X using the VESA driver.

VESA does not require VM86 so this change is completely wrong. Worse
still the x86-64 does not support VM86 so you have just crippled the
x86-64 port unneccessarily.

Please sort out your personal X server problem instead. To start with X
doesn't require VM86 to be present at all and can do software 8086 int
10 emulation for BIOS code.

Alan

