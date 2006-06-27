Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161254AbWF0TBe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161254AbWF0TBe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 15:01:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161255AbWF0TBe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 15:01:34 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:7370 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1161254AbWF0TBd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 15:01:33 -0400
Message-ID: <44A1809F.5030306@sgi.com>
Date: Tue, 27 Jun 2006 21:01:51 +0200
From: Jes Sorensen <jes@sgi.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Trond Myklebust <trond.myklebust@fys.uio.no>
CC: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, David Brownell <david-b@pacbell.net>
Subject: Re: [patch] fix static linking of NFS
References: <yq04py7j699.fsf@jaguar.mkp.net>	 <1151426029.23773.7.camel@lade.trondhjem.org> <1151426697.23773.10.camel@lade.trondhjem.org>
In-Reply-To: <1151426697.23773.10.camel@lade.trondhjem.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust wrote:
> On Tue, 2006-06-27 at 12:33 -0400, Trond Myklebust wrote:
>>> Remove __exit declarations from functions called from __init code to
>>> avoid link errors when the __exit section is discarded, eg NFS is
>>> linked statically into the kernel.
>>>
>>> Signed-off-by: Jes Sorensen <jes@sgi.com>
>> Acked-by: Trond Myklebust <Trond.Myklebust@netapp.com>
> 
> Oops... I was a bit too quick there. Could you clean up  the forward
> declarations in "internal.h" too, please.
> 
> Cheers,
>   Trond

Good point, I didn't notice those because the compiler didn't moan. I'll
look into doing another patch, but it might not be until Thursday.

Cheers,
Jes
