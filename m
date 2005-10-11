Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751065AbVJKD6d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751065AbVJKD6d (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 23:58:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751047AbVJKD6d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 23:58:33 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:54943
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751201AbVJKD6d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 23:58:33 -0400
Date: Mon, 10 Oct 2005 20:58:27 -0700 (PDT)
Message-Id: <20051010.205827.122179808.davem@davemloft.net>
To: viro@ftp.linux.org.uk
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, tcallawa@redhat.com
Subject: Re: Linux v2.6.14-rc4
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20051011034127.GS7992@ftp.linux.org.uk>
References: <Pine.LNX.4.64.0510101824130.14597@g5.osdl.org>
	<20051011034127.GS7992@ftp.linux.org.uk>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 11 Oct 2005 04:41:27 +0100

> On Mon, Oct 10, 2005 at 06:31:12PM -0700, Linus Torvalds wrote:
> > Tom 'spot' Callaway:
> >       [SPARC32]: Enable generic IOMAP.
> 
> ... breaks non-PCI builds (aka the absolute majority of sparc32 boxen).
> On sparc32 insl() et.al. are defined only if CONFIG_PCI is set.
> 
> Moreover, I really doubt that generic_iomap is the right thing to do
> there - all these guys end up as memory dereferences anyway, so ioread...()
> et.al. have no reason to care about the origin of iomem pointer they get.

Also, Tom never answered my query about the driver he stated
this was needed for (sym53c8xx) which appears on no sparc32
PCI box in the world :-)

I'll revert this for now, push that to Linus, and we can hash it out
better in 2.6.15
