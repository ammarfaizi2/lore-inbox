Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262362AbTFFX2v (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 19:28:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262363AbTFFX2v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 19:28:51 -0400
Received: from [63.205.85.133] ([63.205.85.133]:32743 "EHLO gaz.sfgoth.com")
	by vger.kernel.org with ESMTP id S262362AbTFFX2u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 19:28:50 -0400
Date: Fri, 6 Jun 2003 16:44:42 -0700
From: Mitchell Blank Jr <mitch@sfgoth.com>
To: Werner Almesberger <wa@almesberger.net>
Cc: "David S. Miller" <davem@redhat.com>, chas@cmf.nrl.navy.mil,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] use rtnl_{lock,unlock} during device operations (take 2)
Message-ID: <20030606234442.GI21217@gaz.sfgoth.com>
References: <20030606122616.B3232@almesberger.net> <20030606.082802.124082825.davem@redhat.com> <20030606125416.C3232@almesberger.net> <20030606.085558.56056656.davem@redhat.com> <20030606215406.GE21217@gaz.sfgoth.com> <20030606201906.F3232@almesberger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030606201906.F3232@almesberger.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Werner Almesberger wrote:
> But yes, with a unified VCC table, it certainly makes sense to
> add a hash to validate those pointers. I still think that using
> pointers per se is a good idea, because they're naturally
> unique numbers.

True... it's gross when you have 32-bit userland and a 64-bit kernel but
we already dealt with that pain for sparc64.

> > the ATMSIGD_CTRL ioctl so at least there's no security hole but it's still
> > damn gross (no offense, Werner :-)
> 
> It could probably be used to leverage other security holes in
> atmsigd.

Not really... since atmsigd runs as root it could just as easily
open("/proc/kcore") and go to town.

-Mitch
