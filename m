Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266366AbUIONpB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266366AbUIONpB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 09:45:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266364AbUIONnt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 09:43:49 -0400
Received: from users.ccur.com ([208.248.32.211]:7664 "EHLO mig.iccur.com")
	by vger.kernel.org with ESMTP id S266333AbUIONkw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 09:40:52 -0400
Date: Wed, 15 Sep 2004 09:40:47 -0400
From: Joe Korty <joe.korty@ccur.com>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] tune vmalloc size
Message-ID: <20040915134047.GA30493@tsunami.ccur.com>
Reply-To: joe.korty@ccur.com
References: <20040915125356.GA11250@elte.hu> <20040915132936.GB30233@tsunami.ccur.com> <20040915133144.GB30530@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040915133144.GB30530@devserv.devel.redhat.com>
User-Agent: Mutt/1.4.1i
X-OriginalArrivalTime: 15 Sep 2004 13:40:48.0961 (UTC) FILETIME=[9C309310:01C49B29]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2004 at 03:31:44PM +0200, Arjan van de Ven wrote:
> On Wed, Sep 15, 2004 at 09:29:36AM -0400, Joe Korty wrote:
> > On Wed, Sep 15, 2004 at 02:53:56PM +0200, Ingo Molnar wrote:
> > > 
> > > there are a few devices that use lots of ioremap space. vmalloc space is
> > > a showstopper problem for them.
> > > 
> > > this patch adds the vmalloc=<size> boot parameter to override
> > > __VMALLOC_RESERVE. The default is 128mb right now - e.g. vmalloc=256m
> > > doubles the size.
> > 
> > Perhaps this should instead be a configurable.
> 
> boot time settable is 100x better than only compile time settable imo :)

IMO, everything that is changable at boot time needs an equivalent way
of changing the default without specifying a boot time value.

boot time values works well only when the number of values that need
changing is small.

Joe
