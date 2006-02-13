Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030194AbWBMWI1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030194AbWBMWI1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 17:08:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964871AbWBMWI1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 17:08:27 -0500
Received: from [194.90.237.34] ([194.90.237.34]:54749 "EHLO mtlexch01.mtl.com")
	by vger.kernel.org with ESMTP id S964870AbWBMWI0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 17:08:26 -0500
Date: Tue, 14 Feb 2006 00:09:47 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Hugh Dickins <hugh@veritas.com>
Cc: Linus Torvalds <torvalds@osdl.org>, William Irwin <wli@holomorphy.com>,
       Roland Dreier <rdreier@cisco.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Gleb Natapov <gleb@minantech.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       openib-general@openib.org, Petr Vandrovec <vandrove@vc.cvut.cz>,
       Badari Pulavarty <pbadari@us.ibm.com>
Subject: Re: [openib-general] Re: madvise MADV_DONTFORK/MADV_DOFORK
Message-ID: <20060213220947.GD13603@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <20060213154114.GO32041@mellanox.co.il> <Pine.LNX.4.64.0602131104460.3691@g5.osdl.org> <adar767133j.fsf@cisco.com> <Pine.LNX.4.64.0602131125180.3691@g5.osdl.org> <Pine.LNX.4.61.0602131943050.9573@goblin.wat.veritas.com> <20060213210906.GC13603@mellanox.co.il> <Pine.LNX.4.61.0602132157110.3761@goblin.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0602132157110.3761@goblin.wat.veritas.com>
User-Agent: Mutt/1.4.2.1i
X-OriginalArrivalTime: 13 Feb 2006 22:10:15.0984 (UTC) FILETIME=[44B52300:01C630EA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting r. Hugh Dickins <hugh@veritas.com>:
> Subject: Re: [openib-general] Re: madvise MADV_DONTFORK/MADV_DOFORK
> 
> On Mon, 13 Feb 2006, Michael S. Tsirkin wrote:
> > 
> > Like this then?
> 
> Almost.  I would still prefer madvise_vma to allow MADV_DONTFORK
> on a VM_IO vma, even though it must prohibit MADV_DOFORK there.
> But if Linus disagrees, of course ignore me.

I'm not sure about this point. Linus?

> Comments much better, thanks.  I didn't get your point about mlock'd
> memory, but I'm content to believe you're thinking of an issue that
> hasn't occurred to me.

I'm referring to the follwing, from man mlock(2):

"Cryptographic  security  software often handles critical bytes like passwords
or secret keys as data structures. As a result of paging, these secrets could
be  transfered  onto  a persistent swap store medium, where they might be
accessible to the enemy long after the security  software  has erased the
secrets in RAM and terminated."



-- 
Michael S. Tsirkin
Staff Engineer, Mellanox Technologies
