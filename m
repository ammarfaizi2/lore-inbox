Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316194AbSETScs>; Mon, 20 May 2002 14:32:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316196AbSETScr>; Mon, 20 May 2002 14:32:47 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:59661
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S316194AbSETScq>; Mon, 20 May 2002 14:32:46 -0400
Date: Mon, 20 May 2002 11:32:27 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Manik Raina <manik@cisco.com>
Cc: Matti Aarnio <matti.aarnio@zmailer.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: adding counters to count bytes read/written
Message-ID: <20020520183227.GB502@matchmail.com>
Mail-Followup-To: Manik Raina <manik@cisco.com>,
	Matti Aarnio <matti.aarnio@zmailer.org>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0205201506240.14394-100000@localhost.localdomain> <20020520131222.K9955@mea-ext.zmailer.org> <3CE8D80C.3A771CB1@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2002 at 04:33:40PM +0530, Manik Raina wrote:
> 
> 	Thanks for the comments Matti, Please see inline ...
> 
> Matti Aarnio wrote:
> > 
> > On Mon, May 20, 2002 at 03:09:36PM +0530, Manik Raina wrote:
> > > Hi Linus,
> > >
> > >       This patch adds 2 counters to the task_struct for
> > >       counting how many bytes were read/written using
> > >       the read()/write() system calls.
> > >
> > >       These counters may be useful in determining how
> > >       many IO requests are made by each process.
> > 
> >   These are defined as UINTegers, are you sure that is appropriate type ?
> >   What to do when they will overflow ?  For short term activity tracking
> >   they may be ok (4GB/200 MB/sec = 20 sec to wrap around), but for accounting
> >   the overflow might not be liked thing..
> 
> 
> 	How about 64 bit counters ? i feel those should go on without
> 	wraparound for a _very_ long time.

I really doubt that 64bit counters in a fast path will be accepted.  You'll
really need to justify something like that.

Have you looked at the process accounting code?
