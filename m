Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318360AbSHPNei>; Fri, 16 Aug 2002 09:34:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318361AbSHPNeh>; Fri, 16 Aug 2002 09:34:37 -0400
Received: from relay1.pair.com ([209.68.1.20]:47882 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id <S318360AbSHPNeg>;
	Fri, 16 Aug 2002 09:34:36 -0400
X-pair-Authenticated: 24.126.73.164
Message-ID: <3D5D0186.7B7724BC@kegel.com>
Date: Fri, 16 Aug 2002 06:43:34 -0700
From: Dan Kegel <dank@kegel.com>
Reply-To: dank@kegel.com
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-3custom i686)
X-Accept-Language: en
MIME-Version: 1.0
To: suparna@in.ibm.com
CC: Benjamin LaHaise <bcrl@redhat.com>, Andrea Arcangeli <andrea@suse.de>,
       Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Chris Friesen <cfriesen@nortelnetworks.com>,
       Pavel Machek <pavel@elf.ucw.cz>, linux-kernel@vger.kernel.org,
       linux-aio@kvack.org
Subject: Re: aio-core why not using SuS? [Re: [rfc] aio-core for 2.5.29 (Re: 
 async-io API registration for 2.5.29)]
References: <1028223041.14865.80.camel@irongate.swansea.linux.org.uk> <Pine.LNX.4.44.0208010924050.14765-100000@home.transmeta.com> <20020801140112.G21032@redhat.com> <20020815235459.GG14394@dualathlon.random> <20020815214225.H29874@redhat.com> <20020816150945.A1832@in.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Suparna Bhattacharya wrote:
> 
> On Thu, Aug 15, 2002 at 09:42:25PM -0400, Benjamin LaHaise wrote:
> > > Now reading the SuS specifications I also like less and less our current
> > > kernel API of this sumbit_io, the SuS does exactly what I suggested
> > > originally that is aio_read/aio_write/aio_fsync as separate calls. So
> > > the merging effect mentioned by Ben cannot be taken advantage of by the
> > > kernel anyways because userspace will issue separate calls for each
> > > command.
> >
> > Read it again.  You've totally missed lio_listio.  Also keep in mind what
> >
> 
> Also, wasn't the fact that the API was designed to support both POSIX
> and completion port style semantics, another reason for a different
> (lightweight) in-kernel api? The c10k users of aio are likely to find
> the latter model (i.e.  completion ports) more efficient.

You can actually consider posix AIO using sigtimedwait() to pick up completion
notices to fit the definition of completion port if you squint a bit.
(The patented scheduler magic of NT completion ports is just a fun extra...)
- Dan
