Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030214AbWBMW2Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030214AbWBMW2Q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 17:28:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030215AbWBMW2P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 17:28:15 -0500
Received: from smtp.osdl.org ([65.172.181.4]:18053 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030214AbWBMW2P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 17:28:15 -0500
Date: Mon, 13 Feb 2006 14:27:54 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Hugh Dickins <hugh@veritas.com>
cc: "Michael S. Tsirkin" <mst@mellanox.co.il>,
       William Irwin <wli@holomorphy.com>, Roland Dreier <rdreier@cisco.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Gleb Natapov <gleb@minantech.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       openib-general@openib.org, Petr Vandrovec <vandrove@vc.cvut.cz>,
       Badari Pulavarty <pbadari@us.ibm.com>
Subject: Re: [openib-general] Re: madvise MADV_DONTFORK/MADV_DOFORK
In-Reply-To: <Pine.LNX.4.61.0602132157110.3761@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.64.0602131426470.3691@g5.osdl.org>
References: <20060213154114.GO32041@mellanox.co.il> <Pine.LNX.4.64.0602131104460.3691@g5.osdl.org>
 <adar767133j.fsf@cisco.com> <Pine.LNX.4.64.0602131125180.3691@g5.osdl.org>
 <Pine.LNX.4.61.0602131943050.9573@goblin.wat.veritas.com>
 <20060213210906.GC13603@mellanox.co.il> <Pine.LNX.4.61.0602132157110.3761@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 13 Feb 2006, Hugh Dickins wrote:
> 
> Almost.  I would still prefer madvise_vma to allow MADV_DONTFORK
> on a VM_IO vma, even though it must prohibit MADV_DOFORK there.
> But if Linus disagrees, of course ignore me.

No, I agree. Quite frankly, I'd be willing to allow even the other way 
around, because I don't see how the VM could screw up, but prohibiting 
DOFORK is clearly the safer thing to do.

		Linus
