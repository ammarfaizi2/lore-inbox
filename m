Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319227AbSHNAEz>; Tue, 13 Aug 2002 20:04:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319226AbSHNAEz>; Tue, 13 Aug 2002 20:04:55 -0400
Received: from c-180-196-7.ka.dial.de.ignite.net ([62.180.196.7]:28812 "EHLO
	dea.linux-mips.net") by vger.kernel.org with ESMTP
	id <S319227AbSHNAEy>; Tue, 13 Aug 2002 20:04:54 -0400
Date: Wed, 14 Aug 2002 02:08:25 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Imran Badr <imran.badr@cavium.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Cache coherency and snooping
Message-ID: <20020814020825.A11382@linux-mips.org>
References: <Pine.SOL.4.44.0208131856550.25942-100000@rastan.gpcc.itd.umich.edu> <0a9a01c24320$4c936de0$9e10a8c0@IMRANPC>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <0a9a01c24320$4c936de0$9e10a8c0@IMRANPC>; from imran.badr@cavium.com on Tue, Aug 13, 2002 at 04:22:31PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2002 at 04:22:31PM -0700, Imran Badr wrote:

> How can I define a certain region of memory so that it is never cached? I
> want to use non-cached region of memory to communicate to my PCI device to
> avoid system overhead in cache snooping.

On every sane platform the hardware performs better at keeping the
coherency than software ever could.  Don't even think about it unless
you for some reason absolutely must disable caching.  Aside and as Alan
already mentioned the allocation of uncached memory isn't supported.

  Ralf
