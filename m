Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268272AbTCFT1w>; Thu, 6 Mar 2003 14:27:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268281AbTCFT1w>; Thu, 6 Mar 2003 14:27:52 -0500
Received: from pixpat.austin.ibm.com ([192.35.232.241]:40408 "EHLO
	baldur.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S268272AbTCFT1v>; Thu, 6 Mar 2003 14:27:51 -0500
Date: Thu, 06 Mar 2003 13:38:07 -0600
From: Dave McCracken <dmccr@us.ibm.com>
To: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@digeo.com>
cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nonlinear oddities
Message-ID: <57080000.1046979487@baldur.austin.ibm.com>
In-Reply-To: <Pine.LNX.4.44.0303061903170.1215-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0303061903170.1215-100000@localhost.localdomain>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--On Thursday, March 06, 2003 19:14:47 +0000 Hugh Dickins
<hugh@veritas.com> wrote:

> Now I think about it more, install_page's SetPageAnon is not good at all.
> That (unlocked) page may already be mapped into other vmas as a shared
> file page, non-zero mapcount, we can't suddenly switch it to Anon
> (pte_chained) without doing the work to handle that case.

Ouch.  You're right.  I'll go stare at it for awhile and see if any
solutions jump out at me.  I suppose at worst I could write a function to
convert an object page to use pte_chains, but it'd be nice if that weren't
necessary.

Dave McCracken

======================================================================
Dave McCracken          IBM Linux Base Kernel Team      1-512-838-3059
dmccr@us.ibm.com                                        T/L   678-3059

