Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751283AbWBCRvc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751283AbWBCRvc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 12:51:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbWBCRvc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 12:51:32 -0500
Received: from smtp.osdl.org ([65.172.181.4]:23691 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751283AbWBCRvb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 12:51:31 -0500
Date: Fri, 3 Feb 2006 09:49:56 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Kirill Korotaev <dev@sw.ru>
cc: Kirill Korotaev <dev@openvz.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       frankeh@watson.ibm.com, clg@fr.ibm.com, haveblue@us.ibm.com,
       greg@kroah.com, alan@lxorguk.ukuu.org.uk, serue@us.ibm.com,
       arjan@infradead.org, Rik van Riel <riel@redhat.com>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       Andrey Savochkin <saw@sawoct.com>, devel@openvz.org,
       Pavel Emelianov <xemul@sw.ru>
Subject: Re: [RFC][PATCH 1/5] Virtualization/containers: startup
In-Reply-To: <43E3915A.2080000@sw.ru>
Message-ID: <Pine.LNX.4.64.0602030939250.4630@g5.osdl.org>
References: <43E38BD1.4070707@openvz.org> <Pine.LNX.4.64.0602030905380.4630@g5.osdl.org>
 <43E3915A.2080000@sw.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 3 Feb 2006, Kirill Korotaev wrote:
> 
> Do you have any other ideas/comments on this?
> I will send additional IPC/filesystems virtualization patches a bit later.

I think that a patch like this - particularly just the 1/5 part - makes 
total sense, because regardless of any other details of virtualization, 
every single scheme is going to need this.

So I think at least 1/5 (and quite frankly, 2-3/5 look that way too) are 
things that we can (and probably should) merge quickly, so that people can 
then actually look at the differences in the places that they may actually 
disagree about.

One thing I don't particularly like is some of the naming. To me "vps" 
doesn't sound particularly generic or logical. I realize that it probably 
makes perfect sense to you (and I assume it just means "virtual private 
servers"), but especially if you see patches 1-3 to really be independent 
of any "actual" virtualization code that is totally generic, I'd actually 
prefer a less specialized name.

I realize that what things like this is used for is VPS web hosting etc, 
but that's really naming by current common usage, not by any real "logic".

In other words, I personally would have called them "container" or 
something similar, rather than "vps_info". See? From a logical 
implementation standpoint, the fact that it is right now most commonly 
used for VPS hosting is totally irrelevant to the code, no?

(And hey, maybe your "vps" means something different. In which case my 
argument makes even more sense ;)

		Linus
