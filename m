Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751263AbWHUWoY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751263AbWHUWoY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 18:44:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751269AbWHUWoX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 18:44:23 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:8359 "EHLO e36.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751263AbWHUWoX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 18:44:23 -0400
Subject: Re: [ckrm-tech] [RFC][PATCH] UBC: user resource beancounters
From: Chandra Seetharaman <sekharan@us.ibm.com>
Reply-To: sekharan@us.ibm.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Rik van Riel <riel@redhat.com>, ckrm-tech@lists.sourceforge.net,
       Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>, Andrey Savochkin <saw@sw.ru>,
       hugh@veritas.com, Ingo Molnar <mingo@elte.hu>,
       Kirill Korotaev <dev@sw.ru>, devel@openvz.org,
       Pavel Emelianov <xemul@openvz.org>
In-Reply-To: <1156198835.18887.87.camel@localhost.localdomain>
References: <44E33893.6020700@sw.ru>
	 <1155929992.26155.60.camel@linuxchandra>  <44E9B3F5.3010000@sw.ru>
	 <1156196721.6479.67.camel@linuxchandra>
	 <1156198835.18887.87.camel@localhost.localdomain>
Content-Type: text/plain
Organization: IBM
Date: Mon, 21 Aug 2006 15:44:19 -0700
Message-Id: <1156200259.6479.74.camel@linuxchandra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-08-21 at 23:20 +0100, Alan Cox wrote:
> Ar Llu, 2006-08-21 am 14:45 -0700, ysgrifennodd Chandra Seetharaman:
> > As I mentioned UBC might be perfect for container resource management,
> > but what I am talking for is resource management _without_ a container.
> 
> There isn't really a difference. UBC counts usage of things. It has to
> know who to charge the thing to but its core concept of the luid isn't a
> container, its more akin to the a departmental or project billing code.

I didn't say it is different. The way it is implemented now has some
restrictions for generic resource management purposes (like ability to
move task around), but they are not a problem for container type usage.
 
> 
> > > 3. is it so BIG obstacle for UBC patch? These 3-lines hooks code which
> > >    is not used?
> 
> Add them later when they prove to be needed. If IBM send a feature that
> needs it then add them in that feature. Everyone is happy it is possible
> to add that hook when needed.

As I mentioned in my reply, I am ok with adding it later.

>  
> > In a non-container situation IMO it will be easier to manage/associate
> > "gold", "silver", "bronze", "plastic" groups than 0, 11, 83 and 113.
> 
> User space issue. Doing that in kernel will lead to some limitations
> later on and end up needing the user space anyway. Consider wanting to
> keep the container name and properties in LDAP.
> 
> 
> 
> 
> -------------------------------------------------------------------------
> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job easier
> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
> _______________________________________________
> ckrm-tech mailing list
> https://lists.sourceforge.net/lists/listinfo/ckrm-tech
-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------


