Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263806AbUE1TG5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263806AbUE1TG5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 15:06:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263817AbUE1TG4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 15:06:56 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:62457 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S263806AbUE1TGo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 15:06:44 -0400
Message-ID: <40B78DB6.1070003@mvista.com>
Date: Fri, 28 May 2004 12:06:30 -0700
From: Todd Poynor <tpoynor@mvista.com>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Bill C. Riemers" <docbill@freeshell.org>
CC: tytso@mit.edu, busybox@mail.codepoet.org, linux-kernel@vger.kernel.org
Subject: Re: [BusyBox] Re: [PATCH] BLKFLSBUF on ramdisks
References: <20040527231932.GD7176@slurryseal.ddns.mvista.com> <003001c444b5$ff72cee0$64fda287@docbill002>
In-Reply-To: <003001c444b5$ff72cee0$64fda287@docbill002>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill C. Riemers wrote:
> Does this problem also effect the 2.4 kernels?
> 
> I'm just wondering, because it sounds like a possible explination for
> strange errors occurring with /dev/cobd? in coLinux, especially when used as
> swap devices.  Basically /dev/cobd? are simmular to ramdisks, but they
> refere to files mmap'ed under Windows.  They work fairly reliable, until
> someone does something like "swapoff -a;swapon -a".  However, coLinux is
> only used with 2.4 kernels, so if the problem does not effect 2.4 kernels,
> then this is not the cause.

Yes, Matt Porter previously determined that this behavior changed 
sometime after 2.4.2 and on or before 2.4.17, when rd.c was modified to 
perform a truncate_inode_pages() for BLKFLSBUF (could track down the 
date/revision more accurately if you're interested).

-- 
Todd
