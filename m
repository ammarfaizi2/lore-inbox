Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751722AbWCMBSs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751722AbWCMBSs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 20:18:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751421AbWCMBSs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 20:18:48 -0500
Received: from mail2.genealogia.fi ([194.100.116.229]:61313 "EHLO
	mail2.genealogia.fi") by vger.kernel.org with ESMTP
	id S1751415AbWCMBSs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 20:18:48 -0500
Date: Sun, 12 Mar 2006 17:15:38 -0800
From: Jouni Malinen <jkmaline@cc.hut.fi>
To: Adrian Bunk <bunk@stusta.de>
Cc: hostap@shmoo.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       linville@tuxdriver.com
Subject: Re: [RFC: 2.6 patch] hostap_hw.c:hfa384x_set_rid(): fix error handling
Message-ID: <20060313011538.GU9383@jm.kir.nu>
Mail-Followup-To: Adrian Bunk <bunk@stusta.de>, hostap@shmoo.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linville@tuxdriver.com
References: <20060309230646.GI21864@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060309230646.GI21864@stusta.de>
User-Agent: Mutt/1.5.11
X-Spam-Score: -2.6 (--)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2006 at 12:06:46AM +0100, Adrian Bunk wrote:

> The Coverity checker noted that the call to prism2_hw_reset() was dead 
> code.
> 
> Does this patch change the code to what was intended?

Thanks! Based on my CVS history, it looks like this was broken in 2002
when the access command was moved from another function and verification
of -ETIMEDOUT value was not moved correctly. The original behavior would
be achieved by changing your patch to call printk first before the moved
prism2_hw_reset(dev) call. I added this (with the re-ordered printk) to
my queue for wireless-2.6.

-- 
Jouni Malinen                                            PGP id EFC895FA
