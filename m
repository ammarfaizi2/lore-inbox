Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262658AbVHDXS5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262658AbVHDXS5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 19:18:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262665AbVHDXS5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 19:18:57 -0400
Received: from cantor.suse.de ([195.135.220.2]:31974 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S262658AbVHDXQ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 19:16:56 -0400
Date: Fri, 5 Aug 2005 01:16:49 +0200
From: Andi Kleen <ak@suse.de>
To: Hugh Dickins <hugh@veritas.com>
Cc: Andi Kleen <ak@suse.de>, Danny ter Haar <dth@picard.cistron.nl>,
       Pavel Roskin <proski@gnu.org>,
       "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc5-git2 does not boot on (my) amd64
Message-ID: <20050804231649.GI8266@wotan.suse.de>
References: <dctuso$tl$1@news.cistron.nl.suse.lists.linux.kernel> <p73iryl73nm.fsf@bragg.suse.de> <Pine.LNX.4.61.0508042358530.8665@goblin.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0508042358530.8665@goblin.wat.veritas.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 05, 2005 at 12:06:25AM +0100, Hugh Dickins wrote:
> On Thu, 5 Aug 2005, Andi Kleen wrote:
> > dth@picard.cistron.nl (Danny ter Haar) writes:
> > > 
> > > Freeing unused kernel memory: 248k freed
> > > VM: killing process hotplug
> > > VM: killing process hotplug
> > > VM: killing process hotplug
> > > VM: killing process hotplug
> > > Unable to handle kernel paging request at fffffff28017b5be RIP:
> > > [<fffffff28017b5be>]
> > 
> > Looks weird. Just to make sure can you do a make distclean and try
> > again? It might be a bad compile.
> 
> No, like Pavel's and Martin's reports, this is just an effect
> of the not-quite-fully-baked do_wp_page/get_user_pages race fix in
> 2.6.13-rc5-git2, which AlexN reported earlier.  Should now be fully
> fixed in Linus' current git, and in the 2.6.13-rc6 akpm prophesies
> to be coming soon - please all test that.

Yes. I didn't read the mail fully before replying to that one.

-Andi
