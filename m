Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030207AbVKVWhO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030207AbVKVWhO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 17:37:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965079AbVKVWhO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 17:37:14 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:50075
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S965073AbVKVWg6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 17:36:58 -0500
Date: Tue, 22 Nov 2005 14:37:13 -0800 (PST)
Message-Id: <20051122.143713.101129339.davem@davemloft.net>
To: kaber@trash.net
Cc: bunk@stusta.de, evil@g-house.de, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, zippel@linux-m68k.org
Subject: Re: [2.6 patch] do not select NET_CLS
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <4381F2D2.5000605@trash.net>
References: <20051116235813.GS5735@stusta.de>
	<20051121155955.GW16060@stusta.de>
	<4381F2D2.5000605@trash.net>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick McHardy <kaber@trash.net>
Date: Mon, 21 Nov 2005 17:16:18 +0100

> Adrian Bunk wrote:
> > This patch therefore changes NET_CLS back to the 2.6.14 status quo of 
> > being an user-visible option.
> 
> I disagree with this patch. NET_CLS enables the infrastructure support
> for classifiers. Users generally don't care about infrastructure but
> directly usable things, so I'd prefer to have it automatically selected. 
> And there are lots of other cases where enabling a module causes changes
> in the kernel image. Some examples include some of the netfilter stuff,
> the IPsec transforms, NET_CLS_ROUTE4, the ieee80211 stuff, and a lot
> more.

I agree with Patrick.

Changing config options of any kind can result in the main kernel
image needing to be rebuilt.  One thing we can do to prevent human
mistakes, is to make the "make modules" pass do a quick "is vmlinux
uptodate?" check, and if not print out an error message explaining the
situation and aborting the "make modules" attempt.
