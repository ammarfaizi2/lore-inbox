Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130761AbRA2VtZ>; Mon, 29 Jan 2001 16:49:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130897AbRA2VtF>; Mon, 29 Jan 2001 16:49:05 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:33017 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129396AbRA2VtC>; Mon, 29 Jan 2001 16:49:02 -0500
Date: Mon, 29 Jan 2001 19:47:54 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: Rasmus Andersen <rasmus@jaquet.dk>
cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] guard mm->rss with page_table_lock (241p11)
In-Reply-To: <20010129224311.H603@jaquet.dk>
Message-ID: <Pine.LNX.4.21.0101291946540.1321-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Jan 2001, Rasmus Andersen wrote:
> On Mon, Jan 29, 2001 at 07:30:01PM -0200, Rik van Riel wrote:
> > On Mon, 29 Jan 2001, Rasmus Andersen wrote:
> > 
> > > Please comment. Or else I will continue to sumbit it :)
> > 
> > The following will hang the kernel on SMP, since you're
> > already holding the spinlock here. Try compiling with
> > CONFIG_SMP and see what happens...
> 
> You are right. Sloppy research by me :(
> 
> New patch below with the vmscan part removed.

Have you bothered to also check the rest?

Don't be surprised if there are more places
like this. Please compile your kernel with
CONFIG_SMP and test if your changes work
before submitting them into the stable kernel.

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
