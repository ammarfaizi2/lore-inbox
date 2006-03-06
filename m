Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750794AbWCFLZ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750794AbWCFLZ1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 06:25:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750805AbWCFLZ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 06:25:26 -0500
Received: from penguin.cohaesio.net ([212.97.129.34]:65246 "EHLO
	mail.cohaesio.net") by vger.kernel.org with ESMTP id S1750794AbWCFLZ0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 06:25:26 -0500
Subject: Re: [PATCH] Let DAC960 supply entropy to random pool
From: "Anders K. Pedersen" <akp@cohaesio.com>
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060227000540.GN4650@waste.org>
References: <1140713078.16199.25.camel@homer.cohaesio.com>
	 <20060227000540.GN4650@waste.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Cohaesio A/S
Message-Id: <1141644324.3627.15.camel@homer.cohaesio.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 06 Mar 2006 12:25:24 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-02-27 at 01:05, Matt Mackall wrote:
> On Thu, Feb 23, 2006 at 05:44:38PM +0100, Anders K. Pedersen wrote:
> > We have a couple of servers with Mylex RAID controllers (handled by the
> > DAC960 block device driver). There's normally no keyboard or mouse
> > attached, and neither the DAC960 nor the NIC driver (e100) provides
> > entropy to the random pool, so it was impossible to get any data from
> > /dev/random.
> 
> Doesn't the add_disk_randomness call in ll_rw_blk.c suffice? This is
> the proper path for disks to add entropy.

Apparently the add_disk_randomness call in ll_rw_blk.c isn't invoked for
my setup. There were absolutely no data available from /dev/random for
more than an hour (with heavy disk activity) before applying the
dac960.c patch, and after applying it, random data were instantly
available.

-- 
Med venlig hilsen - Best regards

Anders K. Pedersen
Network Engineer
