Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261767AbTCQQkW>; Mon, 17 Mar 2003 11:40:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261770AbTCQQkW>; Mon, 17 Mar 2003 11:40:22 -0500
Received: from 217-125-129-224.uc.nombres.ttd.es ([217.125.129.224]:27374 "HELO
	cocodriloo.com") by vger.kernel.org with SMTP id <S261767AbTCQQkV>;
	Mon, 17 Mar 2003 11:40:21 -0500
From: wind@cocodriloo.com
Date: Mon, 17 Mar 2003 17:52:23 +0100
To: Rik van Riel <riel@surriel.com>
Cc: linux-kernel@vger.kernel.org, akpm@digeo.com
Subject: Re: 2.4 vm, program load, page faulting, ...
Message-ID: <20030317165223.GA11526@wind.cocodriloo.com>
References: <20030317151004.GR20188@holomorphy.com> <Pine.LNX.4.44.0303171100300.2571-100000@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0303171100300.2571-100000@chimarrao.boston.redhat.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 17, 2003 at 11:01:31AM -0500, Rik van Riel wrote:
> On Mon, 17 Mar 2003, William Lee Irwin III wrote:
> > On Sat, 15 Mar 2003, Paul Albrecht wrote:
> > >> ... Why does the kernel page fault on text pages, present in the page
> > >> cache, when a program starts? Couldn't the pte's for text present in the
> > >> page cache be resolved when they're mapped to memory?
> > 
> > SVR4 did and saw an improvement wrt. page fault rate, according to
> > Vahalia.
> 
> An improvement in the _page fault rate_, well DUH.
> 
> > I'd like to see whether this is useful for Linux.
> 
> The question is, does it result in an improvement in the
> run speed of processes...
> 
> cheers,
> 
> Rik

You should ask Andrew about his patch to do exactly that: he
forced all PROC_EXEC mmaps to be nonlinear-mapped and this
forced all programs to suck entire binaries into memory...
I recall he saw at least 25% improvement at launching gnome.

Andrew?

-- 
Antonio Vargas
