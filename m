Return-Path: <linux-kernel-owner+w=401wt.eu-S933262AbXAAItI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933262AbXAAItI (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 03:49:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933260AbXAAItI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 03:49:08 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:40338
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S933258AbXAAItH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 03:49:07 -0500
Date: Mon, 01 Jan 2007 00:49:05 -0800 (PST)
Message-Id: <20070101.004905.98552337.davem@davemloft.net>
To: daniel.marjamaki@gmail.com
Cc: netdev@vger.kernel.org, kernel-janitors@lists.osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/core/flow.c: compare data with memcmp
From: David Miller <davem@davemloft.net>
In-Reply-To: <80ec54e90612312347w2b906e5eg725a7761110c6897@mail.gmail.com>
References: <80ec54e90612310837y786fd764oc18bf37c8f0b2b8c@mail.gmail.com>
	<20061231.123715.115911390.davem@davemloft.net>
	<80ec54e90612312347w2b906e5eg725a7761110c6897@mail.gmail.com>
X-Mailer: Mew version 5.1.52 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Daniel_Marjamäki" <daniel.marjamaki@gmail.com>
Date: Mon, 1 Jan 2007 08:47:48 +0100

> So you mean that in this particular case it's faster with a handcoded
> comparison than memcmp? Because both key1 and key2 are located at
> word-aligned addresses?
> That's fascinating.

Essentially, yes.

However, I wonder.  GCC should be able to see this also, and
if it expands the memset() inline the code emitted should be
very similar.

It is something to investigate on a few cpu types, for sure.
