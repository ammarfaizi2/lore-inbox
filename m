Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261214AbTIKOPZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 10:15:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261221AbTIKOPZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 10:15:25 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:32145 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S261214AbTIKOPW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 10:15:22 -0400
Subject: Re: [PATCH] 2.6 workaround for Athlon/Opteron prefetch errata
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andi Kleen <ak@suse.de>, richard.brunner@amd.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, akpm@osdl.org
In-Reply-To: <Pine.LNX.4.44.0309110650390.28410-100000@home.osdl.org>
References: <Pine.LNX.4.44.0309110650390.28410-100000@home.osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1063289641.2967.3.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-5) 
Date: Thu, 11 Sep 2003 15:14:02 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-09-11 at 14:54, Linus Torvalds wrote:
> This patch is fragile and looks pointless.
> 
> What's wrong with the current status quo that just says "Athlon prefetch
> is broken"?

Firstly performance, secondly user space exceptions. We work around lots
of other broken CPU things this one triggers a path that only matters on
Athlon.

There is *one* change needed. We shouldnt call is_prefetch unless the
current CPU is an Athlon. That way its a performance improvement for
PIV, and Athlon in general, fixes the bug and causes no fancy athlon
fixup code for non AMD processors.

Alan

