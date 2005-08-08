Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932244AbVHHTym@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932244AbVHHTym (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 15:54:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932245AbVHHTym
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 15:54:42 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:32485
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932244AbVHHTyl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 15:54:41 -0400
Date: Mon, 08 Aug 2005 12:54:32 -0700 (PDT)
Message-Id: <20050808.125432.74747546.davem@davemloft.net>
To: greg@kroah.com
Cc: torvalds@osdl.org, ralf@linux-mips.org, linux-kernel@vger.kernel.org,
       linville@redhat.com
Subject: Re: pci_update_resource() getting called on sparc64
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050808194249.GA6729@kroah.com>
References: <20050808160846.GA7710@kroah.com>
	<20050808.123209.59463259.davem@davemloft.net>
	<20050808194249.GA6729@kroah.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg KH <greg@kroah.com>
Date: Mon, 8 Aug 2005 12:42:49 -0700

> Linus, can you just revert that changeset for now?  That will sove
> David's problem, and I'll work on getting this patch working properly
> for after 2.6.13 is out.

Agreed.

I even have a patch I'll submit to you which will get sparc64
converted over to using drivers/pci/setup-res.c so that none
of this kind of non-sense will occur in the future.

> Hm, how do you revert a git patch?

"patch -p1 -R" the patch, then use a changelog like:

[PCI]: Revert $(SHA1)

The $(SHA1) even shows up in gitk as a hyperlink so you can
see the original changeset and assosciated changelog entry
by just clicking on it.
