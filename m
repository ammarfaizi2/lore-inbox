Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261852AbTFFPpA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 11:45:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261872AbTFFPpA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 11:45:00 -0400
Received: from pizda.ninka.net ([216.101.162.242]:27884 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S261852AbTFFPo7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 11:44:59 -0400
Date: Fri, 06 Jun 2003 08:55:58 -0700 (PDT)
Message-Id: <20030606.085558.56056656.davem@redhat.com>
To: wa@almesberger.net
Cc: chas@cmf.nrl.navy.mil, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] use rtnl_{lock,unlock} during device operations
 (take 2)
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030606125416.C3232@almesberger.net>
References: <20030606122616.B3232@almesberger.net>
	<20030606.082802.124082825.davem@redhat.com>
	<20030606125416.C3232@almesberger.net>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Werner Almesberger <wa@almesberger.net>
   Date: Fri, 6 Jun 2003 12:54:16 -0300

   David S. Miller wrote:
   > And those are
   > similarly configured, and to me the same rules apply.
   
   Why do you care ?

Because ATM devices have always been "funny", and there
is so much infrastructure, and frankly sanity, they can
share by being more netdevice like.

All the lack of proper SMP locking and races are a result
of ATM devices being different and not being fixed up
when we did all of the SMP work for netdevices.

Chas has to do a lot of work now that would not have been
necessary.

   (If you want to keep Chas busy, the communication between
   the kernel and its demons may be a much more interesting
   topic ;-)
   
Tell me it at least uses netlink ;(
