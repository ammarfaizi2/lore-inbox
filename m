Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261917AbUK0Ge7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261917AbUK0Ge7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 01:34:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261244AbUK0G1c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Nov 2004 01:27:32 -0500
Received: from zeus.kernel.org ([204.152.189.113]:49599 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S261954AbUKZTM0 (ORCPT
	<rfc822;Linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:12:26 -0500
From: David Brownell <david-b@pacbell.net>
To: linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] [PATCH] Ohci-hcd: fix endless loop (second take)
Date: Fri, 26 Nov 2004 10:46:30 -0800
User-Agent: KMail/1.7.1
Cc: Colin Leroy <colin@colino.net>, Linux-kernel@vger.kernel.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>
References: <20041126113021.135e79df@pirandello> <200411260928.18135.david-b@pacbell.net>
In-Reply-To: <200411260928.18135.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411261046.30708.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Colin reported off-line that he's using 2.6.9
rather than 2.6.10-rc2 or newer ... so it's
actually expected that his kernel misbehave
with USB PM.  The workaround, for all 2.6
kernels until very recently, is to rmmod the
HCDs before entering a system sleep state.

I think that starting in 2.6.10 it'll be OK
to leave the USB HCDs loaded during various
PM sleep states ... in at least some common
system configuration.  There are several
hundred different possibilities, it's hard
to test all of them even if you do happen to
have all that hardware!

But for earlier kernels, don't even try that.

- Dave

