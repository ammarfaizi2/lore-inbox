Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263150AbTI3HEG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 03:04:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263152AbTI3HEG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 03:04:06 -0400
Received: from dp.samba.org ([66.70.73.150]:62895 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263150AbTI3HED (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 03:04:03 -0400
Date: Tue, 30 Sep 2003 17:03:29 +1000
From: Anton Blanchard <anton@samba.org>
To: srikrish <srikrish@in.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] For Segmentation Fault when using large external array
Message-ID: <20030930070328.GG24019@krispykreme>
References: <006601c38685$0148b3a0$9915b609@srikrishnan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <006601c38685$0148b3a0$9915b609@srikrishnan>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

> When I compile and run an application with a large external array I get a
> Segmentation Fault.

...

> Comments: The problem is that we don't reserve the bss region for the app
> (via a set_brk/do_brk call) until after we've loaded the loader so they get
> mapped to overlapping memory locations. The fix is to move the update to
> current->mm.* and the set_brk/do_brk call to before the point we call
> load_elf_interp().

Yes it would be nice if we failed more gracefully here. A number of
people have come to me after hitting this problem, not realising that
its the size of their bss that caused the SEGV.

BTW I didnt look at your patch, unfortunately your mailer destroyed it.

Anton
