Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261898AbVBUGks@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261898AbVBUGks (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 01:40:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261899AbVBUGks
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 01:40:48 -0500
Received: from fire.osdl.org ([65.172.181.4]:32396 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261898AbVBUGkn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 01:40:43 -0500
Date: Sun, 20 Feb 2005 22:40:22 -0800
From: Andrew Morton <akpm@osdl.org>
To: Hugh Dickins <hugh@veritas.com>
Cc: nickpiggin@yahoo.com.au, ak@suse.de, davem@davemloft.net,
       benh@kernel.crashing.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] page table iterators
Message-Id: <20050220224022.5b5c4a09.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0502210619290.7925@goblin.wat.veritas.com>
References: <4214A1EC.4070102@yahoo.com.au>
	<4214A437.8050900@yahoo.com.au>
	<20050217194336.GA8314@wotan.suse.de>
	<1108680578.5665.14.camel@gaston>
	<20050217230342.GA3115@wotan.suse.de>
	<20050217153031.011f873f.davem@davemloft.net>
	<20050217235719.GB31591@wotan.suse.de>
	<4218840D.6030203@yahoo.com.au>
	<Pine.LNX.4.61.0502210619290.7925@goblin.wat.veritas.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins <hugh@veritas.com> wrote:
>
> My opinion FWIW: I'm all for regularizing the pagetable loops to
>  work the same way, changing their variables to use the same names,
>  improving their efficiency; but I do like to see what a loop is up to.
> 
>  list_for_each and friends are very widely used, they're fine, and I'm
>  quite glad to have their prefetching hidden away from me; but usually
>  I groan, grin and bear it, each time someone devises a clever new
>  for_each macro concealing half the details of some specialist loop.
> 
>  In a minority?

Of two.

Let's see what they look like.  They'd need to be very good, IMO.
