Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272279AbTHIBQP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 21:16:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272264AbTHIBMh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 21:12:37 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:14724 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S272230AbTHIBKS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 21:10:18 -0400
Date: Sat, 9 Aug 2003 02:09:50 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Szakacsits Szabolcs <szaka@sienet.hu>
Cc: Andrew Morton <akpm@osdl.org>, Grant Miner <mine0057@mrs.umn.edu>,
       linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: Filesystem Tests
Message-ID: <20030809010950.GD26375@mail.jlokier.co.uk>
References: <20030805224152.528f2244.akpm@osdl.org> <Pine.LNX.4.30.0308061222360.8473-100000@divine.city.tvnet.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.30.0308061222360.8473-100000@divine.city.tvnet.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Szakacsits Szabolcs wrote:
> I run the results through some scripts to make it more readable.

I think that instead of giving the CPU percentage, you should give the
CPU time used:

	CPU time used = CPU percentage * total time

This would give a more accurate measure of how much CPU is used by the
different filesystems.  As someone said, if certain operations are
faster with reiser4, you expect a greater percentage of CPU time to be
spent in the disk driver etc. - if the amount of I/O is the same, that is.

Another interesting statistic would be the number of blocks read and
written during the test.

-- Jamie
