Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269122AbUJFIXF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269122AbUJFIXF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 04:23:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269091AbUJFIXE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 04:23:04 -0400
Received: from gate.crashing.org ([63.228.1.57]:20116 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S269121AbUJFIWz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 04:22:55 -0400
Subject: Re: Netconsole & sungem: hang when link down
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Colin Leroy <colin@colino.net>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       "David S.Miller" <davem@davemloft.net>
In-Reply-To: <20041006083954.0abefe57@pirandello>
References: <20041006083954.0abefe57@pirandello>
Content-Type: text/plain
Message-Id: <1097050605.21132.17.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 06 Oct 2004 18:16:45 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-10-06 at 16:39, Colin Leroy wrote:
> Hi,
> 
> I noticed that, if you have netconsole set up and using a sungem card,
> and if the network cable is not plugged in, that the whole kernel hangs
> shortly after the "device not up yet, forcing it" netconsole
> message. I suspect this is due to the autoneg in sungem, but didn't have
> time to look further. 
> 
> Would you have any hints on the cause of this problem?

Not sure, I suppose the driver is doing printk's with spinlocks held
from the autoneg stuff and there is a spinlock deadlock happening ...

Ben.


