Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964903AbWAZWDI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964903AbWAZWDI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 17:03:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964905AbWAZWDI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 17:03:08 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:30444 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S964903AbWAZWDH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 17:03:07 -0500
Message-ID: <43D94714.2030506@us.ibm.com>
Date: Thu, 26 Jan 2006 14:03:00 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pekka Enberg <penberg@cs.helsinki.fi>
CC: linux-kernel@vger.kernel.org, sri@us.ibm.com, andrea@suse.de,
       pavel@suse.cz, linux-mm@kvack.org
Subject: Re: [patch 6/9] mempool - Update kzalloc mempool users
References: <20060125161321.647368000@localhost.localdomain>	 <1138218014.2092.6.camel@localhost.localdomain> <84144f020601252330k61789482m25a4316c2c254065@mail.gmail.com>
In-Reply-To: <84144f020601252330k61789482m25a4316c2c254065@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka Enberg wrote:
> Hi,
> 
> On 1/25/06, Matthew Dobson <colpatch@us.ibm.com> wrote:
> 
>>plain text document attachment (critical_mempools)
>>Fixup existing mempool users to use the new mempool API, part 3.
>>
>>This mempool users which are basically just wrappers around kzalloc().  To do
>>this we create a new function, kzalloc_node() and change all the old mempool
>>allocators which were calling kzalloc() to now call kzalloc_node().
> 
> 
> The slab bits look good to me. You might have some rediffing to do
> because -mm has quite a bit of slab patches in it.
> 
> Acked-by: Pekka Enberg <penberg@cs.helsinki.fi>
> 
>                                Pekka

Good to hear.  I expect there to be plenty of differences.  Some pieces of
this are ready to be pushed now, but most of it is still very much in
planning/design stage.  My hopes (which I probably should have made more
clear in the introductory email) are just to get feedback on the general
approach to the problem that I'm pursuing.

Thanks!

-Matt
