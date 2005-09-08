Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932493AbVIHAtN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932493AbVIHAtN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 20:49:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932490AbVIHAtN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 20:49:13 -0400
Received: from smtp.osdl.org ([65.172.181.4]:1928 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932479AbVIHAtM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 20:49:12 -0400
Date: Wed, 7 Sep 2005 17:49:04 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: James Bottomley <James.Bottomley@SteelEye.com>
cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Jens Axboe <axboe@suse.de>, Greg KH <greg@kroah.com>
Subject: Re: [GIT PATCH] SCSI merge for 2.6.13
In-Reply-To: <Pine.LNX.4.58.0509071738050.11102@g5.osdl.org>
Message-ID: <Pine.LNX.4.58.0509071743380.11102@g5.osdl.org>
References: <1126053452.5012.28.camel@mulgrave> <Pine.LNX.4.58.0509071730490.11102@g5.osdl.org>
 <Pine.LNX.4.58.0509071738050.11102@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 7 Sep 2005, Linus Torvalds wrote:
> 
> Quite frankly, what's the point in asking people to pull a tree that is 
> known to not compile?

Btw, I see the patch that is supposed to fix it, but I'm in no position to
know whether it's even acceptable to basically double the size of the
"struct klist", for example. There may be a good reason why Greg hasn't 
been merging the klist stuff, and just assuming that they are merged not 
only screws up everybody down-stream, it's not necessarily valid in the 
first place.

In other words, I think I will have to just revert the commit that
introduces this bogus "assume a patch that wasn't merged" (commit ID
2b7d6a8cb9718fc1d9e826201b64909c44a915f4) for now.

And once more strongly complain about it getting sent to me in the first
place since it was known to not even compile.

		Linus
