Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289324AbSAOAba>; Mon, 14 Jan 2002 19:31:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289323AbSAOAbV>; Mon, 14 Jan 2002 19:31:21 -0500
Received: from samba.sourceforge.net ([198.186.203.85]:29458 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S289324AbSAOAbM>;
	Mon, 14 Jan 2002 19:31:12 -0500
Date: Mon, 14 Jan 2002 17:35:31 +1100
From: Anton Blanchard <anton@samba.org>
To: Dave Jones <davej@suse.de>, "David S. Miller" <davem@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: results: Remove 8 bytes from struct page on 64bit archs
Message-ID: <20020114063531.GC18794@krispykreme>
In-Reply-To: <20020106.060824.106263786.davem@redhat.com> <Pine.LNX.4.33.0201061542450.3859-100000@Appserv.suse.de> <20020107012555.GA6623@krispykreme> <20020106192204.B27356@twiddle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020106192204.B27356@twiddle.net>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> The powerpc backend claims to have a fast divide instruction
> (via RTX_COST if you care about such things).  We'll replace
> with shift when dividing by powers of 2, but won't try the
> multiply by a constant inverse trick.

To follow up: Alan Modra found and fixed the bug, it seems we were only
using the optimisation when the arguments were <= 32bit.

The target we use is RS64a which has a cost of 60 odd instructions
for divide.

Anton
