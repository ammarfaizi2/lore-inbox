Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265582AbSJXRwn>; Thu, 24 Oct 2002 13:52:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265583AbSJXRwn>; Thu, 24 Oct 2002 13:52:43 -0400
Received: from bozo.vmware.com ([65.113.40.131]:40964 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id <S265582AbSJXRwm>; Thu, 24 Oct 2002 13:52:42 -0400
Date: Thu, 24 Oct 2002 10:59:29 -0700
From: chrisl@vmware.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@digeo.com>, andrea@suse.de,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: writepage return value check in vmscan.c
Message-ID: <20021024175929.GB1398@vmware.com>
References: <20021024082505.GB1471@vmware.com> <3DB7B11B.9E552CFF@digeo.com> <1035450906.8675.4.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1035450906.8675.4.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
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
> 
exactly. It need to preserve the page dirty in the first place.

Chris


