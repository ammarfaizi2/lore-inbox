Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265404AbSJXLig>; Thu, 24 Oct 2002 07:38:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265408AbSJXLif>; Thu, 24 Oct 2002 07:38:35 -0400
Received: from [195.223.140.120] ([195.223.140.120]:23154 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S265404AbSJXLif>; Thu, 24 Oct 2002 07:38:35 -0400
Date: Thu, 24 Oct 2002 13:44:55 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@digeo.com>, chrisl@vmware.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: writepage return value check in vmscan.c
Message-ID: <20021024114455.GG3354@dualathlon.random>
References: <20021024082505.GB1471@vmware.com> <3DB7B11B.9E552CFF@digeo.com> <1035450906.8675.4.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1035450906.8675.4.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 24, 2002 at 10:15:06AM +0100, Alan Cox wrote:
> On Thu, 2002-10-24 at 09:36, Andrew Morton wrote:
> > A few fixes have been discussed.  One way would be to allocate
> > the space for the page when it is first faulted into reality and
> > deliver SIGBUS if backing store for it could not be allocated.
> 
> You still have to handle the situation where the page goes walkies and
> you get ENOSPC or any other ERANDOMSUPRISE from things like NFS. SIGBUS
> appears the right thing to do.

I would tend to agree SIGBUS could be the right thing to do since the
other (current) option is silent data corruption.

Andrea
