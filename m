Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293139AbSCEB1J>; Mon, 4 Mar 2002 20:27:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293142AbSCEB06>; Mon, 4 Mar 2002 20:26:58 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:40709 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S293139AbSCEB0k>;
	Mon, 4 Mar 2002 20:26:40 -0500
Date: Mon, 4 Mar 2002 22:26:30 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Andrea Arcangeli <andrea@suse.de>
Cc: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Bill Davidsen <davidsen@tmr.com>, Mike Fedyk <mfedyk@matchmail.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.19pre1aa1
In-Reply-To: <20020305020546.W20606@dualathlon.random>
Message-ID: <Pine.LNX.4.44L.0203042225340.2181-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Mar 2002, Andrea Arcangeli wrote:
> On Mon, Mar 04, 2002 at 09:01:31PM -0300, Rik van Riel wrote:
> > This could be expressed as:
> >
> > "node A"  HIGHMEM A -> HIGHMEM B -> NORMAL -> DMA
> > "node B"  HIGHMEM B -> HIGHMEM A -> NORMAL -> DMA
>
> Highmem? Let's assume you speak about "normal" and "dma" only of course.
>
> And that's not always the right zonelist layout. If an allocation asks for
> ram from a certain node, like during the ram bindings, we should use the
> current layout of the numa zonelist. If node A is the preferred, than we
> should allocate from node A first,

You're forgetting about the fact that this NUMA box only
has 1 ZONE_NORMAL and 1 ZONE_DMA while it has multiple
HIGHMEM zones...

This makes the fallback pattern somewhat more complex.

regards,

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

