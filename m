Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263245AbTDBXw5>; Wed, 2 Apr 2003 18:52:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263247AbTDBXw5>; Wed, 2 Apr 2003 18:52:57 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:31045 "EHLO
	mtvmime01.veritas.com") by vger.kernel.org with ESMTP
	id <S263245AbTDBXw4>; Wed, 2 Apr 2003 18:52:56 -0500
Date: Thu, 3 Apr 2003 01:06:16 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Dave McCracken <dmccr@us.ibm.com>
cc: Andrew Morton <akpm@digeo.com>, <linux-mm@kvack.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.5.66-mm2] Fix page_convert_anon locking issues
In-Reply-To: <102170000.1049325787@baldur.austin.ibm.com>
Message-ID: <Pine.LNX.4.44.0304030101430.1279-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Apr 2003, Dave McCracken wrote:
> --On Wednesday, April 02, 2003 15:09:03 -0800 Andrew Morton
> <akpm@digeo.com> wrote:
> > 
> > How about setting PageAnon at the _start_ of the operation? 
> > page_remove_rmap() will cope with that OK.
> 
> Hmm... I was gonna say that page_remove_rmap will BUG() if it doesn't find
> the entry, but it's only under DEBUG and could easily be changed.  Lemme
> think on this one a bit.  I need to assure myself it's safe to go unlocked
> in the middle.

Yes, it's an interesting idea, but by no means clear it's safe.
I'll think about it too, but sorry, no more tonight.

Hugh

