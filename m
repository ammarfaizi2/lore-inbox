Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030199AbWGZHNU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030199AbWGZHNU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 03:13:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932519AbWGZHNU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 03:13:20 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:45209 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932515AbWGZHNU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 03:13:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=GKPlOu9n9SGjrEtL0ROA8bvApY63bP9DBP3xblHvwHD9XE1NsWlfymuGRwAem0vDxiimmqmgKVPuAMgPQgun2OAIbzvbyiIFGSl0kY2rQHjFuPyBNU+QjGdN0C7Mhpazbb7IYNZyvtv9mGN5CX+oSw2QhPH+YUWGtHGDl5uXoh0=
Date: Wed, 26 Jul 2006 11:13:18 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: "Michael S. Tsirkin" <mst@mellanox.co.il>, Ingo Molnar <mingo@elte.hu>,
       Zach Brown <zach.brown@oracle.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH] lockdep: don't pull in includes when lockdep disabled
Message-ID: <20060726071318.GA6824@martell.zuzino.mipt.ru>
References: <20060704115656.GA1539@elte.hu> <20060726062647.GA8711@mellanox.co.il> <1153895599.2896.4.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1153895599.2896.4.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2006 at 08:33:19AM +0200, Arjan van de Ven wrote:
> On Wed, 2006-07-26 at 09:26 +0300, Michael S. Tsirkin wrote:
> > Ingo, does the following look good to you?
> >
> > Do not pull in various includes through lockdep.h if lockdep is disabled.
> 
> Hi,
> 
> can you tell us what this fixes? Eg is there a specific problem?

[raises hand]
Zillions of warnings on m68k allmodconfig. And, yes, patch removes them.

In file included from ...
		 from ...
include/linux/list.h: In function `__list_add_rcu':
include/linux/list.h:89: warning: implicit declaration of function `smp_wmb'

> I mean... we're adding ifdefs so there better be a real good reason for
> them.... fixing something real would be such a reason ;-)

