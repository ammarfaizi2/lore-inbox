Return-Path: <linux-kernel-owner+w=401wt.eu-S1750970AbXAKRdJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750970AbXAKRdJ (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 12:33:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750976AbXAKRdJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 12:33:09 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:49209 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750970AbXAKRdI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 12:33:08 -0500
Date: Thu, 11 Jan 2007 17:42:14 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Viktor <vvp01@inbox.ru>, Aubrey <aubreylee@gmail.com>,
       Hua Zhong <hzhong@gmail.com>, Hugh Dickins <hugh@veritas.com>,
       linux-kernel@vger.kernel.org, hch@infradead.org,
       kenneth.w.chen@intel.com, akpm@osdl.org, mjt@tls.msk.ru
Subject: Re: O_DIRECT question
Message-ID: <20070111174214.676d15b9@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.64.0701110750520.3594@woody.osdl.org>
References: <6d6a94c50701101857v2af1e097xde69e592135e54ae@mail.gmail.com>
	<Pine.LNX.4.64.0701101902270.3594@woody.osdl.org>
	<45A629E9.70502@inbox.ru>
	<Pine.LNX.4.64.0701110750520.3594@woody.osdl.org>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.10.4; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> space, just as an example) is wrong in the first place, but the really 
> subtle problems come when you realize that you can't really just "bypass" 
> the OS.

Well you can - its called SG_IO and that really does get the OS out of
the way. O_DIRECT gets crazy when you stop using it on devices directly
and use it on files

You do need some way to avoid the copy cost of caches and get data direct
to user space, it also needs to be a way that works without MMU tricks
because many of that need it are the embedded platforms.

Alan
