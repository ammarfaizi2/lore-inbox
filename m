Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316153AbSEJWvV>; Fri, 10 May 2002 18:51:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316157AbSEJWvU>; Fri, 10 May 2002 18:51:20 -0400
Received: from ns.suse.de ([213.95.15.193]:30227 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S316153AbSEJWvU>;
	Fri, 10 May 2002 18:51:20 -0400
Date: Sat, 11 May 2002 00:51:15 +0200
From: Dave Jones <davej@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@zip.com.au>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] BUG() disassembly tweak
Message-ID: <20020511005115.N5262@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Linus Torvalds <torvalds@transmeta.com>,
	Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@zip.com.au>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0205102216160.3747-100000@localhost.localdomain> <Pine.LNX.4.33.0205101457120.22516-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 10, 2002 at 03:10:04PM -0700, Linus Torvalds wrote:
 > If it wants to be changed, I'd actually personally prefer it to be changed
 > to take an explicit string instead of using the filename/linenr at all.

rather than fixing up the gazillions of existing BUG()'s we have
littered through the tree, maybe we could default to current behaviour
if no argument is passed ?

Failing that, resurrecting the k_assert() idea someone proposed
(jgarzik?) a few months back.

One reason for doing this would be to make it less painful for people
writing drivers that compile on 2.4/2.6        

    Dave.

--   
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
