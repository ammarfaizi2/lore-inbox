Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750993AbWBBTBV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750993AbWBBTBV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 14:01:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751018AbWBBTBV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 14:01:21 -0500
Received: from [212.76.84.183] ([212.76.84.183]:15621 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S1750993AbWBBTBU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 14:01:20 -0500
From: Al Boldi <a1426z@gawab.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [RFC] VM: I have a dream...
Date: Thu, 2 Feb 2006 21:59:04 +0300
User-Agent: KMail/1.5
Cc: Kyle Moffett <mrmacman_g4@mac.com>, Bryan Henderson <hbryan@us.ibm.com>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <OFA0FDB57C.2E4B1B4D-ON88257103.00688AE2-88257103.0069EF1C@us.ibm.com> <200601311856.17569.a1426z@gawab.com> <1138893090.9861.25.camel@localhost.localdomain>
In-Reply-To: <1138893090.9861.25.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200602022159.04508.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Maw, 2006-01-31 at 18:56 +0300, Al Boldi wrote:
> > So with 64bits widely available now, and to let Linux spread its wings
> > and really fly, how could tmpfs merged w/ swap be tweaked to provide
> > direct mapped access into this linear address space?
>
> Why bother. You can already create a private large file and mmap it if
> you want to do this, and you will get better performance than being
> smeared around swap with everyone else.
>
> Currently swap means your data is mixed in with other stuff. Swap could
> do preallocation of each vma when running in limited overcommit modes
> and it would run a lot faster if you did but you would pay a lot in
> flexibility and efficiency, as well as needing a lot more swap.
>
> Far better to let applications wanting to work this way do it
> themselves. Just mmap and the cache balancing and pager will do the rest
> for you.

So w/ 1GB RAM, no swap, and 1TB disk mmap'd, could this mmap'd space be added 
to the total memory available to the OS, as is done w/ swap?

And if that's possible, why not replace swap w/ mmap'd disk-space?

Thanks!

--
Al

