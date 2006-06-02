Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750896AbWFBBfR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750896AbWFBBfR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 21:35:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751084AbWFBBfQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 21:35:16 -0400
Received: from smtp.osdl.org ([65.172.181.4]:61595 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750896AbWFBBfP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 21:35:15 -0400
Date: Thu, 1 Jun 2006 18:38:36 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Barry K. Nathan" <barryn@pobox.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Arjan van de Ven <arjan@infradead.org>
Subject: Re: 2.6.17-rc5-mm2
Message-Id: <20060601183836.d318950e.akpm@osdl.org>
In-Reply-To: <986ed62e0606011758w348080ebn6e8430ec9e5b2ed3@mail.gmail.com>
References: <20060601014806.e86b3cc0.akpm@osdl.org>
	<986ed62e0606011758w348080ebn6e8430ec9e5b2ed3@mail.gmail.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Jun 2006 17:58:48 -0700
"Barry K. Nathan" <barryn@pobox.com> wrote:

> Ok, the kernel that I now have booting is 2.6.17-rc5-mm2 + my
> pata_pdc2027x patch + the 3 hotfixes that I saw when I started trying
> to build the kernel (i.e. without git-scsi-target-fixup but with the
> other 3 that are now present).
> 
> During boot of my Debian sarge system, this kernel always gives this
> warning at "Starting MTA:"
> http://static.flickr.com/47/158326090_35d0129147_b_d.jpg

That's the mysterious lockdep warning - I'm not sure we've got to the
bottom of that.


> Then, a minute or two after boot, it usually (well over 50% of the
> time, but not quite 100%) gives this oops:
> http://static.flickr.com/51/158326091_6a7057834c_b_d.jpg
> 
> If it doesn't fail with that oops, it usually tends to fail with other
> oopses (I have not managed to capture any of those, but they all seem
> to mention network-related stuff). Once, it just froze up without an
> oops. The oops I posted happens often enough that it's probably
> unjustifiably difficult to try reproducing the other oopses until this
> one is fixed or worked around.

Damn, sorry.  LLC is completely borked.  You should emphatically set
CONFIG_LLC=n.

