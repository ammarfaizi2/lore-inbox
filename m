Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312161AbSCRBkJ>; Sun, 17 Mar 2002 20:40:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312162AbSCRBkA>; Sun, 17 Mar 2002 20:40:00 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:17915
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S312161AbSCRBjl>; Sun, 17 Mar 2002 20:39:41 -0500
Date: Sun, 17 Mar 2002 17:40:51 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Rik van Riel <riel@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Lse-tech] Re: 10.31 second kernel compile
Message-ID: <20020318014051.GA2254@matchmail.com>
Mail-Followup-To: Davide Libenzi <davidel@xmailserver.org>,
	Rik van Riel <riel@conectiva.com.br>,
	Linus Torvalds <torvalds@transmeta.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L.0203172152240.2181-100000@imladris.surriel.com> <Pine.LNX.4.44.0203171709000.7378-100000@blue1.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0203171709000.7378-100000@blue1.dev.mcafeelabs.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 17, 2002 at 05:13:16PM -0800, Davide Libenzi wrote:
> On Sun, 17 Mar 2002, Rik van Riel wrote:
> 
> > On Sun, 17 Mar 2002, Davide Libenzi wrote:
> > > On Sun, 17 Mar 2002, Linus Torvalds wrote:
> > >
> > > > In article <Pine.LNX.4.44L.0203171021090.2181-100000@imladris.surriel.com>,
> > > > Rik van Riel  <riel@conectiva.com.br> wrote:
> > > > >
> > > > >In other words, large pages should be a "special hack" for
> > > > >special applications, like Oracle and maybe some scientific
> > > > >calculations ?
> > > >
> > > > Yes, I think so.
> >
> > > Couldn't we choose the page size depending on the map size ?
> >
> > For on-disk files I guess this is better an mmap flag,
> > but for shared memory segments we could try to do this
> > automagically.
> 
> What's the reason that would make more convenient for us, upon receiving a
> request to map a NNN MB file, to map it using 4Kb pages instead of 4MB ones ?

... the VM chooses to unmap a mmaped page, it chooses a 4mb page, later it
needs just a few bytes from that unmaped page and free 4mb instead of 4kb (worst
case) to map that page again...
