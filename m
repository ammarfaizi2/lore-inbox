Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751353AbVKSEhm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751353AbVKSEhm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 23:37:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751367AbVKSEhl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 23:37:41 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:59318
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751353AbVKSEhl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 23:37:41 -0500
Date: Fri, 18 Nov 2005 20:37:07 -0800 (PST)
Message-Id: <20051118.203707.129707514.davem@davemloft.net>
To: alan@lxorguk.ukuu.org.uk
Cc: Markus.Lidel@shadowconnect.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] I2O: SPARC fixes
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <1132371039.5238.14.camel@localhost.localdomain>
References: <437E7ADB.5080200@shadowconnect.com>
	<20051118.172230.126076770.davem@davemloft.net>
	<1132371039.5238.14.camel@localhost.localdomain>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Sat, 19 Nov 2005 03:30:39 +0000

> On Gwe, 2005-11-18 at 17:22 -0800, David S. Miller wrote:
> > Ho hum, I guess keep it a config option for now until we find a
> > way to auto-detect this reliably.
> 
> The notify functionality is mandatory. You are seeing the same cards
> fail on sparc but work on x86. This sounds to me a lot more like an
> unfound endian bug that needs fixing than a real lack of support

That's very possible, but it also could be that the cards
that fail only on Sparc have Sun forth firmware on them,
which would thus only load firmware on Sparc boxes.

I still think the endianness theory is more likely, however.

Perhaps the I2O datastructures should be endian annotated
and then pushed through sparse. :-)
