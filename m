Return-Path: <linux-kernel-owner+w=401wt.eu-S1753677AbWLWTKL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753677AbWLWTKL (ORCPT <rfc822;w@1wt.eu>);
	Sat, 23 Dec 2006 14:10:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753683AbWLWTKL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Dec 2006 14:10:11 -0500
Received: from ppp85-141-207-24.pppoe.mtu-net.ru ([85.141.207.24]:60414 "EHLO
	gw.home.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753677AbWLWTKJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Dec 2006 14:10:09 -0500
From: Alex Tomas <alex@clusterfs.com>
To: David Chinner <dgc@sgi.com>
Cc: Alex Tomas <alex@clusterfs.com>, linux-ext4@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] delayed allocation for ext4
Organization: CFS
References: <m37iwjwumf.fsf@bzzz.home.net>
	<20061223033123.GL44411608@melbourne.sgi.com>
X-Comment-To: David Chinner
Date: Sat, 23 Dec 2006 22:09:57 +0300
In-Reply-To: <20061223033123.GL44411608@melbourne.sgi.com> (David Chinner's
	message of "Sat\, 23 Dec 2006 14\:31\:23 +1100")
Message-ID: <m3zm9etomy.fsf@bzzz.home.net>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Good day,

>>>>> David Chinner (DC) writes:

 DC> So that mean's we'll have 2 separate mechanisms for marking
 DC> pages as delalloc. XFS uses the BH_delay flag to indicate
 DC> that a buffer (block) attached to the page is using delalloc.

well, for blocksize=pagesize we can save 56 bytes on every page.

 DC> FWIW, how does this mechanism deal with block size < page size?
 DC> Don't you have to track delalloc on a block basis rather than
 DC> a page basis?

I'm still thinking how better to deal with that w/o much code duplication.

 DC> Ah, that's why you can get away with a page flag - you've ignored
 DC> the partial page delay state problem. Any plans to use the
 DC> existing method in the future so we will be able to use ext4 delalloc
 DC> on machines with a page size larger than 4k?

what do you mean by "exsiting"? BH_delay?


thanks, Alex
