Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282222AbRKWTe0>; Fri, 23 Nov 2001 14:34:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282214AbRKWTeQ>; Fri, 23 Nov 2001 14:34:16 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:62710
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S282213AbRKWTeD>; Fri, 23 Nov 2001 14:34:03 -0500
Date: Fri, 23 Nov 2001 11:33:57 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NFS, Paging & Installing [was: Re: Swap]
Message-ID: <20011123113357.A17332@mikef-linux.matchmail.com>
Mail-Followup-To: Trond Myklebust <trond.myklebust@fys.uio.no>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011120135059.D4210@mikef-linux.matchmail.com> <200111210122.fAL1MwhC029913@sleipnir.valparaiso.cl> <20011120174622.A12996@mikef-linux.matchmail.com> <shs3d38xuk4.fsf@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <shs3d38xuk4.fsf@charged.uio.no>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2001 at 11:55:07AM +0100, Trond Myklebust wrote:
> >>>>> " " == Mike Fedyk <mfedyk@matchmail.com> writes:
> 
>      > On Tue, Nov 20, 2001 at 10:22:58PM -0300, Horst von Brand
>      > wrote:
>     >> Mike Fedyk <mfedyk@matchmail.com> said:
>     >> > Do any newer versions of NFS fix the stateless server
>     >> > problem?
>     >>
>     >> This is an _extremely_ hard problem: The server has to know
>     >> somehow what the client thinks the state is... and either one
>     >> (or both) may have been rebooted in between without the other
>     >> one knowing.
> 
>      > Yep, but there are currently protocols (SMB) that do that, but
>      > not necessarily in a unix way.
> 
> <Cough, choke>
> 
>   Exactly how, pray tell, does SMB cope with recovering the full state
> info after client/server crashes?
> 

No, I wasn't claiming that SMB will recover from a server crash gracefully.
If your SMB server goes down (upgrade being likely with samba instead of
crash...) for whatever reason, any open file connections are hosed.

I was just stating that there are Network FSes that are stateful, and work
good when the server stays up.

As stated by Alan, you can make a stateful Net FS that deals gracefully with
crash recovery, it's just harder.

Also, SMB deals with crashed clients pretty well most of the time by
querying the client with the write lock to see if it's still there...

Mike
