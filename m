Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271922AbTHIHXQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 03:23:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272223AbTHIHXQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 03:23:16 -0400
Received: from vladimir.pegasys.ws ([64.220.160.58]:4882 "EHLO
	vladimir.pegasys.ws") by vger.kernel.org with ESMTP id S271922AbTHIHXN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 03:23:13 -0400
Date: Sat, 9 Aug 2003 00:23:07 -0700
From: jw schultz <jw@pegasys.ws>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Change all occurrences of 'flavour' to 'flavor'
Message-ID: <20030809072307.GC8503@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	linux-kernel@vger.kernel.org
References: <20030807180032.GA16957@spaans.vs19.net> <Pine.LNX.4.53.0308072139320.12875@montezuma.mastecende.com> <20030808065230.GA5996@spaans.vs19.net> <3F33BF33.8070601@techsource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F33BF33.8070601@techsource.com>
User-Agent: Mutt/1.3.27i
X-Message-Flag: Reading this message may result in the loss of free will.  Read and obey.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 08, 2003 at 11:18:11AM -0400, Timothy Miller wrote:
> 
> 
> Jasper Spaans wrote:
> >On Thu, Aug 07, 2003 at 09:42:37PM -0400, Zwane Mwaikambo wrote:
> >
> >
> >>>It changes all occurrences of 'flavour' to 'flavor' in the complete tree;
> >>>I've just comiled all affected files (that is, the config resulting from
> >>>make allyesconfig minus already broken stuff) succesfully on i386.
> >>
> >>Arrrgh! You can't be serious!
> >
> >
> >Yes, I am bloody serious; this patch might look purely cosmetic at first
> >sight.. yet, there's a technical reason for at least one part of it. Grep
> >and see the horror:
> >
> >$ egrep -ni 'flavou?r' fs/nfs/inode.c
> >[snip]
> >1357:	rpc_authflavor_t authflavour;
> >[snip]
> 
> 
> Ah, for a moment, I was worried that someone was talking about text in 
> comments.
> 
> Yes, when it comes to spelling of words in variable and type names, I 
> think it would be a good idea to be consistent.
> 
> What is Linus's preferred spelling?  Let's use that.

Or look at history.  I picked the two samples easiest for
me: 2.4.18 and 2.2.10.  In neither does fs/nfs/inode.c have
"flavour" in comment or symbol.  A search of the entire
kernel tree shows "flavour" only appearing in comments in
2.2.10 but 2.4.18 has some variables and macros named
"flavour" or "flavours" but they seem to be in the minority.

	$ cd /usr/src/linux-2.4.18.SuSE
	$ find . -name '*.[ch]' | xargs grep -li 'flavour' |wc -l
	     18
	$ find . -name '*.[ch]' | xargs grep -li 'flavor' |wc -l
	     36

Hardly scientific it lumps comments (which nobody should
care about) with variables, functions and macros, and there
will be an overlap between the two sets of files.

I'd say flavour has crept in.  While i think that "flavour"
has more panache than "flavor" i'd suggest regularising it
in the way that makes the least change.

I'm also inclined to suggest that a preferred spelling be
specified in the CodingStyle document.  Inconsistency in
this doesn't much affect readability but it does impact
maintainability.



	
-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
