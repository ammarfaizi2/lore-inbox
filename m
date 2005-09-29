Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932481AbVI2Vx6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932481AbVI2Vx6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 17:53:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932418AbVI2Vx6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 17:53:58 -0400
Received: from smtp.osdl.org ([65.172.181.4]:40680 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932516AbVI2Vx5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 17:53:57 -0400
Date: Thu, 29 Sep 2005 14:54:00 -0700
From: Andrew Morton <akpm@osdl.org>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux-kernel@vger.kernel.org, ck@vds.kolivas.org
Subject: Re: [PATCH] vm - swap_prefetch v12
Message-Id: <20050929145400.1cc2b748.akpm@osdl.org>
In-Reply-To: <200509300115.33060.kernel@kolivas.org>
References: <200509300115.33060.kernel@kolivas.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas <kernel@kolivas.org> wrote:
>
> Once pages have been added to the swapped list, a timer is started, testing
> for conditions suitable to prefetch swap pages every 5 seconds. Suitable
> conditions are defined as lack of swapping out or in any pages, and no
> watermark tests failing. Significant amounts of dirtied ram also prevent
> prefetching. It then checks that we have spare ram looking for at
> least 3* pages_high free per zone and if it succeeds that will prefetch
> pages from swap.

Did you consider poking around in gendisk.disk_stats to determine whether
the swap disk(s) are idleish?
