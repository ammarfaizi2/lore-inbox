Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265680AbSJXVQZ>; Thu, 24 Oct 2002 17:16:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265681AbSJXVQZ>; Thu, 24 Oct 2002 17:16:25 -0400
Received: from bozo.vmware.com ([65.113.40.131]:55306 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id <S265680AbSJXVQY>; Thu, 24 Oct 2002 17:16:24 -0400
Date: Thu, 24 Oct 2002 14:23:13 -0700
From: chrisl@vmware.com
To: Andrew Morton <akpm@digeo.com>
Cc: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org,
       chrisl@gnuchina.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: writepage return value check in vmscan.c
Message-ID: <20021024212313.GF1398@vmware.com>
References: <20021024082505.GB1471@vmware.com> <3DB7B11B.9E552CFF@digeo.com> <20021024175718.GA1398@vmware.com> <20021024183327.GS3354@dualathlon.random> <20021024191531.GD1398@vmware.com> <3DB85C1B.62D14184@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DB85C1B.62D14184@digeo.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 24, 2002 at 01:46:19PM -0700, Andrew Morton wrote:
> chrisl@vmware.com wrote:
> > 
> > ...
> > See the comment at the source for parameter. basically, if you want
> > 3 virtual machine, each have 2 process, using 1 G ram each you can do:
> > 
> > bigmm -i 3 -t 2 -c 1024
> > 
> > I run it on two 4G and 8G smp machine. Both can dead lock if I mmap
> > enough memory.
> > 
> 
> Are you sure it's a deadlock?  A large MAP_SHARED load like this

deadlock is the wrong word. Its harddisk keep spinning and not
response to anything. 

> on a 2.4 highmem machine can go into a spin, but it will come back
> to life after several minutes.

No, it will not come back to life, at least not after several minutes.
And there is not sign it is going to come back to life. 

Chris


