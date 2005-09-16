Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161170AbVIPT51@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161170AbVIPT51 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 15:57:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161187AbVIPT51
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 15:57:27 -0400
Received: from mx1.redhat.com ([66.187.233.31]:23237 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1161170AbVIPT50 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 15:57:26 -0400
Date: Fri, 16 Sep 2005 15:57:15 -0400 (EDT)
Message-Id: <20050916.155715.74748747.davem@redhat.com>
To: kloczek@rudy.mif.pg.gda.pl
Cc: davem@davemloft.net, linux-kernel@vger.kernel.org,
       sparclinux@vger.kernel.org, aurora-sparc-devel@lists.auroralinux.org
Subject: Re: [2.6.14-rc1/sparc54]: BUG: soft lockup detected on CPU#0!
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.BSO.4.62.0509161405550.5000@rudy.mif.pg.gda.pl>
References: <Pine.BSO.4.62.0509151929580.5000@rudy.mif.pg.gda.pl>
	<20050915.133026.21581824.davem@davemloft.net>
	<Pine.BSO.4.62.0509161405550.5000@rudy.mif.pg.gda.pl>
X-Mailer: Mew version 4.2.52 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomasz K³oczko <kloczek@rudy.mif.pg.gda.pl>
Date: Fri, 16 Sep 2005 14:42:56 +0200 (CEST)

> Also I have question about second (hw tcp v4 csum failed):
...
> As you see in both errors is "0". Is this correct reporting broken packets 
> in kernel messages instead in RX errors ?

It is protocol level error, therefore it is not counted
in raw device level statistics.

BTW, when you get the "hw tcp v4 csum failed", the kernel ignores
the hw checksum and rechecks it using software.
