Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261837AbUANRUu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 12:20:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261758AbUANRUu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 12:20:50 -0500
Received: from h192n2fls310o1003.telia.com ([81.224.187.192]:59288 "EHLO
	cambrant.com") by vger.kernel.org with ESMTP id S262052AbUANRUf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 12:20:35 -0500
Date: Wed, 14 Jan 2004 18:20:22 +0100
From: Tim Cambrant <tim@cambrant.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [Newbie-warning] MOD_INC_USE_COUNT usage
Message-ID: <20040114172022.GA2112@cambrant.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With the high risk of being flamed, I send this to LKML. Feel free
to tell me not to if this is a huge no-no, and it won't happen
again.

I was studying some of the warnings that appears when compiling
2.6.1-mm3, and one common warning is the MOD_INC_USE_COUNT macro
being used. Apparently it's deprecated, but if that's the case,
why is it still being used in the kernel?

I googled a bit and found a few discussions about the issue
(mostly concerning the /mm-subsystem) where some people found
it okay to just remove the call to MOD_INC_USE_COUNT totally,
since it is totally unnecessary under 2.5 (and under 2.6 too,
I presume). Since the discussions provided a lot of contradictions
and no solution, I thought asking a question to someone who has
an idea of what this is about might be a good thing.

I'm not asking you to remove this call, but I do want to know
why it shouldn't be removed and what is being done to replace
a function (or macro... whatever it is) that is deprecated. Any
explanations would be gratefully accepted. Thank you.

Since I'm no kernel-hacker (and not much of a coder at all)
don't expect me to understand a lot of jargon, but this question
is being asked because I'm really interested in understanding
the Linux kernel.

So, why shouldn't this patch be applied?:

--- drivers/ide/pci/generic.c.orig      2004-01-14 17:52:35.000000000 +0100
+++ drivers/ide/pci/generic.c   2003-11-24 13:54:01.000000000 +0100
@@ -121,6 +121,7 @@ static int __devinit generic_init_one(st
		return 1;
	}
	ide_setup_pci_device(dev, d);
+	MOD_INC_USE_COUNT;
	return 0;
 }


                Tim Cambrant
