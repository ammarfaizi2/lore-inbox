Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267032AbTAFQxO>; Mon, 6 Jan 2003 11:53:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267033AbTAFQxO>; Mon, 6 Jan 2003 11:53:14 -0500
Received: from smtp.mailix.net ([216.148.213.132]:17846 "EHLO smtp.mailix.net")
	by vger.kernel.org with ESMTP id <S267032AbTAFQxO>;
	Mon, 6 Jan 2003 11:53:14 -0500
Date: Mon, 6 Jan 2003 18:01:45 +0100
From: Alex Riesen <fork0@users.sf.net>
To: Doug McNaught <doug@mcnaught.org>
Cc: Dirk Bull <dirkbull102@hotmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: shmat problem
Message-ID: <20030106170144.GB16249@steel>
Reply-To: Alex Riesen <fork0@users.sf.net>
References: <20030106162251.GA15900@steel> <m3wuligrqg.fsf@varsoon.wireboard.com> <20030106164332.GA16131@steel> <m3smw6gr3j.fsf@varsoon.wireboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3smw6gr3j.fsf@varsoon.wireboard.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doug McNaught, Mon, Jan 06, 2003 17:50:24 +0100:
> > Linux manpages-1.54 (Dec 30 2002):
> > 
> >    The  (Linux-specific) SHM_REMAP flag may be asserted in shmflg to indi-
> >    cate that the mapping of the segment should replace any  existing  map-
> >    ping  in  the  range starting at shmaddr and continuing for the size of
> >    the segment.  (Normally an EINVAL  error  would  result  if  a  mapping
> >    already  exists in this address range.)  In this case, shmaddr must not
> >    be NULL.
> 
> Wouldn't the OP's code still (potentially) have problems? What if you
> had:
> 
> char my_shared_area[2048];
> int my_unshared_var;
>
>    void *foo = shmat(id, &my_shared_area, SHM_REMAP);
> 
> Would my_unshared_var end up shared, since memory mappings have page
> granularity?
> 

yes, i suppose so.
Maybe that was the reason making SHM_REMAP non-default
behaviour for shmat.

-alex
