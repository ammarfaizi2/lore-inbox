Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269402AbUIYUVl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269402AbUIYUVl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 16:21:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269403AbUIYUVi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 16:21:38 -0400
Received: from fw.osdl.org ([65.172.181.6]:17030 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269402AbUIYUVg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 16:21:36 -0400
Date: Sat, 25 Sep 2004 13:21:29 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jeremy Allison <jra@samba.org>
cc: YOSHIFUJI Hideaki / =?utf-8?B?5ZCJ6Jek6Iux5piO?= 
	<yoshfuji@linux-ipv6.org>,
       samuel.thibault@ens-lyon.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6] smbfs & "du" illness
In-Reply-To: <20040925195256.GB580@jeremy1>
Message-ID: <Pine.LNX.4.58.0409251317410.2317@ppc970.osdl.org>
References: <20040917205422.GD2685@bouh.is-a-geek.org>
 <Pine.LNX.4.58.0409250929030.2317@ppc970.osdl.org> <20040925171104.GN580@jeremy1>
 <20040926.024131.06508879.yoshfuji@linux-ipv6.org> <20040925174406.GP580@jeremy1>
 <Pine.LNX.4.58.0409251054490.2317@ppc970.osdl.org> <20040925182907.GS580@jeremy1>
 <Pine.LNX.4.58.0409251218170.2317@ppc970.osdl.org> <20040925195256.GB580@jeremy1>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 25 Sep 2004, Jeremy Allison wrote:
>
> On Sat, Sep 25, 2004 at 12:20:20PM -0700, Linus Torvalds wrote:
> > 
> > Because right now the number is meaningless, and the Linux client is 
> > apparently better off ignoring it totally.
> 
> Actually, just to be clear - the number isn't completely
> meaningless, it's the actual size on disk (from the st_blocks
> if they're available, filesize if not) rounded up to the nearest
> 1mb boundary. Just didn't want you to think we were randomly
> returning 1mb. It's a meaningful number, it's just the granularity
> that's a bit off :-).

I repeat: the Linux client is apparently better off ignoring it totally.

That makes it meaningless, Jeremy. 

  meaningless (vs. meaningful), nonmeaningful -- (having no meaning or
	direction or purpose; "a meaningless endeavor"; "a meaningless
	life"; "a verbose but meaningless explanation")

It clearly has no meaning or direction or purpose for any sane client.

After all, the only thing we can use it for is st_blocks, and since the 
granularity is _so_ big, we're much better off looking at the file size 
and guessing from that.

I still don't see why you argue for that totally meaningless number. As 
far as I can tell, the _only_ thing it matters for is some Windows 
benchmark.

Tell me again: why should the Linux client look at that number? Give me 
just _one_ valid reason.

		Linus
