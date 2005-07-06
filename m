Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261652AbVGFUPW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261652AbVGFUPW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 16:15:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262215AbVGFUNz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 16:13:55 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:18096
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S262438AbVGFT53 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 15:57:29 -0400
Date: Wed, 06 Jul 2005 12:57:19 -0700 (PDT)
Message-Id: <20050706.125719.08321870.davem@davemloft.net>
To: pmarques@grupopie.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Slowdown with randomize_va_space in 2.6.12.2
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <42CBE97C.2060208@grupopie.com>
References: <42CBE97C.2060208@grupopie.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paulo Marques <pmarques@grupopie.com>
Date: Wed, 06 Jul 2005 15:23:56 +0100

> What is weird is that most of the extra time is being accounted as 
> user-space time, but the user-space application is exactly the same in 
> both runs, only the "randomize_va_space" parameter changed.

It might be attributable to more cpu cache misses in userspace since
the virtual addresses of everything are changing each and every
invocation.

But 2 seconds more of execution time is quite a lot.
