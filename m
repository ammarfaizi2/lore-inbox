Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030372AbVKWIzc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030372AbVKWIzc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 03:55:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030373AbVKWIzc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 03:55:32 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:17364
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1030372AbVKWIzc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 03:55:32 -0500
Date: Wed, 23 Nov 2005 00:55:30 -0800 (PST)
Message-Id: <20051123.005530.17893365.davem@davemloft.net>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk, torvalds@osdl.org,
       ak@muc.de
Subject: Re: [NET]: Shut up warnings in net/core/flow.c
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20051123002134.287ff226.akpm@osdl.org>
References: <200511230159.jAN1xeMl003154@hera.kernel.org>
	<20051123002134.287ff226.akpm@osdl.org>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Morton <akpm@osdl.org>
Date: Wed, 23 Nov 2005 00:21:34 -0800

> Nope, this will break !CONFIG_SMP builds.  Quite a few places in the
> kernel do not implement the ipi handler if !CONFIG_SMP.

Ho hum, nothing is ever easy eh? :-) I think your patch is fine for
now, but in the long term the !CONFIG_SMP ifdefs for those ipi
handlers should probably just get removed.  If GCC can't optimize
those things away, I'd be really surprised.
