Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267549AbUJWECc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267549AbUJWECc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 00:02:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269200AbUJWEBh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 00:01:37 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:17118 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267549AbUJWD5L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 23:57:11 -0400
Subject: Re: printk() with a spin-lock held.
From: Lee Revell <rlrevell@joe-job.com>
To: root@chaos.analogic.com
Cc: Linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0410221504500.6075@chaos.analogic.com>
References: <Pine.LNX.4.61.0410221504500.6075@chaos.analogic.com>
Content-Type: text/plain
Date: Fri, 22 Oct 2004 23:56:55 -0400
Message-Id: <1098503815.13176.2.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-22 at 15:07 -0400, Richard B. Johnson wrote:
> Linux-2.6.9 will bug-check and halt if my code executes
> a printk() with a spin-lock held.
> 
> Is this the intended behavior?

Yes.  printk() can sleep.  No sleeping with a spinlock held.

> If so, NotGood(tm).

See above.  If you think you can improve the situation, patches are
welcome, as always.

Lee

