Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750816AbVK0CtI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750816AbVK0CtI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Nov 2005 21:49:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750826AbVK0CtI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Nov 2005 21:49:08 -0500
Received: from teetot.devrandom.net ([66.35.250.243]:59031 "EHLO
	teetot.devrandom.net") by vger.kernel.org with ESMTP
	id S1750816AbVK0CtG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Nov 2005 21:49:06 -0500
Date: Sat, 26 Nov 2005 18:52:21 -0800
From: thockin@hockin.org
To: Larry Finger <Larry.Finger@lwfinger.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: What are the general causes of frozen system?
Message-ID: <20051127025221.GA30646@hockin.org>
References: <43891D97.4000404@lwfinger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43891D97.4000404@lwfinger.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> What should I consider as a cause of the freeze? I have reviewed the 
> code and do not find any obvious out-of-bounds memory references. I have 
> tried various 'printk' statements, but none of them in the bottom-half 
> interrupt routine make it to the logs. Are there any tricks that I 
> should try?

Look for lock-related deadlocks.  Try turning on the nmi watchdog
