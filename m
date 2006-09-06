Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932088AbWIFGw2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932088AbWIFGw2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 02:52:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932076AbWIFGw2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 02:52:28 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:60039 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1750760AbWIFGw1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 02:52:27 -0400
Date: Wed, 6 Sep 2006 10:51:54 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Arnd Bergmann <arnd.bergmann@de.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>,
       Ulrich Drepper <drepper@redhat.com>, Andrew Morton <akpm@osdl.org>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>
Subject: Re: [take15 1/4] kevent: Core files.
Message-ID: <20060906065154.GC28825@2ka.mipt.ru>
References: <1157364862688@2ka.mipt.ru> <200609051528.18437.arnd.bergmann@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <200609051528.18437.arnd.bergmann@de.ibm.com>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Wed, 06 Sep 2006 10:51:56 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 05, 2006 at 03:28:17PM +0200, Arnd Bergmann (arnd.bergmann@de.ibm.com) wrote:
> On Monday 04 September 2006 12:14, Evgeniy Polyakov wrote:
> 
> > +asmlinkage long sys_kevent_get_events(int ctl_fd, unsigned int min_nr,
> > 		unsigned int max_nr, __u64 timeout, void __user *buf,
> > 		unsigned flags) 
> > +asmlinkage long sys_kevent_ctl(int fd, unsigned int cmd, unsigned int num,
> > 		void __user *arg) 
> 
> 'void __user *arg' in both of these always points to a struct ukevent,
> according to your documentation. Shouldn't it be a 
> 'struct ukevent __user *arg' then?

Yep. I will update it in the next patchset.
Thank you.

> 	Arnd <><

-- 
	Evgeniy Polyakov
