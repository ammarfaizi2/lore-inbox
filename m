Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264653AbSKVL7p>; Fri, 22 Nov 2002 06:59:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264657AbSKVL7p>; Fri, 22 Nov 2002 06:59:45 -0500
Received: from holomorphy.com ([66.224.33.161]:41093 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S264653AbSKVL7o>;
	Fri, 22 Nov 2002 06:59:44 -0500
Date: Fri, 22 Nov 2002 04:00:49 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Manish Lachwani <manish@Zambeel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.17 SMP hangs ..
Message-ID: <20021122120049.GV11776@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Manish Lachwani <manish@Zambeel.com>, linux-kernel@vger.kernel.org
References: <233C89823A37714D95B1A891DE3BCE5202AB1975@xch-a.win.zambeel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <233C89823A37714D95B1A891DE3BCE5202AB1975@xch-a.win.zambeel.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2002 at 09:28:06PM -0800, Manish Lachwani wrote:
> I am seeing system hangs with 2.4.17 SMP kernel when doing mke2fs accros 12
> drives in parallel. However, the hangs only occur when the I/O rate from
> vmstat is high:

This is the BKL/irqlock/io_request_lock contention issue. 2.5.x is
the only answer here: it has per-queue locking and has removed the
irqlock from the BKL.


Bill
