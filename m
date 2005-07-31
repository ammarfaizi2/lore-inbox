Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263147AbVGaAdu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263147AbVGaAdu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 20:33:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263144AbVGaAdu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 20:33:50 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:19893
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S263136AbVGaAds (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 20:33:48 -0400
Date: Sat, 30 Jul 2005 17:33:52 -0700 (PDT)
Message-Id: <20050730.173352.41656851.davem@davemloft.net>
To: dmitry_yus@yahoo.com
Cc: James.Bottomley@SteelEye.com, itn780@yahoo.com, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org, hch@lst.de
Subject: Re: [ANNOUNCE 0/7] Open-iSCSI/Linux-iSCSI-5 High-Performance
 Initiator
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <1122758728.13559.4.camel@mylaptop>
References: <20050730.125312.78734701.davem@davemloft.net>
	<1122755000.5055.31.camel@mulgrave>
	<1122758728.13559.4.camel@mylaptop>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Yusupov <dmitry_yus@yahoo.com>
Date: Sat, 30 Jul 2005 14:25:28 -0700

> It would be nice to set MAX_LINKS to 64 and close this issue for now,

James and Dmitry, increasing MAX_LINKS does't work, did you actually
try to open a netlink socket with a protocol number larger than 32?

It will not work.  Don't you think I'd implement such a simple fix to
expand the protocol number space if it was that easy? :-)

You can't increase MAX_LINKS past 32 because this is also the value of
NPROTO.  It is impossible to create a new socket with a protocol value
larger than NPROTO, and this value is exported into userspace as well.
