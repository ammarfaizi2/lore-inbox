Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262112AbUJZEVk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262112AbUJZEVk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 00:21:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262160AbUJZESf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 00:18:35 -0400
Received: from smtp206.mail.sc5.yahoo.com ([216.136.129.96]:53166 "HELO
	smtp206.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262155AbUJZERo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 00:17:44 -0400
Message-ID: <417DCFDD.50606@yahoo.com.au>
Date: Tue, 26 Oct 2004 14:17:33 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@novell.com>
CC: Rik van Riel <riel@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: lowmem_reserve (replaces protection)
References: <20041025170128.GF14325@dualathlon.random> <Pine.LNX.4.44.0410252147330.30224-100000@chimarrao.boston.redhat.com> <20041026015825.GU14325@dualathlon.random> <417DC8F2.7000902@yahoo.com.au> <20041026040429.GW14325@dualathlon.random>
In-Reply-To: <20041026040429.GW14325@dualathlon.random>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> On Tue, Oct 26, 2004 at 01:48:02PM +1000, Nick Piggin wrote:
> 
>>I see classzone_idx snuck in, can we leave that as alloc_type please?
> 
> 
> when I wrote that code in 2.4 it was called class_idx. Just to show it
> was not an opaque type, in this 2.6 I called it classzone_idx but it's
> the same as class_idx. If you feel classzone_idx is too long I'm sure
> fine to rename to class_idx like plain 2.4.
> 
> The reason I renamed it is that alloc_type tells nothing to who's
> reading the code. That value in the opaque "alloc_type" variable, is
> really the classzone_idx that identify the classzone we have to allocate
> memory from. Classzone 2 means "all ram is good", classzone 2 means
> "zone-normal + zone-dma is good", classzone 0 means "zone-dma is good".
> 

OK that makes sense... it isn't the length of the name, but the fact
that that naming convention hasn't proliferated thoughout the 2.6 tree;
maybe could you add a little comment along the lines of the above?
Thanks
