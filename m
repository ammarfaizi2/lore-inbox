Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964936AbVIHU0n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964936AbVIHU0n (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 16:26:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964986AbVIHU0n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 16:26:43 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:44723
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S964936AbVIHU0n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 16:26:43 -0400
Date: Thu, 08 Sep 2005 13:26:34 -0700 (PDT)
Message-Id: <20050908.132634.88719733.davem@davemloft.net>
To: rmk+lkml@arm.linux.org.uk
Cc: torvalds@osdl.org, alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
       davem@redhat.com, akpm@osdl.org
Subject: Re: Serial maintainership
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050908212236.A19542@flint.arm.linux.org.uk>
References: <Pine.LNX.4.58.0509080922230.3208@g5.osdl.org>
	<20050908.131358.93602687.davem@davemloft.net>
	<20050908212236.A19542@flint.arm.linux.org.uk>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Russell King <rmk+lkml@arm.linux.org.uk>
Date: Thu, 8 Sep 2005 21:22:36 +0100

> the "regs" argument may not exist in the parent context in the
> !SUPPORT_SYSRQ case.

Then pass in a NULL in the ARM serial drivers instead of this ugly
dependency upon the macro not using the argument.
