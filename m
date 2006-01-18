Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964875AbWARDJc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964875AbWARDJc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 22:09:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964885AbWARDJb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 22:09:31 -0500
Received: from liaag1ad.mx.compuserve.com ([149.174.40.30]:54418 "EHLO
	liaag1ad.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S964875AbWARDJa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 22:09:30 -0500
Date: Tue, 17 Jan 2006 22:05:27 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [PATCH 3/4] compact print_symbol() output
To: Andi Kleen <ak@suse.de>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Jesper Juhl <jesper.juhl@gmail.com>,
       Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       Keith Owens <kaos@ocs.com.au>, Akinobu Mita <mita@miraclelinux.com>,
       Hugh Dickins <hugh@veritas.com>
Message-ID: <200601172208_MC3-1-B612-EE86@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <200601171601.52995.ak@suse.de>

On Tue, 17 Jan 2006 at 16:01:52 +0100, Andi Kleen wrote:

> On Tuesday 17 January 2006 16:01, Hugh Dickins wrote:
> 
> > I've often found symbolsize useful.  Not when looking at an oops
> > from my own machine.  But when looking at an oops posted on LKML,
> > from someone who most likely has a different .config and different
> > compiler, different optimization and different inlining from mine.
> > symbolsize is a good clue as to how close their kernel is to the
> > one I've got built on my machine, how likely guesses I make based
> > on mine will apply to theirs, and whereabouts in the function that
> > it oopsed.
> 
> Yes that is why I want it too.

OK, how about this: remove the "0x" from the function size, i.e. print:

        kernel_symbol+0xd3/10e

instead of:

        kernel_symbol+0xd3/0x10e

This saves two characters per symbol and it should still be clear that
the second number is hexadecimal.

Does that break any tools?
-- 
Chuck
