Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290885AbSASAXj>; Fri, 18 Jan 2002 19:23:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290886AbSASAX3>; Fri, 18 Jan 2002 19:23:29 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:40791 "EHLO
	svldns02.veritas.com") by vger.kernel.org with ESMTP
	id <S290885AbSASAXP>; Fri, 18 Jan 2002 19:23:15 -0500
Date: Sat, 19 Jan 2002 00:24:43 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
To: Pavel Machek <pavel@suse.cz>
cc: Andrea Arcangeli <andrea@suse.de>, rwhron@earthlink.net,
        Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 1-2-3 GB
In-Reply-To: <20020118211851.GB130@elf.ucw.cz>
Message-ID: <Pine.LNX.4.21.0201190010020.2091-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jan 2002, Pavel Machek wrote:
> 
> > The patch below seems to be enough to convince egcs-2.91.66 and
> > gcc-2.95.3 to use a "jb" comparison there.  I'm working on PIII,
> > prefetchw() just a stub, if that makes any difference.
> 
> If this is really gcc bug, would simply making j volatile fix it?

You rogue!  The panacea, eh?  Well, yes, it does look like that's
enough with egcs-2.91.66 (I don't have 2.95 here to try at the moment,
expect it would behave the same) - the comparison uses "jle" as before,
but now it's correctly on free_one_pmd's index j instead of an address.
Neat - but an even bigger fatter comment needed?

Hugh

