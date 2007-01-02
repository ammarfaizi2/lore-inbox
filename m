Return-Path: <linux-kernel-owner+w=401wt.eu-S965116AbXABXUj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965116AbXABXUj (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 18:20:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965086AbXABXUj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 18:20:39 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:39502
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S965026AbXABXUh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 18:20:37 -0500
Date: Tue, 02 Jan 2007 15:20:37 -0800 (PST)
Message-Id: <20070102.152037.39159030.davem@davemloft.net>
To: m.kozlowski@tuxland.pl
Cc: hadi@cyberus.ca, netdev@vger.kernel.org, jeff@garzik.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: ifb error path loop fix
From: David Miller <davem@davemloft.net>
In-Reply-To: <200701021149.43365.m.kozlowski@tuxland.pl>
References: <200701020055.51805.m.kozlowski@tuxland.pl>
	<20070101.235132.85409619.davem@davemloft.net>
	<200701021149.43365.m.kozlowski@tuxland.pl>
X-Mailer: Mew version 5.1.52 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Date: Tue, 2 Jan 2007 11:49:42 +0100

> Hello David, 
> 
> > One could argue from a defensive programming perspective that
> > this bug comes from the fact that the ifb_init_one() loop
> > advances state before checking for errors ('i' is advanced before
> > the 'err' check due to the loop construct), and that's why the
> > error recovery code had to be coded specially :-)
> 
> Now when I look at it I might be wrong and it is not a bug at all. 
> It's just coded in weird way. Anyway isn't there kfree(ifbs) missing
> on error path?
> 
> The patch below should clear things a bit (against plain 2.6.20-rc2-mm1).
> 
> Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

Ok, I've removed the original patch from my tree.

I'll let this cleanup sit for a while so others can review
it :-)
