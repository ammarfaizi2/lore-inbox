Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262598AbVCPO0q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262598AbVCPO0q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 09:26:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262601AbVCPO0q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 09:26:46 -0500
Received: from a26.t1.student.liu.se ([130.236.221.26]:62141 "EHLO
	mail.drzeus.cx") by vger.kernel.org with ESMTP id S262598AbVCPOZz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 09:25:55 -0500
Message-ID: <423841EE.9050202@drzeus.cx>
Date: Wed, 16 Mar 2005 15:25:50 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird  (X11/20041216)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: [PATCH][MMC] Bulk transfers (round 2)
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I didn't get any response for this one either ;)

This is only a performance boost so it is less critical. It is very nice
to have though since the performance gain is substancial (>100%).

It should not pose any problems with data loss, which was your primary
concern. It backs down to single block transfers when an error is detected.

This patch has been downloaded almost 500 times and there have been no
errors reported that were related directly to the patch. The two errors
reported from using this was in the driver and with a buggy card (the
same one that needs the power cycle patch).

Kconfig default here is 'no' but 'yes' should be considered once it has
been tested on some more controllers.

Rgds
Pierre
