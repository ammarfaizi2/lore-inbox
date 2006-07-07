Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932161AbWGGMmD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932161AbWGGMmD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 08:42:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932159AbWGGMmB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 08:42:01 -0400
Received: from TYO202.gate.nec.co.jp ([202.32.8.206]:50632 "EHLO
	tyo202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S932157AbWGGMmA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 08:42:00 -0400
To: David Chinner <dgc@sgi.com>
Cc: xfs@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xfs: i_state of inode is changed after the inode is freed
In-reply-to: <20060704204145.GU15160733@melbourne.sgi.com>
Message-Id: <20060707214131m-saito@mail.aom.tnes.nec.co.jp>
References: <20060704204145.GU15160733@melbourne.sgi.com>
Mime-Version: 1.0
X-Mailer: WeMail32[2.51] ID:1K0086
From: Masayuki Saito <m-saito@tnes.nec.co.jp>
Date: Fri, 7 Jul 2006 21:41:31 +0900
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for comments.

>You'd be talking about xfs_iunpin(), wouldn't you ;)
Yes, of course.

>http://kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=714250879ea61cdb1a39bb96fe9d934ee0c669a2
>
>This fixed the reproducable test case I had for the problem.
>Can you see if it fixes your problem as well?
We applied the above TAKE to linux-2.6.17.1 and tested it.
However, we confirm the case that i_state of the inode was changed
when the inode was freed in xfs filesystem.

We think that the TAKE reduces the occurrence only.
And we think that our patch fixes the problem.

Could you review our patch again?
