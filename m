Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266116AbUIVUwV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266116AbUIVUwV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 16:52:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267651AbUIVUwU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 16:52:20 -0400
Received: from fw.osdl.org ([65.172.181.6]:41930 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266116AbUIVUwQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 16:52:16 -0400
Date: Wed, 22 Sep 2004 13:46:35 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: manomugdha biswas <manomugdhab@yahoo.co.in>
Cc: linux-kernel@vger.kernel.org
Subject: Re: shutdown process
Message-Id: <20040922134635.44ca34c8.rddunlap@osdl.org>
In-Reply-To: <20040922075126.45031.qmail@web8510.mail.in.yahoo.com>
References: <20040922075126.45031.qmail@web8510.mail.in.yahoo.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-vine-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Sep 2004 08:51:26 +0100 (BST) manomugdha biswas wrote:

| Hi all,
|   I have written a module and loaded into kernel by
| insmod. I want to let my module know when the system
| is shutdown. How to let my module know that the system
| is going to shutdown??


See sig.  Answering for Linux 2.6.x, but it looks like almost
no changes here from 2.4 to 2.6:


Call notifier_chain_register(&reboot_notifier_list, &notif_block);
or
register_reboot_notifier(&notif_block);


--
~Randy
MOTD:  Always include version info.
(Again.  Sometimes I think ln -s /usr/src/linux/.config .signature)
