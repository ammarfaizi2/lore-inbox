Return-Path: <linux-kernel-owner+w=401wt.eu-S1753685AbWLWTP6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753685AbWLWTP6 (ORCPT <rfc822;w@1wt.eu>);
	Sat, 23 Dec 2006 14:15:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753690AbWLWTP5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Dec 2006 14:15:57 -0500
Received: from ppp85-141-207-24.pppoe.mtu-net.ru ([85.141.207.24]:37026 "EHLO
	gw.home.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753683AbWLWTP5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Dec 2006 14:15:57 -0500
From: Alex Tomas <alex@clusterfs.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: David Chinner <dgc@sgi.com>, Alex Tomas <alex@clusterfs.com>,
       linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] delayed allocation for ext4
Organization: CFS
References: <m37iwjwumf.fsf@bzzz.home.net>
	<20061223033123.GL44411608@melbourne.sgi.com>
	<20061223092718.GA26276@infradead.org>
X-Comment-To: Christoph Hellwig
Date: Sat, 23 Dec 2006 22:15:43 +0300
In-Reply-To: <20061223092718.GA26276@infradead.org> (Christoph Hellwig's
	message of "Sat\, 23 Dec 2006 09\:27\:18 +0000")
Message-ID: <m3vek2todc.fsf@bzzz.home.net>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> Christoph Hellwig (CH) writes:

 CH> Note that recording delayed alloc state at a page granularity in addition
 CH> to just the buffer heads has a lot of advantages aswell and would help
 CH> xfs, too.  But I think it makes a lot more sense to record it as a radix
 CH> tree tag to speed up the gang lookups for delalloc conversion.

please, exaplein about radix tree tag. in ext4-delalloc I use this
bit the only way - to avoid multiple reservation space for same
page. I guess you need to find non-allocated pages. probably to
flush them and update number of reserved blocks in case of -ENOSPC?

thanks, Alex
