Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318857AbSHET7G>; Mon, 5 Aug 2002 15:59:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318858AbSHET7G>; Mon, 5 Aug 2002 15:59:06 -0400
Received: from axp01.e18.physik.tu-muenchen.de ([129.187.154.129]:61964 "EHLO
	axp01.e18.physik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id <S318857AbSHET7E>; Mon, 5 Aug 2002 15:59:04 -0400
Date: Mon, 5 Aug 2002 22:02:39 +0200 (CEST)
From: Roland Kuhn <rkuhn@e18.physik.tu-muenchen.de>
To: Chris Mason <mason@suse.com>
Cc: Oleg Drokin <green@namesys.com>, <linux-kernel@vger.kernel.org>
Subject: Re: reiserfs blocks long on getdents64() during concurrent write
In-Reply-To: <Pine.LNX.4.44.0208052113150.31879-101000@pc40.e18.physik.tu-muenchen.de>
Message-ID: <Pine.LNX.4.44.0208052157040.1357-100000@pc40.e18.physik.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Mon, 5 Aug 2002, Roland Kuhn wrote:

> > So, on ftp.suse.com/pub/people/mason/patches/data-logging
> > 
> > Apply:
> > 01-relocation-4.diff
> > 02-commit_super-8.diff # this is the one you want, but it depends on 01.
> > 
> Okay, will try.
> 
> > And try again.  If that doesn't do it, try 04-write_times.diff (which
> > doesn't depend on anything).
> > 
> Is there a documentation about what this patch does as a whole?
> 
Sorry, stupid question for the 04 one. What my brain wanted to say: The 
patches 01 and 02 seem to aim at dirtying the super block less often. If 
there is serious writing activity, will this lead to fewer but longer 
commits? The problem with our current (kinda stupid) software is that 
lower write() latency is more important than a few percent more 
throughput.

Ciao,
					Roland

+---------------------------+-------------------------+
|    TU Muenchen            |                         |
|    Physik-Department E18  |  Raum    3558           |
|    James-Franck-Str.      |  Telefon 089/289-12592  |
|    85747 Garching         |                         |
+---------------------------+-------------------------+

