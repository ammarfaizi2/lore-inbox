Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261286AbULWTVX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261286AbULWTVX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Dec 2004 14:21:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261271AbULWTVX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Dec 2004 14:21:23 -0500
Received: from mx1.redhat.com ([66.187.233.31]:14527 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261286AbULWTVU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Dec 2004 14:21:20 -0500
Date: Thu, 23 Dec 2004 14:21:15 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, Robert_Hentosh@Dell.com
Subject: Re: [PATCH][1/2] adjust dirty threshold for lowmem-only mappings
In-Reply-To: <20041220125443.091a911b.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0412231420260.5468@chimarrao.boston.redhat.com>
References: <Pine.LNX.4.61.0412201013080.13935@chimarrao.boston.redhat.com>
 <20041220125443.091a911b.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Dec 2004, Andrew Morton wrote:
> Rik van Riel <riel@redhat.com> wrote:
>>
>> Simply running "dd if=/dev/zero of=/dev/hd<one you can miss>" will
>>  result in OOM kills, with the dirty pagecache completely filling up
>>  lowmem.
>
> That surely used to work - I have a feeling that it got broken somehow.
> The below might fix it, but probably not.

Even all 3 patches together don't seem to have fixed
the bug completely.  The time needed to trigger the
bug has gone up though, from 5 minutes to a day ...

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
