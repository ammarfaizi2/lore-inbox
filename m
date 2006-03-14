Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751827AbWCNLzh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751827AbWCNLzh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 06:55:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751891AbWCNLzh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 06:55:37 -0500
Received: from A.painless.aaisp.net.uk ([81.187.81.51]:51947 "EHLO
	smtp.aaisp.net.uk") by vger.kernel.org with ESMTP id S1751827AbWCNLzg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 06:55:36 -0500
Subject: 2.6.16-rc6-git[12] spontaneous reboots on x86_64
From: Andrew Clayton <andrew@rootshell.co.uk>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Tue, 14 Mar 2006 11:55:19 +0000
Message-Id: <1142337319.4412.2.camel@zeus.pccl.info>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

With the above kernels I am seeing spontaneous system reboots. Nothing
seems to get logged anywhere and when I've been at the console I haven't
noticed any oops or anything before the machine resets.

This was first triggered by accessing a usb key drive thing, this
happened a couple of times and then this morning while investigating
some more it happened as I was exiting my X session.  

The machine is an AMD Athlon(tm) 64 Processor 3500+ (Single processor,
single core), with 1GB RAM. GCC is gcc (GCC) 4.0.2 20051125 (Red Hat
4.0.2-8) from Fedora Core 4


2.6.16-rc6 is working fine.


The following change looked an obvious candidate

http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=c33d4568aca9028a22857f94f5e0850012b6444b

So I took a 2.6.16-rc6-git2 tree and reverted arch/x86_64/kernel/entry.S
to the one in 2.6.16-rc6 and so far (35 minutes) no problems.



Let me know if you'd like any more info.


Cheers,

Andrew


