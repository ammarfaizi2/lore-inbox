Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262091AbVELSH1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262091AbVELSH1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 14:07:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262092AbVELSH1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 14:07:27 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:58365 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S262091AbVELSHN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 14:07:13 -0400
Date: Thu, 12 May 2005 19:06:55 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Jesper Juhl <juhl-lkml@dif.dk>
cc: Paulo Marques <pmarques@grupopie.com>, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>, davem@davemloft.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel/module.c has something to hide. (whitespace
    cleanup)
In-Reply-To: <Pine.LNX.4.62.0505121925160.2390@dragon.hyggekrogen.localhost>
Message-ID: <Pine.LNX.4.61.0505121901390.5197@goblin.wat.veritas.com>
References: <20050510161657.3afb21ff.akpm@osdl.org> 
    <20050510.161907.116353193.davem@davemloft.net> 
    <20050510170246.5be58840.akpm@osdl.org> 
    <20050510.170946.10291902.davem@davemloft.net> 
    <Pine.LNX.4.62.0505110217350.2386@dragon.hyggekrogen.localhost> 
    <20050510172913.2d47a4d4.akpm@osdl.org> 
    <Pine.LNX.4.62.0505110236520.2386@dragon.hyggekrogen.localhost> 
    <4281E78B.2030103@grupopie.com> <20050511225657.GM6884@stusta.de> 
    <42834935.9060404@grupopie.com> <42835BDB.40505@grupopie.com> 
    <Pine.LNX.4.62.0505121925160.2390@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-OriginalArrivalTime: 12 May 2005 18:06:16.0104 (UTC) 
    FILETIME=[4A3BFA80:01C5571D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 May 2005, Jesper Juhl wrote:
> On Thu, 12 May 2005, Paulo Marques wrote:
> > 
> > At least with my config, if I remove both instances of UTS_VERSION from
> > init/version.c, the resulting vmlinux files are exactly identical with the
> > same sha1sum.
> > 
> > So maybe Jesper can use this to make *really* sure that there are no actual
> > changes with the patches, just whitespace changes.
> 
> Yeah, that does seem to work. I had not thought of that - thanks.

If you're going so far as to change the line numbering (which is very
much your intention!), then you'll also need to suppress any __LINE__s
for that check.  Switching off CONFIG_DEBUG_BUGVERBOSE should suppress
most of them.

Hugh
