Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261666AbSJUVdO>; Mon, 21 Oct 2002 17:33:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261690AbSJUVdO>; Mon, 21 Oct 2002 17:33:14 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:63191 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261666AbSJUVdO>;
	Mon, 21 Oct 2002 17:33:14 -0400
Date: Mon, 21 Oct 2002 14:33:35 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-mm mailing list <linux-mm@kvack.org>
Subject: Re: ZONE_NORMAL exhaustion (dcache slab)
Message-ID: <309670000.1035236015@flay>
In-Reply-To: <3DB472B6.BC5B8924@digeo.com>
References: <3DB46DFA.DFEB2907@digeo.com> <308170000.1035234988@flay> <3DB472B6.BC5B8924@digeo.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Nope, kept OOMing and killing everything .
> 
> Something broke.

Even I worked that out ;-) 

> Blockdevices only use ZONE_NORMAL for their pagecache.  That cat will
> selectively put pressure on the normal zone (and DMA zone, of course).

Ah, I recall that now. That's fundamentally screwed.
  
>> Will try again. Presumably "find /" should do it? ;-)
> 
> You must have a lot of files.

Nothing too ridiculous. Will try find on a small subset repeatedly and see if
it keeps growing first - maybe that'll show a leak.
 
Thanks,

M.

