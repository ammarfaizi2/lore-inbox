Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262279AbUGHM7Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262279AbUGHM7Z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 08:59:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262927AbUGHM7Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 08:59:25 -0400
Received: from av3-2-sn4.m-sp.skanova.net ([81.228.10.113]:43170 "EHLO
	av3-2-sn4.m-sp.skanova.net") by vger.kernel.org with ESMTP
	id S262279AbUGHM7T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 08:59:19 -0400
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Can't make use of swap memory in 2.6.7-bk19
References: <m2brir9t6d.fsf@telia.com> <40ECADF8.7010207@yahoo.com.au>
	<20040708023001.GN21066@holomorphy.com>
From: Peter Osterlund <petero2@telia.com>
Date: 08 Jul 2004 14:59:11 +0200
In-Reply-To: <20040708023001.GN21066@holomorphy.com>
Message-ID: <m2briq7izk.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> writes:

> Peter Osterlund wrote:
> >> I created a test program that allocates a 300MB buffer and writes to
> >> all bytes sequentially. On my computer, which has 256MB RAM and 512MB
> >> swap, the program gets OOM killed after dirtying about 140-180MB, and
> >> the kernel reports:
> 
> On Thu, Jul 08, 2004 at 12:14:16PM +1000, Nick Piggin wrote:
> > Someone hand me a paper bag... Peter, can you give this patch a try?
> 
> Heh, one goes in while I'm not looking, and look what happens.

Actually, the failure is caused by this change:

http://linux.bkbits.net:8080/linux-2.5/cset@40db004cKFYB35xMHcRXNijl81BLag?nav=index.html|ChangeSet@-3w

It only fails when /proc/sys/vm/laptop_mode is 1.

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
