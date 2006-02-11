Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751304AbWBKJEI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751304AbWBKJEI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Feb 2006 04:04:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751310AbWBKJEI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Feb 2006 04:04:08 -0500
Received: from smtp.osdl.org ([65.172.181.4]:4062 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751304AbWBKJEF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Feb 2006 04:04:05 -0500
Date: Sat, 11 Feb 2006 01:03:06 -0800
From: Andrew Morton <akpm@osdl.org>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: rlrevell@joe-job.com, miles.lane@gmail.com, linux-kernel@vger.kernel.org,
       linux1394-devel@lists.sourceforge.net, davej@redhat.com
Subject: Re: 2.6.16-rc2-mm1 -- BUG: warning at
 drivers/ieee1394/ohci1394.c:235/get_phy_reg()
Message-Id: <20060211010306.796cd1e2.akpm@osdl.org>
In-Reply-To: <43EDA546.7020103@s5r6.in-berlin.de>
References: <a44ae5cd0602101207s4b2d61d7nc6705067b7913322@mail.gmail.com>
	<20060210122131.4b98cfb4.akpm@osdl.org>
	<1139624931.19342.46.camel@mindpipe>
	<20060210203715.57b39b0d.akpm@osdl.org>
	<43EDA546.7020103@s5r6.in-berlin.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stefan Richter <stefanr@s5r6.in-berlin.de> wrote:
>
> BTW, why not swap the order of expressions:
>  		WARN_ON(!(warned++) && in_irq()); 	\

Because then it'd generate a warning every 4 billionth time through.
