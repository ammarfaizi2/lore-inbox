Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269658AbUJABM7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269658AbUJABM7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 21:12:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269656AbUJABM7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 21:12:59 -0400
Received: from rproxy.gmail.com ([64.233.170.207]:33259 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S269658AbUJABMz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 21:12:55 -0400
Message-ID: <f8ca0a150409301812f2da74d@mail.gmail.com>
Date: Thu, 30 Sep 2004 18:12:55 -0700
From: Roland Dreier <roland.list@gmail.com>
Reply-To: Roland Dreier <roland.list@gmail.com>
To: Lars Marowsky-Bree <lmb@suse.de>
Subject: Re: Hard lockup on IBM ThinkPad T42
Cc: Martin Hermanowski <martin@mh57.de>, linux-thinkpad@linux-thinkpad.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20040930222712.GB4607@marowsky-bree.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <f8ca0a1504093011206230ddea@mail.gmail.com>
	 <20040930205851.GA6911@mh57.de>
	 <f8ca0a1504093014456cf072a1@mail.gmail.com>
	 <20040930222712.GB4607@marowsky-bree.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Can you confirm that it happens mostly when X has dropped into the
> screensaver and tries to come back?

I'm not sure.  I've definitely seen it frozen in the screensaver a few
times (not necessarily when it tries to come back -- I've seen the
screensaver stuck as well).  However, I did get a freeze just using
the console, and I've also gotten a freeze with the screensaver set to
just blank.

I guess right now I'm most suspicious about the following things:
 - radeon driver.  I've switched from radeonfb to vesafb and still had hangs
   X11 ati driver still could be an issue
 - ipw2200 driver
 - interrupt sharing (everything seems to be wired to IRQ 11)

Unfortunately since I haven't been able to get _any_ post-hang
debugging info it's hard to make progress debugging.

Thanks,
  Roland
