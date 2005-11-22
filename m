Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965154AbVKVTvz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965154AbVKVTvz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 14:51:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965157AbVKVTvy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 14:51:54 -0500
Received: from gold.veritas.com ([143.127.12.110]:19267 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S965154AbVKVTvy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 14:51:54 -0500
Date: Tue, 22 Nov 2005 19:51:56 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
cc: Dominik Brodowski <linux@dominikbrodowski.net>,
       linux-kernel@vger.kernel.org, npiggin@suse.de
Subject: Re: PageReserved removal woes: vbetool, suspend-to-ram breakage
In-Reply-To: <E1EedI9-0005O6-00@chiark.greenend.org.uk>
Message-ID: <Pine.LNX.4.61.0511221947230.28813@goblin.wat.veritas.com>
References: <20051111103808.GA22057@isilmar.linta.de> <E1EedI9-0005O6-00@chiark.greenend.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 22 Nov 2005 19:51:53.0686 (UTC) FILETIME=[2FDDBF60:01C5EF9E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Nov 2005, Matthew Garrett wrote:
> Dominik Brodowski <linux@dominikbrodowski.net> wrote:
> 
> > Just wanted to let you know that the warning introduced in
> > [PATCH] core remove PageReserved
> 
> It's not much of a warning, it seems to stop vbetool from working (which
> may explain a few complaints about ACPI suspend being broken in 2.6.15 -
> it's not, but vbetool is...)
> 
> vbetool (well, strictly it's LRMI, but...) needs to access real-mode
> memory. On the other hand, it's probably a bad idea to let it actually
> scribble over RAM that the kernel may be using. So
> MAP_PRIVATE|PROT_WRITE seems to be the correct thing to do. This
> certainly /seemed/ to work in older kernels, but doesn't any more. What
> should I be doing instead?
> 
> (I'm also not quite sure why the error claims that it's deprecated,
> whereas in fact it doesn't actually work at all. Breaking userspace
> without warning isn't terribly nice)

Sorry about that, we really didn't expect that it was being used.
And sorry I didn't get the fixes ready in time for 2.6.15-rc2.
But they've gone into Linus' git tree a couple of hours ago.
Please let me know if tomorrow's 2.6.15-rc2-git3 does not work for you.

Hugh
