Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261808AbTFFPlB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 11:41:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261852AbTFFPlB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 11:41:01 -0400
Received: from almesberger.net ([63.105.73.239]:15625 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S261808AbTFFPlA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 11:41:00 -0400
Date: Fri, 6 Jun 2003 12:54:16 -0300
From: Werner Almesberger <wa@almesberger.net>
To: "David S. Miller" <davem@redhat.com>
Cc: chas@cmf.nrl.navy.mil, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] use rtnl_{lock,unlock} during device operations (take 2)
Message-ID: <20030606125416.C3232@almesberger.net>
References: <20030606121339.A3232@almesberger.net> <20030606.081618.108808702.davem@redhat.com> <20030606122616.B3232@almesberger.net> <20030606.082802.124082825.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030606.082802.124082825.davem@redhat.com>; from davem@redhat.com on Fri, Jun 06, 2003 at 08:28:02AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> It's more like an IP tunnel and a route, granted.

Even with the route, the destination can remain "fixed".
The VCC only makes sense in the context of the device, which
is fully visible to the user. (It's different in the case of
SVCs, but they're managed by a user space demon. Besides, if
their device goes away, they die too.)

> And those are
> similarly configured, and to me the same rules apply.

Why do you care ? That part of the current design is
technically adequate and reasonably simple. Littering the
code with asynchronous code paths would only make it more
complex.

(If you want to keep Chas busy, the communication between
the kernel and its demons may be a much more interesting
topic ;-)

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
