Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261969AbTFFQ1m (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 12:27:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261970AbTFFQ1l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 12:27:41 -0400
Received: from almesberger.net ([63.105.73.239]:27913 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S261969AbTFFQ1k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 12:27:40 -0400
Date: Fri, 6 Jun 2003 13:40:49 -0300
From: Werner Almesberger <wa@almesberger.net>
To: "David S. Miller" <davem@redhat.com>
Cc: chas@cmf.nrl.navy.mil, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] use rtnl_{lock,unlock} during device operations (take 2)
Message-ID: <20030606134049.D3232@almesberger.net>
References: <20030606122616.B3232@almesberger.net> <20030606.082802.124082825.davem@redhat.com> <20030606125416.C3232@almesberger.net> <20030606.085558.56056656.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030606.085558.56056656.davem@redhat.com>; from davem@redhat.com on Fri, Jun 06, 2003 at 08:55:58AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> Because ATM devices have always been "funny", and there
> is so much infrastructure, and frankly sanity, they can
> share by being more netdevice like.

Yes, and I agree that it's important that this gets fixed.
Also, the code was basically unmaintained for about two
years, and that shows.

I'm just pointing out that "asynchronizing" some internal
process that is perfectly happy with being synchronous
(and consistent with the semantics of ATM, which themselves
are quite "funny" most of the time) strikes me as a not
very helpful move.

> Tell me it at least uses netlink ;(

Nope, pure DIY. Actually, I think at the time when I wrote
that stuff ('95), SIOC* still ruled the world ...

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
