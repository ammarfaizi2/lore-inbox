Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751343AbWARGNd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751343AbWARGNd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 01:13:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751345AbWARGNd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 01:13:33 -0500
Received: from liaag2ad.mx.compuserve.com ([149.174.40.155]:20700 "EHLO
	liaag2ad.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1751343AbWARGNd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 01:13:33 -0500
Date: Wed, 18 Jan 2006 01:08:09 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [PATCH 3/4] compact print_symbol() output
To: "Valdis.Kletnieks@vt.edu" <Valdis.Kletnieks@vt.edu>
Cc: Hugh Dickins <hugh@veritas.com>, Akinobu Mita <mita@miraclelinux.com>,
       Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>,
       Jesper Juhl <jesper.juhl@gmail.com>,
       Arjan van de Ven <arjan@infradead.org>, Andi Kleen <ak@suse.de>
Message-ID: <200601180110_MC3-1-B60F-59DE@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <200601180325.k0I3P8tF008591@turing-police.cc.vt.edu>

On Tue, 17 Jan 2006 at 22:25:07 -0500, Valdis.Kletnieks wrote:

> On Tue, 17 Jan 2006 22:05:27 EST, Chuck Ebbert said:
> 
> > OK, how about this: remove the "0x" from the function size, i.e. print:
> > 
> >         kernel_symbol+0xd3/10e
> > 
> > instead of:
> > 
> >         kernel_symbol+0xd3/0x10e
> > 
> > This saves two characters per symbol and it should still be clear that
> > the second number is hexadecimal.
>
> Good.  Now repeat for a function that's 6 bytes shorter.

OK, I probably should have done that:

        kernel_symbol+0xd3/108

My point is that if the "numerator" is hex you should assume the
"denominator" is too.
-- 
Chuck
Currently reading: _Einstein's Bridge_ by John Cramer
