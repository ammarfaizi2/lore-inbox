Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264733AbSLMPAv>; Fri, 13 Dec 2002 10:00:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264739AbSLMPAv>; Fri, 13 Dec 2002 10:00:51 -0500
Received: from kiruna.synopsys.com ([204.176.20.18]:21638 "HELO
	kiruna.synopsys.com") by vger.kernel.org with SMTP
	id <S264733AbSLMPAu>; Fri, 13 Dec 2002 10:00:50 -0500
Date: Fri, 13 Dec 2002 16:08:27 +0100
From: Alex Riesen <alexander.riesen@synopsys.COM>
To: Burton Windle <bwindle@fint.org>
Cc: linux-kernel@vger.kernel.org, Matthew Wilcox <willy@debian.org>,
       mdew@orcon.net.nz
Subject: Re: oops: 2.5.51 lock_get_status
Message-ID: <20021213150827.GA31448@riesen-pc.gr05.synopsys.com>
Reply-To: alexander.riesen@synopsys.COM
References: <20021213143115.GA30170@riesen-pc.gr05.synopsys.com> <Pine.LNX.4.43.0212130942110.31117-100000@morpheus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.43.0212130942110.31117-100000@morpheus>
User-Agent: Mutt/1.4i
Organization: Synopsys, Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Burton Windle, Fri, Dec 13, 2002 15:42:20 +0100:
> This might also be of interest...
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=103825968004879&w=2
> 

hmm... This:

| note, do not use NFS when using this patch.  really; i mean it.  somehow
| i managed to corrupt thread_info.cpu causing _udelay_ to oops.

doesn't look very encouraging.

Maybe there is already some news about it?
I volunteer to test anything :)
as being hit by the bug.

-alex

> On Fri, 13 Dec 2002, Alex Riesen wrote:
> 
> > Burton Windle, Fri, Dec 13, 2002 15:08:45 +0100:
> > > http://bugzilla.kernel.org/show_bug.cgi?id=16
> > >
> >
> > Oh, thanks. Still fogetting about the new thing to look before.
> >
> > > On Fri, 13 Dec 2002, Alex Riesen wrote:
> > >
> > > > 2.5.51+bk as of 12 Dec 23:00 CET.
> > > >
> > > > tried to strace(4.4) the d4x with follow-fork mode.
> > > > d4x is a multi-threaded app using posix advisory locks.
> > > > (http://www.krasu.ru/soft/chuchelo/)
> > > >
> > > > The thing calls fcntl, which fails as if the file were locked:
> > > >
> >
