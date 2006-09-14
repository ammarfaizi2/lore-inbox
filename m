Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751345AbWINFc7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751345AbWINFc7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 01:32:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751346AbWINFc6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 01:32:58 -0400
Received: from mx10.go2.pl ([193.17.41.74]:16818 "EHLO poczta.o2.pl")
	by vger.kernel.org with ESMTP id S1751345AbWINFc6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 01:32:58 -0400
Date: Thu, 14 Sep 2006 07:36:47 +0200
From: Jarek Poplawski <jarkao2@o2.pl>
To: Dave Jones <davej@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mpparse.c:231: warning: comparison is always false
Message-ID: <20060914053647.GA1640@ff.dom.local>
References: <20060913065010.GA2110@ff.dom.local> <20060913164251.GD13956@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060913164251.GD13956@redhat.com>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2006 at 12:42:51PM -0400, Dave Jones wrote:
> On Wed, Sep 13, 2006 at 08:50:10AM +0200, Jarek Poplawski wrote:
...  
>  > +#if 0xFF >= MAX_MP_BUSSES
>  >  	if (m->mpc_busid >= MAX_MP_BUSSES) {
>  >  		printk(KERN_WARNING "MP table busid value (%d) for bustype %s "
>  >  			" is too large, max. supported is %d\n",
>  >  			m->mpc_busid, str, MAX_MP_BUSSES - 1);
>  >  		return;
>  >  	}
>  > +#endif
> 
> mpc_busid is a uchar. I don't see how this can ever be > 0xff, yet
> mach-summit and mach-generic have MAX_MP_BUSSES set to 260.
> 
> I don't see how this can possibly work.
> 
> 	Dave
> 

0xFF >= 260 is false so the block is not compiled and
the warning is gone (+ several bytes of useless code).

Jarek P.
