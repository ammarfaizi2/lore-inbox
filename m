Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264647AbUGNNlz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264647AbUGNNlz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 09:41:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267384AbUGNNlz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 09:41:55 -0400
Received: from sv1.valinux.co.jp ([210.128.90.2]:39355 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S264647AbUGNNly (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 09:41:54 -0400
Date: Wed, 14 Jul 2004 22:41:38 +0900 (JST)
Message-Id: <20040714.224138.95803956.taka@valinux.co.jp>
To: linux-kernel@vger.kernel.org, lhms-devel@lists.sourceforge.net
Cc: linux-mm@kvack.org
Subject: [PATCH] memory hotremoval for linux-2.6.7 [0/16]
From: Hirokazu Takahashi <taka@valinux.co.jp>
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm pleased to say I've cleaned up the memory hotremoval patch
Mr. Iwamoto implemented. Part of ugly code has gone.

Main changes are:

  - Replaced the name remap with mmigrate as it was used for
    another fuctionality.

  - Made some of the memory hotremoval code share with the swapout-code.

  - Added many comments to describe the design of the memory hotremoval.

  - Added a basic funtion to support for memsection.
    try_to_migrate_page() is it. It continues to get a proper page
    in a specified section and migrate it while there remain pages
    in the section.

The patches are against linux-2.6.7.

Note that some patches are to fix bugs. Without the patches hugetlbpage
migration won't work.

Thanks,
Hirokazu Takahashi.

