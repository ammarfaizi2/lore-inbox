Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261394AbVDZOqH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261394AbVDZOqH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 10:46:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261494AbVDZOqH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 10:46:07 -0400
Received: from [213.170.72.194] ([213.170.72.194]:59276 "EHLO
	shelob.oktetlabs.ru") by vger.kernel.org with ESMTP id S261394AbVDZOqB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 10:46:01 -0400
Message-ID: <426E5428.2090306@oktetlabs.ru>
Date: Tue, 26 Apr 2005 18:46:00 +0400
From: "Artem B. Bityuckiy" <dedekind@oktetlabs.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en, ru, en-us
MIME-Version: 1.0
To: Jamie Lokier <jamie@shareable.org>
Cc: Ville Herva <v@iki.fi>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: filesystem transactions API
References: <20050424211942.GN13052@parcelfarce.linux.theplanet.co.uk> <OF32F95BBA.F38B2D1F-ON88256FEE.006FE841-88256FEE.00742E46@us.ibm.com> <20050426134629.GU16169@viasys.com> <20050426141426.GC10833@mail.shareable.org> <426E4EBD.6070104@oktetlabs.ru> <20050426143247.GF10833@mail.shareable.org>
In-Reply-To: <20050426143247.GF10833@mail.shareable.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier wrote:
> Artem B. Bityuckiy wrote:
> 
> No.  A transaction means that _all_ processes will see the whole
> transaction or not.
> 
> It does _not_ mean that only a subset of programs, which happen to
> link with a particular user-space library, will see it or not.
> 
> For example, you can use transactions for distro package management: a
> whole update of a package would be a single transaction, so that at no
> time does any program see an inconsistent set of files.  See why
> _every_ process in the system must have the same view?
> 
> [ If you meant that you can implement it with a user-space library
> that every process in the system links to, that's true.  But it would
> rather misses the point of having filesystems in the kernel at all :) ]
> 
Hmm, so the whole point to implement transactions in the kernel space is 
to do the transactions in a way that nobody can see any intermediate 
inconsistent state ?


-- 
Best regards, Artem B. Bityuckiy
Oktet Labs (St. Petersburg), Software Engineer.
+78124286709 (office) +79112449030 (mobile)
E-mail: dedekind@oktetlabs.ru, web: http://www.oktetlabs.ru
