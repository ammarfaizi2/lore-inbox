Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129197AbRBICau>; Thu, 8 Feb 2001 21:30:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129375AbRBICak>; Thu, 8 Feb 2001 21:30:40 -0500
Received: from gap.cco.caltech.edu ([131.215.139.43]:19154 "EHLO
	gap.cco.caltech.edu") by vger.kernel.org with ESMTP
	id <S129197AbRBICaZ>; Thu, 8 Feb 2001 21:30:25 -0500
To: mlist-linux-kernel@nntp-server.caltech.edu
Path: wnoise
From: wnoise@ugcs.caltech.edu (Aaron Denney)
Newsgroups: mlist.linux.kernel
Subject: Re: DNS goofups galore...
Date: 9 Feb 2001 01:50:04 GMT
Organization: California Institute of Technology, Pasadena
Message-ID: <slrn986j6c.ej0.wnoise@barter.ugcs.caltech.edu>
In-Reply-To: <linux.kernel.20010208193120.C1640@alcove.wittsend.com>
Reply-To: wnoise@ugcs.caltech.edu
NNTP-Posting-Host: barter.ugcs.caltech.edu
User-Agent: slrn/0.9.6.2 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael H. Warfield <mhw@wittsend.com> wrote:
> 	But, wait a minute.  CNAME -> CNAME is a "must not".

Cite the RFC please.  1034 says
# Domain names in RRs which point at another name should always point at
# the primary name and not the alias.
and 
# domain software should not fail when presented with CNAME
# chains or loops; CNAME chains should be followed and CNAME loops
# signalled as an error.
and
#    - The answer to the query, possibly preface by one or more CNAME
#      RRs that specify aliases encountered on the way to an answer.
and
# Multiple levels of
# aliases should be avoided due to their lack of efficiency, but should
# not be signalled as an error.

It's fairly clear that CNAMEs to CNAMEs are discouraged, but legal.

-- 
Aaron Denney
-><-
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
