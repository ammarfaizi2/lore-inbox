Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932134AbWGKVUN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932134AbWGKVUN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 17:20:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932135AbWGKVUN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 17:20:13 -0400
Received: from terminus.zytor.com ([192.83.249.54]:31467 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S932134AbWGKVUM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 17:20:12 -0400
Message-ID: <44B415FE.1010700@zytor.com>
Date: Tue, 11 Jul 2006 14:19:58 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Nathan Scott <nathans@sgi.com>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] ramdisk blocksize Kconfig entry
References: <20060711171722.E1710004@wobbly.melbourne.sgi.com>
In-Reply-To: <20060711171722.E1710004@wobbly.melbourne.sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan Scott wrote:
> This patch makes the ramdisk blocksize configurable at kernel
> compilation time rather than only at boot or module load time,
> like a couple of the other ramdisk options.  I found this handy
> awhile back but thought little of it, until recently asked by a
> few of the testing folks here to be able to do the same thing
> for their automated test setups.
> 
> The Kconfig comment is largely lifted from comments in rd.c,
> and hopefully this will increase the chances of making folks
> aware that the default value often isn't a great choice here
> (for increasing values of PAGE_SIZE, even moreso).

This seems a bit odd to me... the sizes of most block devices is set by 
the filesystem, not hard-coded; the need for this implies something more 
fundamental is wrong.

	-hpa


