Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317775AbSFMQNi>; Thu, 13 Jun 2002 12:13:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317776AbSFMQNh>; Thu, 13 Jun 2002 12:13:37 -0400
Received: from ns.suse.de ([213.95.15.193]:1039 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S317775AbSFMQNg>;
	Thu, 13 Jun 2002 12:13:36 -0400
To: David Mosberger <davidm@napali.hpl.hp.com>
Cc: bcrl@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [patch] pageattr update
In-Reply-To: <20020612010443.B1350@redhat.com.suse.lists.linux.kernel> <20020613005238.A17700@averell.suse.lists.linux.kernel> <20020613061246.A7121@redhat.com.suse.lists.linux.kernel> <15624.46508.257287.233406@napali.hpl.hp.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 13 Jun 2002 18:13:37 +0200
Message-ID: <p737kl35f7y.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Mosberger <davidm@napali.hpl.hp.com> writes:

> As long as change_page_attr() is used for AGP-related stuff only,
> there is probably no real issue with the patch in its current form
> (its simply a no-op on most non-x86 platforms).  However, I'm a bit
> worried that someone might start to use it for other things, such that
> change_page_attr() could no longer be a no-op on those platforms.
> Since the DMA coherency issue is an AGP specific issue, perhaps just
> renaming the macro to agp_change_page_attr() would take care of my
> concern.  What do you think

Linus already requested that for 2.5 (agp_map_into_gart() etc.) 
I think for 2.4 #ifdef in the agp code is fine and I'm not adopting Ben's 
change of moving change_page_attr into all asm files.

-Andi
