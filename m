Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265873AbTGDIeg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jul 2003 04:34:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265874AbTGDIeg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jul 2003 04:34:36 -0400
Received: from [66.212.224.118] ([66.212.224.118]:65036 "EHLO
	hemi.commfireservices.com") by vger.kernel.org with ESMTP
	id S265873AbTGDIef (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jul 2003 04:34:35 -0400
Date: Fri, 4 Jul 2003 04:37:51 -0400 (EDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
X-X-Sender: zwane@montezuma.mastecende.com
To: Andrew Morton <akpm@osdl.org>
Cc: wli@holomorphy.com, helgehaf@aitel.hist.no, zboszor@freemail.hu,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5.74-mm1
In-Reply-To: <20030704012734.77f99e74.akpm@osdl.org>
Message-ID: <Pine.LNX.4.53.0307040437100.24383@montezuma.mastecende.com>
References: <3F0407D1.8060506@freemail.hu> <3F042AEE.2000202@freemail.hu>
 <20030703122243.51a6d581.akpm@osdl.org> <20030703200858.GA31084@hh.idb.hist.no>
 <20030703141508.796e4b82.akpm@osdl.org> <20030704055315.GW26348@holomorphy.com>
 <Pine.LNX.4.53.0307040307090.24383@montezuma.mastecende.com>
 <20030704012734.77f99e74.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Jul 2003, Andrew Morton wrote:

> static inline void bitmap_or(unsigned long *dst, unsigned long *bitmap1,
>                                 unsigned long *bitmap2, int bits)
> {
>         int k;
>         int nr = BITS_TO_LONGS(bits);
> 
>         for (k = 0; k < nr; k++)
>                 dst[k] = bitmap1[k] | bitmap2[k];
> }
> 
> fixes it up, and looks nicer anyway.  Removing the volatiles (what were
> they doing there?) did not fix it.  The `nr' thing fixed it.  
> 
> I shall make that change.

Very nice, thanks!

	Zwane
-- 
function.linuxpower.ca
