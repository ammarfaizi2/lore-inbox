Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262707AbVHDXGB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262707AbVHDXGB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 19:06:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262761AbVHDXFt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 19:05:49 -0400
Received: from gold.veritas.com ([143.127.12.110]:56468 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S262727AbVHDXEr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 19:04:47 -0400
Date: Fri, 5 Aug 2005 00:06:25 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andi Kleen <ak@suse.de>
cc: Danny ter Haar <dth@picard.cistron.nl>, Pavel Roskin <proski@gnu.org>,
       "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc5-git2 does not boot on (my) amd64
In-Reply-To: <p73iryl73nm.fsf@bragg.suse.de>
Message-ID: <Pine.LNX.4.61.0508042358530.8665@goblin.wat.veritas.com>
References: <dctuso$tl$1@news.cistron.nl.suse.lists.linux.kernel>
 <p73iryl73nm.fsf@bragg.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 04 Aug 2005 23:04:47.0146 (UTC) FILETIME=[E8BF18A0:01C59948]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Aug 2005, Andi Kleen wrote:
> dth@picard.cistron.nl (Danny ter Haar) writes:
> > 
> > Freeing unused kernel memory: 248k freed
> > VM: killing process hotplug
> > VM: killing process hotplug
> > VM: killing process hotplug
> > VM: killing process hotplug
> > Unable to handle kernel paging request at fffffff28017b5be RIP:
> > [<fffffff28017b5be>]
> 
> Looks weird. Just to make sure can you do a make distclean and try
> again? It might be a bad compile.

No, like Pavel's and Martin's reports, this is just an effect
of the not-quite-fully-baked do_wp_page/get_user_pages race fix in
2.6.13-rc5-git2, which AlexN reported earlier.  Should now be fully
fixed in Linus' current git, and in the 2.6.13-rc6 akpm prophesies
to be coming soon - please all test that.

Hugh
