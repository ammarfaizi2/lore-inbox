Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269147AbUJFJPZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269147AbUJFJPZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 05:15:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269152AbUJFJPZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 05:15:25 -0400
Received: from gate.crashing.org ([63.228.1.57]:40596 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S269147AbUJFJPM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 05:15:12 -0400
Subject: Re: Netconsole & sungem: hang when link down
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Colin Leroy <colin@colino.net>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       "David S.Miller" <davem@davemloft.net>
In-Reply-To: <20041006104251.29dcd38c@pirandello>
References: <20041006083954.0abefe57@pirandello>
	 <1097050605.21132.17.camel@gaston>  <20041006104251.29dcd38c@pirandello>
Content-Type: text/plain
Message-Id: <1097053738.16741.58.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 06 Oct 2004 19:08:59 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-10-06 at 18:42, Colin Leroy wrote:

> > Not sure, I suppose the driver is doing printk's with spinlocks held
> > from the autoneg stuff and there is a spinlock deadlock happening ...
> 
> Thanks. I'll look into this. If I'm not mistaken, I've got no way of
> catching it easily, do I ? CONFIG_DEBUG_SPINLOCK's help seems to say
> that I need NMI watchdog in order to catch deadlocks, which is only
> available on x86(_64).

Hrm... we have some sort of spinlock debugging, at least on ppc64...

BTW, did you have SMP or PREEMPT ? If none of these, then you should
not see any spin deadlock...

The solution is to look at the code though and find what's wrong :)

Ben.


