Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261368AbVBZAkO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261368AbVBZAkO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 19:40:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261426AbVBZAkN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 19:40:13 -0500
Received: from fire.osdl.org ([65.172.181.4]:60103 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261368AbVBZAkI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 19:40:08 -0500
Date: Fri, 25 Feb 2005 16:40:45 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: Mark Haverkamp <markh@osdl.org>, axboe@suse.de,
       linux-kernel@vger.kernel.org, dm-devel@redhat.com
Subject: Re: [PATCH] Fix panic in 2.6 with bounced bio and dm
In-Reply-To: <20050225161947.5fd6d343.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0502251640050.9237@ppc970.osdl.org>
References: <1109351021.5014.10.camel@markh1.pdx.osdl.net>
 <20050225161947.5fd6d343.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 25 Feb 2005, Andrew Morton wrote:
> 
> It seems very weird for dm to be shoving NULL page*'s into the middle of a
> bio's bvec array, so your fix might end up being a workaround pending a
> closer look at what's going on in there.

Yes. I don't see how this patch can be anything but bandaid to hide the 
real bug. Where do these "non-page" bvec's originate?

		Linus
