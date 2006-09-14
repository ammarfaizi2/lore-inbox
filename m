Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751203AbWINGft@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751203AbWINGft (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 02:35:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751372AbWINGft
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 02:35:49 -0400
Received: from mx1.redhat.com ([66.187.233.31]:52880 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751203AbWINGfs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 02:35:48 -0400
Date: Thu, 14 Sep 2006 02:35:42 -0400
From: Dave Jones <davej@redhat.com>
To: Jarek Poplawski <jarkao2@o2.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mpparse.c:231: warning: comparison is always false
Message-ID: <20060914063542.GB32642@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Jarek Poplawski <jarkao2@o2.pl>, linux-kernel@vger.kernel.org
References: <20060913065010.GA2110@ff.dom.local> <20060913164251.GD13956@redhat.com> <20060914053647.GA1640@ff.dom.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060914053647.GA1640@ff.dom.local>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2006 at 07:36:47AM +0200, Jarek Poplawski wrote:
 > On Wed, Sep 13, 2006 at 12:42:51PM -0400, Dave Jones wrote:
 > > On Wed, Sep 13, 2006 at 08:50:10AM +0200, Jarek Poplawski wrote:
 > ...  
 > >  > +#if 0xFF >= MAX_MP_BUSSES
 > >  >  	if (m->mpc_busid >= MAX_MP_BUSSES) {
 > >  >  		printk(KERN_WARNING "MP table busid value (%d) for bustype %s "
 > >  >  			" is too large, max. supported is %d\n",
 > >  >  			m->mpc_busid, str, MAX_MP_BUSSES - 1);
 > >  >  		return;
 > >  >  	}
 > >  > +#endif
 > > 
 > > mpc_busid is a uchar. I don't see how this can ever be > 0xff, yet
 > > mach-summit and mach-generic have MAX_MP_BUSSES set to 260.
 > > 
 > > I don't see how this can possibly work.
 > 
 > 0xFF >= 260 is false so the block is not compiled and
 > the warning is gone (+ several bytes of useless code).

Yes, I understand your patch. What I don't understand is why summit/generic
have this set so high in the first place.

	Dave

