Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262387AbUKVUmj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262387AbUKVUmj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 15:42:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262354AbUKVUlb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 15:41:31 -0500
Received: from fw.osdl.org ([65.172.181.6]:2976 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262376AbUKVUhf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 15:37:35 -0500
Date: Mon, 22 Nov 2004 12:36:58 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Len Brown <len.brown@intel.com>
cc: Chris Wright <chrisw@osdl.org>, Adrian Bunk <bunk@stusta.de>,
       Bjorn Helgaas <bjorn.helgaas@hp.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.10-rc2 doesn't boot (if no floppy device)
In-Reply-To: <Pine.LNX.4.58.0411221226310.20993@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58.0411221234170.20993@ppc970.osdl.org>
References: <20041115152721.U14339@build.pdx.osdl.net>  <1100819685.987.120.camel@d845pe>
 <20041118230948.W2357@build.pdx.osdl.net>  <1100941324.987.238.camel@d845pe>
  <Pine.LNX.4.58.0411200831560.20993@ppc970.osdl.org>  <1101150469.20006.46.camel@d845pe>
  <Pine.LNX.4.58.0411221116480.20993@ppc970.osdl.org> <1101155077.20006.110.camel@d845pe>
 <Pine.LNX.4.58.0411221226310.20993@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 22 Nov 2004, Linus Torvalds wrote:
> 
> And that's exactly why I think the "minimally disruptive" fix is to not
> disable them at all, but just fix up ELCR for anything that was already
> enabled. Since that _is_ what "disable + re-enable" ends up actually
> doing.

Oh, and I think one alternative at this point is obviously to just go back
to the "re-enable all interrupts early in the boot" code. Clearly we need
to do _something_ for 2.6.10, and I want it to be something that is pretty
much equivalent to what we _do_ have testing coverage of. Just to keep
safe.

I actually _like_ the "enable links only when needed" thing, which is why 
I'd prefer to look for alternatives. But I like even more not having to 
worry about strange hw setups, so "minimal fixing" really is pretty 
important.

		Linus
