Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318264AbSHPJgf>; Fri, 16 Aug 2002 05:36:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318269AbSHPJgf>; Fri, 16 Aug 2002 05:36:35 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:31113 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S318264AbSHPJge>; Fri, 16 Aug 2002 05:36:34 -0400
Date: Fri, 16 Aug 2002 15:09:46 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: Andrea Arcangeli <andrea@suse.de>, Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Chris Friesen <cfriesen@nortelnetworks.com>,
       Pavel Machek <pavel@elf.ucw.cz>, linux-kernel@vger.kernel.org,
       linux-aio@kvack.org
Subject: Re: aio-core why not using SuS? [Re: [rfc] aio-core for 2.5.29 (Re: async-io API registration for 2.5.29)]
Message-ID: <20020816150945.A1832@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <1028223041.14865.80.camel@irongate.swansea.linux.org.uk> <Pine.LNX.4.44.0208010924050.14765-100000@home.transmeta.com> <20020801140112.G21032@redhat.com> <20020815235459.GG14394@dualathlon.random> <20020815214225.H29874@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020815214225.H29874@redhat.com>; from bcrl@redhat.com on Thu, Aug 15, 2002 at 09:42:25PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 15, 2002 at 09:42:25PM -0400, Benjamin LaHaise wrote:
> > Now reading the SuS specifications I also like less and less our current
> > kernel API of this sumbit_io, the SuS does exactly what I suggested
> > originally that is aio_read/aio_write/aio_fsync as separate calls. So
> > the merging effect mentioned by Ben cannot be taken advantage of by the
> > kernel anyways because userspace will issue separate calls for each
> > command.
> 
> Read it again.  You've totally missed lio_listio.  Also keep in mind what 
> 

Also, wasn't the fact that the API was designed to support both POSIX 
and completion port style semantics, another reason for a different 
(lightweight) in-kernel api? The c10k users of aio are likely to find 
the latter model (i.e.  completion ports) more efficient.

Regards
Suparna
