Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932479AbWAKWq3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932479AbWAKWq3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 17:46:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932482AbWAKWq3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 17:46:29 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:22757
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932479AbWAKWq2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 17:46:28 -0500
Date: Wed, 11 Jan 2006 14:44:22 -0800 (PST)
Message-Id: <20060111.144422.48199200.davem@davemloft.net>
To: pavel@suse.cz
Cc: arjan@infradead.org, akpm@osdl.org, ak@suse.de,
       linux-kernel@vger.kernel.org, sct@redhat.com, mingo@elte.hu
Subject: Re: 2.6.15-git7 oopses in ext3 during LTP runs
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060111224013.GA8277@elf.ucw.cz>
References: <20060111130728.579ab429.akpm@osdl.org>
	<1137014875.2929.81.camel@laptopd505.fenrus.org>
	<20060111224013.GA8277@elf.ucw.cz>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pavel Machek <pavel@suse.cz>
Date: Wed, 11 Jan 2006 23:40:13 +0100

> likely is the evil part here. What about this? Should make this bug
> impossible to do....
> 
> Signed-off-by: Pavel Machek <pavel@suse.cz>

This doesn't let you do:

     if (likely(y) || unlikely(x))

which I have had reason to use in the past.
