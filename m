Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264456AbTFHDwL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 23:52:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264498AbTFHDwL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 23:52:11 -0400
Received: from almesberger.net ([63.105.73.239]:30477 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S264456AbTFHDwL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 23:52:11 -0400
Date: Sun, 8 Jun 2003 01:05:15 -0300
From: Werner Almesberger <wa@almesberger.net>
To: "David S. Miller" <davem@redhat.com>
Cc: chas@cmf.nrl.navy.mil, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] use rtnl_{lock,unlock} during device operations (take 2)
Message-ID: <20030608010515.Q3232@almesberger.net>
References: <20030606211005.H3232@almesberger.net> <200306070057.h570vtsG003449@ginger.cmf.nrl.navy.mil> <20030606221100.L3232@almesberger.net> <20030607.000233.115915549.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030607.000233.115915549.davem@redhat.com>; from davem@redhat.com on Sat, Jun 07, 2003 at 12:02:33AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> So we return long before all references go away, and the final
> netdevice reference put does the de-allocation of the netdevice
> struct.
> 
> Totally asynchronous, and it just works.

Hmm, don't you also need the condition that, after initiating
removal, only operations should succeed that generally work
towards eliminating references ? Otherwise, you could just
put a synchronous layer underneath net devices, and play
pretend.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
