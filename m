Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933230AbWKNAQt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933230AbWKNAQt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 19:16:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933228AbWKNAQt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 19:16:49 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:19675
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S933227AbWKNAQs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 19:16:48 -0500
Date: Mon, 13 Nov 2006 16:16:56 -0800 (PST)
Message-Id: <20061113.161656.90118004.davem@davemloft.net>
To: viro@ftp.linux.org.uk
Cc: kenneth.w.chen@intel.com, akpm@osdl.org, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [patch] fix up generic csum_ipv6_magic function prototype
From: David Miller <davem@davemloft.net>
In-Reply-To: <20061113085223.GR29920@ftp.linux.org.uk>
References: <20061109072216.GL29920@ftp.linux.org.uk>
	<20061108.235548.12921799.davem@davemloft.net>
	<20061113085223.GR29920@ftp.linux.org.uk>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@ftp.linux.org.uk>
Date: Mon, 13 Nov 2006 08:52:23 +0000

> The first question is in the types we are using for length.  OK,
> csum_tcpudp_...() is a special case; there we want u16 and unless
> there's a reason _not_ to do so on sparc, I'd rather convert it
> to the same thing.

That's fine.

> csum_partial_copy_fromuser():  Can die, only 3 targets have its rudiment
> and nothing in the tree uses it.  ACK?

ACK.

> csum_partial_copy().  Rare alias for csum_partial_copy_nocheck().  Can die;
> all instances simply should be renamed to csum_partial_copy_nocheck.  ACK?

ACK.
