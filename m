Return-Path: <linux-kernel-owner+w=401wt.eu-S965262AbXAKAnV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965262AbXAKAnV (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 19:43:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965263AbXAKAnV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 19:43:21 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:52660
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S965262AbXAKAnV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 19:43:21 -0500
Date: Wed, 10 Jan 2007 16:43:20 -0800 (PST)
Message-Id: <20070110.164320.12186318.davem@davemloft.net>
To: neilb@suse.de
Cc: jafo@tummy.com, linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: PATCH - x86-64 signed-compare bug, was Re: select() setting
 ERESTARTNOHAND (514).
From: David Miller <davem@davemloft.net>
In-Reply-To: <17829.34481.340913.519675@notabene.brown>
References: <20070110234238.GB10791@tummy.com>
	<17829.34481.340913.519675@notabene.brown>
X-Mailer: Mew version 5.1.52 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Neil Brown <neilb@suse.de>
Date: Thu, 11 Jan 2007 11:37:05 +1100

> On x86-64, regs->rax is "unsigned long", so the following is
> needed....
> 
> I haven't tried it yet.

Doesn't type promotion take care of that?  Did you verify
that assember?

I checked the assembler on sparc64 for similar constructs
and it does the right thing.
