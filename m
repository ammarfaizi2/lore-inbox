Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269390AbUIYT02@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269390AbUIYT02 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 15:26:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269398AbUIYT02
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 15:26:28 -0400
Received: from dp.samba.org ([66.70.73.150]:14236 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S269390AbUIYT0Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 15:26:25 -0400
Date: Sat, 25 Sep 2004 12:25:44 -0700
From: Jeremy Allison <jra@samba.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeremy Allison <jra@samba.org>,
       YOSHIFUJI Hideaki / =?utf-8?B?5ZCJ6Jek6Iux5piO?= 
	<yoshfuji@linux-ipv6.org>,
       samuel.thibault@ens-lyon.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6] smbfs & "du" illness
Message-ID: <20040925192544.GA580@jeremy1>
Reply-To: Jeremy Allison <jra@samba.org>
References: <20040917205422.GD2685@bouh.is-a-geek.org> <Pine.LNX.4.58.0409250929030.2317@ppc970.osdl.org> <20040925171104.GN580@jeremy1> <20040926.024131.06508879.yoshfuji@linux-ipv6.org> <20040925174406.GP580@jeremy1> <Pine.LNX.4.58.0409251054490.2317@ppc970.osdl.org> <20040925182907.GS580@jeremy1> <Pine.LNX.4.58.0409251218170.2317@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0409251218170.2317@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 25, 2004 at 12:20:20PM -0700, Linus Torvalds wrote:
> 
> If the number doesn't make sense, then we shouldn't look at it. The 
> _only_ thing that number makes sense for is st_blocks as far as the Linux 
> client is concerned. 
> 
> In other words, the Linux client is a hell of a lot better off just taking 
> "(filesize + 511) >> 9", as far as I can tell. It's more accurate than the 
> random number you have.

At present this is true, but just because our implementation of the spec
is broken (and yes it's complicated by the fact that we're the only
ones implementing the server side of this at the moment) doesn't mean
that the client should depend on this.

After all, now I know about it I'll fix it for the next release
and eventually modern clients and servers will be consistent on
this issue. But if you want to have a fallback hack that does
this at present then that's fine by me. It'd be nice if it was
temporary though.

Jeremy.
