Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261895AbTFFPRI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 11:17:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261906AbTFFPRI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 11:17:08 -0400
Received: from pizda.ninka.net ([216.101.162.242]:15084 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S261895AbTFFPRD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 11:17:03 -0400
Date: Fri, 06 Jun 2003 08:28:02 -0700 (PDT)
Message-Id: <20030606.082802.124082825.davem@redhat.com>
To: wa@almesberger.net
Cc: chas@cmf.nrl.navy.mil, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] use rtnl_{lock,unlock} during device operations
 (take 2)
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030606122616.B3232@almesberger.net>
References: <20030606121339.A3232@almesberger.net>
	<20030606.081618.108808702.davem@redhat.com>
	<20030606122616.B3232@almesberger.net>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Werner Almesberger <wa@almesberger.net>
   Date: Fri, 6 Jun 2003 12:26:16 -0300

   David S. Miller wrote:
   > But regardless I should be able to yank an ATM device out of the
   > kernel (unregistering it) even if there are a thousand VCC's attached
   > to it.
   
   Why ? A VCC is more like a network interface than a TCP
   connection.
   
It's more like an IP tunnel and a route, granted.  And those are
similarly configured, and to me the same rules apply.
   
   Removing an ATM device while there are open VCCs isn't a lot
   more useful than removing a telephone while there is still a
   call in progress :-)
   
It's like rmmod'ing TCP while you have TCP connections.
And it's like unregistering IP tunnels while you still have
routes going over them, the routes just get deleted.

And frankly I see absolutely NOTHING wrong with doing these
sorts of things.
