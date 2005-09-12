Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750942AbVILHQz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750942AbVILHQz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 03:16:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751193AbVILHQz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 03:16:55 -0400
Received: from colin.muc.de ([193.149.48.1]:523 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S1750942AbVILHQy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 03:16:54 -0400
Date: 12 Sep 2005 09:16:51 +0200
Date: Mon, 12 Sep 2005 09:16:51 +0200
From: Andi Kleen <ak@muc.de>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-mm2
Message-ID: <20050912071651.GA13563@muc.de>
References: <20050908053042.6e05882f.akpm@osdl.org> <201750000.1126494444@[10.10.2.4]> <20050912050122.GA3830@muc.de> <208180000.1126505399@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <208180000.1126505399@[10.10.2.4]>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 11, 2005 at 11:09:59PM -0700, Martin J. Bligh wrote:
> >> Andi, does that need changing on ia32 as well as x86_64, or are you
> >> just missing some ifdefs? Looks to me like the rest of the patch is
> >> specific to x86_64.
> > 
> > It should be a straight forward fix - the new zone is empty on i386.
> > Ok I reviewed chunk_to_zone and it should be ok with the new empty
> > zone. So just the appended patch should work. Can you test?
> 
> Will do. but did you actually mean to enable it on both arches? didn't
> look like it, but maybe you did.

The zone is just empty on i386. That could have been avoided
with some ifdefs, but I didn't see any sense because an empty 
zone shouldn't hurt anybody.

-Andi
