Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282816AbRLKUFV>; Tue, 11 Dec 2001 15:05:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282815AbRLKUFM>; Tue, 11 Dec 2001 15:05:12 -0500
Received: from ns.ithnet.com ([217.64.64.10]:51722 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S282814AbRLKUE5>;
	Tue, 11 Dec 2001 15:04:57 -0500
Date: Tue, 11 Dec 2001 21:04:12 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: orf@mailbag.com, linux-kernel@vger.kernel.org, brownfld@irridia.com,
        andrea@suse.de, akpm@zip.com.au
Subject: Re: 2.4.16 memory badness (reproducible)
Message-Id: <20011211210412.59491313.skraw@ithnet.com>
In-Reply-To: <Pine.LNX.4.21.0112111850090.1164-100000@localhost.localdomain>
In-Reply-To: <200112082142.fB8LgAb02089@orp.orf.cx>
	<Pine.LNX.4.21.0112111850090.1164-100000@localhost.localdomain>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.6.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Dec 2001 19:07:41 +0000 (GMT)
Hugh Dickins <hugh@veritas.com> wrote:

> I believe this error comes, not from a (genuine or mistaken) shortage
> of free memory,

Me, too. 

> but from shortage or fragmentation of vmalloc's virtual
> address space.  Does patch below (to 2.4.17-pre4-aa1 since I think that's
> what you tried last; easily adaptible to other trees) doubling vmalloc's
> address space (on your 1GB machine or larger) make any difference?
> Perhaps there's a vmalloc leak and this will only delay the error.

At least I think this direction to search the bug looks a lot more promising than a general mem shortage problem. After reviewing modify_ldt this looked like the only useable idea to Leighs problem.

Regards,
Stephan


