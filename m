Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261802AbVAYEGf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261802AbVAYEGf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 23:06:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261803AbVAYEGe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 23:06:34 -0500
Received: from tomts20.bellnexxia.net ([209.226.175.74]:44755 "EHLO
	tomts20-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S261802AbVAYEG2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 23:06:28 -0500
Subject: Re: [patch 1/13] Qsort
From: Eric St-Laurent <ericstl34@sympatico.ca>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
In-Reply-To: <200501250044.j0P0iPG3031683@inf.utfsm.cl>
References: <200501250044.j0P0iPG3031683@inf.utfsm.cl>
Content-Type: text/plain
Date: Mon, 24 Jan 2005 23:06:26 -0500
Message-Id: <1106625987.18485.6.camel@orbiter>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-01-24 at 21:43 -0300, Horst von Brand wrote:
> AFAICS, this is just a badly implemented Shellsort (the 10/13 increment
> sequence starting with the number of elements is probably not very good,
> besides swapping stuff is inefficient (just juggling like Shellsort does
> gives you almost a third less copies)).
> 
> Have you found a proof for the O(n log n) claim?

"Why a Comb Sort is NOT a Shell Sort

A shell sort completely sorts the data for each gap size. A comb sort
takes a more optimistic approach and doesn't require data be completely
sorted at a gap size. The comb sort assumes that out-of-order data will
be cleaned-up by smaller gap sizes as the sort proceeds. "

Reference:

http://world.std.com/~jdveale/combsort.htm

Another good reference:

http://yagni.com/combsort/index.php

Personally, i've used it in the past because of it's small size.  With
C++ templates you can have a copy of the routine generated for a
specific datatype, thus skipping the costly function call used for each
compare.  With some C macro magic, i presume something similar can be
done, for time-critical applications.

Best regards,

Eric St-Laurent


