Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266353AbTAFNLU>; Mon, 6 Jan 2003 08:11:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266367AbTAFNLU>; Mon, 6 Jan 2003 08:11:20 -0500
Received: from pc-62-31-66-84-ed.blueyonder.co.uk ([62.31.66.84]:16769 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S266353AbTAFNLU>; Mon, 6 Jan 2003 08:11:20 -0500
Subject: Re: 2.4.21-pre2 stalls out when running unixbench
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Andrew Morton <akpm@digeo.com>
Cc: Joe Korty <joe.korty@ccur.com>, Andreas Dilger <adilger@clusterfs.com>,
       rusty@rustcorp.com.au, riel@conectiva.com.br,
       linux-kernel@vger.kernel.org, hch@sgi.com,
       Stephen Tweedie <sct@redhat.com>
In-Reply-To: <3E19739F.84C57EFC@digeo.com>
References: <3E16C171.BFEA45AE@digeo.com>
	<1041855042.2690.2.camel@sisko.scot.redhat.com> 
	<3E19739F.84C57EFC@digeo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 06 Jan 2003 13:23:55 +0000
Message-Id: <1041859435.2691.51.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 2003-01-06 at 12:16, Andrew Morton wrote:

> Well personally I prefer slow-and-safe.  But we could make 2.4
> do what 2.5 is doing - one pass through the superblocks to start
> the syncs and a second pass to wait on them all.

The 2.5 approach has the problem that it can start queuing writeback for
multiple fs'es on the same disk at the same time --- I wouldn't be
surprised if it increases thrashing in that case.  But I guess I'm not
too concerned about sync() performance itself, as long as the in-kernel
background writeback is being done sensibly.

> This is fragile stuff though....

Yep.

--Stephen

