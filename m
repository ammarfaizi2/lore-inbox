Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030233AbWHDFSW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030233AbWHDFSW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 01:18:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030235AbWHDFSW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 01:18:22 -0400
Received: from 1wt.eu ([62.212.114.60]:22541 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S1030233AbWHDFSV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 01:18:21 -0400
Date: Fri, 4 Aug 2006 07:08:43 +0200
From: Willy Tarreau <w@1wt.eu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jukka Partanen <jspartanen@gmail.com>, kkeil@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.4.32] Fix AVM C4 ISDN card init problems with newer CPUs
Message-ID: <20060804050843.GB8776@1wt.eu>
References: <d50597c30608030953l41e8661dg1c10faeac31cc87f@mail.gmail.com> <1154627776.23655.106.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1154627776.23655.106.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2006 at 06:56:15PM +0100, Alan Cox wrote:
> Ar Iau, 2006-08-03 am 19:53 +0300, ysgrifennodd Jukka Partanen:
> > AVM C4 ISDN NIC: Add three memory barriers, taken from 2.6.7,
> > (they are there in 2.6.17.7 too), to fix module initialization
> > problems appearing with at least some newer Celerons and
> > Pentium III.
> 
> Should be using cpu_relax() I think. Its a polled busy loop so you want
> other CPU threads to run if possible.

Agreed, but I think it should be a second patch since 2.6 would need it
too.

> Otherwise the code seems quite logical depending how c4inmeml is defined.

OK, I'm queuing it for 2.4.34.

> Alan

Willy

