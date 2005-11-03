Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030186AbVKCNdW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030186AbVKCNdW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 08:33:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030192AbVKCNdW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 08:33:22 -0500
Received: from silver.veritas.com ([143.127.12.111]:51024 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S1030186AbVKCNdV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 08:33:21 -0500
Date: Thu, 3 Nov 2005 13:32:15 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Gleb Natapov <gleb@minantech.com>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Petr Vandrovec <vandrove@vc.cvut.cz>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Nick's core remove PageReserved broke vmware...
In-Reply-To: <20051103080341.GB22185@minantech.com>
Message-ID: <Pine.LNX.4.61.0511031327360.22826@goblin.wat.veritas.com>
References: <4367C25B.7010300@vc.cvut.cz> <4368097A.1080601@yahoo.com.au>
 <4368139A.30701@vc.cvut.cz> <Pine.LNX.4.61.0511021208070.7300@goblin.wat.veritas.com>
 <1130965454.20136.50.camel@gaston> <Pine.LNX.4.61.0511022112530.18174@goblin.wat.veritas.com>
 <1130967936.20136.65.camel@gaston> <Pine.LNX.4.61.0511022157130.18559@goblin.wat.veritas.com>
 <1130970131.20136.73.camel@gaston> <20051103080341.GB22185@minantech.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 03 Nov 2005 13:33:21.0124 (UTC) FILETIME=[28469240:01C5E07B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Nov 2005, Gleb Natapov wrote:
> On Thu, Nov 03, 2005 at 09:22:10AM +1100, Benjamin Herrenschmidt wrote:
> > Also, what do you suggest as a good threshold to use on the max amount
> > of memory I can let the X server "pin" that way ? I was thinking it as
> > equivalent to mlock, thus I could maybe hijack mm->locked_vm & use
> > RLIMIT_MEMLOCK or is that too gross ?
> > 
> This is what infiniband does, so it should be good for you too.

Yes, I noticed that code a couple of days ago, I think you're setting a
good example there, for long-term or large-area uses of get_user_pages():
Ben, take a look at drivers/infiniband/core/uverbs_mem.c

Hugh
