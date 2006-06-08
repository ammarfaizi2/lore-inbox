Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964905AbWFHQ6j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964905AbWFHQ6j (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 12:58:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964910AbWFHQ6j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 12:58:39 -0400
Received: from wildsau.enemy.org ([193.170.194.34]:36252 "EHLO
	wildsau.enemy.org") by vger.kernel.org with ESMTP id S964905AbWFHQ6j
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 12:58:39 -0400
From: Herbert Rosmanith <kernel@wildsau.enemy.org>
Message-Id: <200606081653.k58Gr7IB010654@wildsau.enemy.org>
Subject: Q on packetwriting to DVD+R, DVD-R
To: linux-kernel@vger.kernel.org
Date: Thu, 8 Jun 2006 18:53:07 +0200 (MET DST)
CC: Herbert Rosmanith <kernel@wildsau.enemy.org>
X-Mailer: ELM [version 2.4ME+ PL100 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


good afternoon,

I have a question concerning cdrom packet writing. I simply
cannot figure out if packet writing supports write once
media like DVD-R, DVD+R too. The docs always speak of
rewriteable media like CD-RW, DVD+RW, DVD-RW, but not about
media without W.

Also, trying to "mkudffs /dev/pktcdvd/cd0" on a non-rewriteable
DVD will fail with an error-message:
"trying to change type of multiple extents".

Reading through <linux/drivers/block/pktcdvd.c>, I get the
impression that only CD-RW, case 0x13: /* DVD-RW */
                case 0x1a: /* DVD+RW */
                case 0x12: /* DVD-RAM */

can be used that way = make an udf fs on the media and
copy files to it.

I this correct?

kind regards,
h.rosmanith
