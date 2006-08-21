Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751228AbWHUWCI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751228AbWHUWCI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 18:02:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751225AbWHUWCI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 18:02:08 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:63690 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751228AbWHUWCG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 18:02:06 -0400
Subject: Re: [ckrm-tech] [RFC][PATCH] UBC: user resource beancounters
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: sekharan@us.ibm.com
Cc: Kirill Korotaev <dev@sw.ru>, Rik van Riel <riel@redhat.com>,
       ckrm-tech@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Christoph Hellwig <hch@infradead.org>,
       Andrey Savochkin <saw@sw.ru>, devel@openvz.org, hugh@veritas.com,
       Ingo Molnar <mingo@elte.hu>, Pavel Emelianov <xemul@openvz.org>
In-Reply-To: <1156196721.6479.67.camel@linuxchandra>
References: <44E33893.6020700@sw.ru>
	 <1155929992.26155.60.camel@linuxchandra>  <44E9B3F5.3010000@sw.ru>
	 <1156196721.6479.67.camel@linuxchandra>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 21 Aug 2006 23:20:35 +0100
Message-Id: <1156198835.18887.87.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-08-21 am 14:45 -0700, ysgrifennodd Chandra Seetharaman:
> As I mentioned UBC might be perfect for container resource management,
> but what I am talking for is resource management _without_ a container.

There isn't really a difference. UBC counts usage of things. It has to
know who to charge the thing to but its core concept of the luid isn't a
container, its more akin to the a departmental or project billing code.

> > 3. is it so BIG obstacle for UBC patch? These 3-lines hooks code which
> >    is not used?

Add them later when they prove to be needed. If IBM send a feature that
needs it then add them in that feature. Everyone is happy it is possible
to add that hook when needed.
 
> In a non-container situation IMO it will be easier to manage/associate
> "gold", "silver", "bronze", "plastic" groups than 0, 11, 83 and 113.

User space issue. Doing that in kernel will lead to some limitations
later on and end up needing the user space anyway. Consider wanting to
keep the container name and properties in LDAP.



