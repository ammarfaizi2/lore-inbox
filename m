Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262008AbVATAsA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262008AbVATAsA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 19:48:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262009AbVATAsA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 19:48:00 -0500
Received: from fw.osdl.org ([65.172.181.6]:33985 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262008AbVATArx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 19:47:53 -0500
Date: Wed, 19 Jan 2005 16:47:44 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Roland McGrath <roland@redhat.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cputime_t patches broke RLIMIT_CPU
In-Reply-To: <200501200026.j0K0QFst021029@magilla.sf.frob.com>
Message-ID: <Pine.LNX.4.58.0501191642230.8178@ppc970.osdl.org>
References: <200501200026.j0K0QFst021029@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 19 Jan 2005, Roland McGrath wrote:
> 
> Yes, that's how it was done before.  The patch I just posted was intended
> to fix the apparent typo without getting any deeper.  Below is an untested
> alternate patch to restore the old behavior under the new macro regime.

Thanks, this one looks good. I have this nagging feeling that the test for 
"every second" should be doable by using a multiply (ie do a
secs_to_cputime(secs) and see if it's smaller than "total - cputime") 
rather than doing the divide that is implied by "cputime_to_secs()", but I 
can't really bring myself to care, and if anything, that test for "did we 
go into the next whole second" really is pretty obscure anyway.

So I can't see anything wrong with this. Anybody else? Going, going..

		Linus "almost gone" Torvalds
