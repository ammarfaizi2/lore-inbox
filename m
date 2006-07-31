Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932501AbWGaHGx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932501AbWGaHGx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 03:06:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932504AbWGaHGx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 03:06:53 -0400
Received: from mx1.redhat.com ([66.187.233.31]:9168 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932501AbWGaHGw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 03:06:52 -0400
Date: Mon, 31 Jul 2006 16:06:15 +0900 (JST)
Message-Id: <20060731.160615.122996450.jet@gyve.org>
To: deweerdt@free.fr
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, acme@mandriva.com,
       marcel@holtmann.org
Subject: Re: [01/04 mm-patch, rfc] Add lightweight rwlock
From: Masatake YAMATO <jet@gyve.org>
In-Reply-To: <20060728161515.GA1227@slug>
References: <20060728123246.GB311@slug>
	<20060728.221252.265353941.jet@gyve.org>
	<20060728161515.GA1227@slug>
X-Mailer: Mew version 4.2.53 on Emacs 22.0.50 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> The following set of patches adds a struct lw_rwlock (for lightweight
> rwlock) which contains a spin_lock_t and an atomic_t. It is defined
> in include/linux/lw_rwlock.h.

I think the name, "lightweight" is too generic. It implies just lw_rwlock
is better than rwlock. The name may lead that people use lw_rwlock rather 
than rwlock any place through there are places where rwlock is better than
lw_rwlock. So I looked for the name:

sw_rwlock: seldom writing rwlock
wp_rwlock: write pricey rwlock
rp_rwlock: read prioritized rwlock

If you could find good one, plesae use it instead.

Masatake YAMATO
