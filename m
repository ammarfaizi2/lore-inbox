Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284886AbRLKDnI>; Mon, 10 Dec 2001 22:43:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284874AbRLKDnA>; Mon, 10 Dec 2001 22:43:00 -0500
Received: from mail.igrin.co.nz ([202.49.244.12]:36111 "EHLO mail.igrin.co.nz")
	by vger.kernel.org with ESMTP id <S284875AbRLKDmn>;
	Mon, 10 Dec 2001 22:42:43 -0500
Message-Id: <3.0.6.32.20011211164149.00b7ba20@mail.igrin.co.nz>
X-Mailer: QUALCOMM Windows Eudora Light Version 3.0.6 (32)
Date: Tue, 11 Dec 2001 16:41:49 +1300
To: linux-kernel@vger.kernel.org
From: Simon Byrnand <simon@igrin.co.nz>
Subject: Bug in disk Quota's on 2.2.19 (and maybe other kernels) ?
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone, please CC any replies as I'm not on the list.

I've just started using Disk Quotas with Redhat 6.2, and 2.2.19 kernel, ext2.

Everything is working ok except I notice an anomoly - if I have an apache
log file (which is kept open while apache is running) which is owned by a
normal user account, and I chown it to root, the quotas are not updated to
reflect the fact that the user who used to own the file should have less
space "used" from their quota. There should be a decrease in the amount of
space used in their quota by the size of the file.

If I then chown the file back to them again there *is* an increase in space
used on their quota. chowning the file back to root again a second time
*does* cause a decrease in space used from their quota, but only back to
the previous incorrect amount.

If I then run quotacheck -avug to force a manual refresh of all the quotas,
the discrepancy is corrected.

Whats going on here ? Is the quota code buggy ? Is this something which has
been fixed in 2.4 ?

Not having used quotas under Linux before I don't know if I'm missing
something obvious.

Regards,
Simon


