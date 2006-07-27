Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932109AbWG0KLa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932109AbWG0KLa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 06:11:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932554AbWG0KLa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 06:11:30 -0400
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:47296 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S932109AbWG0KL3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 06:11:29 -0400
Date: Thu, 27 Jul 2006 12:11:28 +0200
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [WARNING -mm] 2.6.18-rc2-mm1 build kills /dev/null!?
Message-ID: <20060727101128.GA31920@rhlx01.fht-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

for some reason a 2.6.18-rc2-mm1 build seems to kill my /dev/null device!

A simple
# make bzImage modules modules_install
managed to reduce my

crw-rw-rw-    1 root     root       1,   3 27. Jul 12:04 null

into the charred remains equivalent of

-rw-r--r--    1 root     root            0 27. Jul 12:02 null

, *twice* (I tried it the first time and had that issue,
then rebuilt the device and rebooted, same problem once build started).

Any idea why this might happen?

This did not happen with a 2.6.18-rc1-mm2 build.

A simple

rm /dev/null
mknod /dev/null c 1 3
chmod 666 /dev/null

corrects the problem, BTW.

Thanks,

Andreas Mohr
