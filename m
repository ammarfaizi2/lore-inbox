Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751312AbVK2HCq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751312AbVK2HCq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 02:02:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751329AbVK2HCp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 02:02:45 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:41361
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751312AbVK2HCp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 02:02:45 -0500
Date: Mon, 28 Nov 2005 23:02:24 -0800 (PST)
Message-Id: <20051128.230224.36483799.davem@davemloft.net>
To: kjak@users.sourceforge.net, kjak@ispwest.com
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH] Resetting packet statistics
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <d0d8bf3880744a79a8a5c26c8459e9ac.kjak@ispwest.com>
References: <d0d8bf3880744a79a8a5c26c8459e9ac.kjak@ispwest.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Kris Katterjohn" <kjak@ispwest.com>
Date: Mon, 28 Nov 2005 22:28:18 -0800

> From: David S. Miller
> Sent: 11/28/2005 10:12:38 PM
> > You can't change existing behavior in order to get the new behavior
> > you want.  Some applications might be depending upon what happens
> > currently.
> 
> Is there a way to work around this?

Why not create a new call that doesn't reset the statistic,
and change your application to invoke it instead of the call
which exists?

That's one backwards compatible way to fix things like this.

Or, you can create a new call that says "from now on, do not
reset statistics on calls using this socket."  That's another
clean, and backwards compatible way, to deal with this
kind of issue.
