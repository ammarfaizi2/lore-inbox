Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751406AbWIDOiI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751406AbWIDOiI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 10:38:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751416AbWIDOiH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 10:38:07 -0400
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:58348 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP
	id S1751406AbWIDOiD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 10:38:03 -0400
Subject: Re: Kernel patches enabling better POSIX AIO (Was Re: [3/4]
	kevent: AIO, aio_sendfile)
From: =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
To: Jakub Jelinek <jakub@redhat.com>
Cc: Ulrich Drepper <drepper@redhat.com>, suparna@in.ibm.com,
       Badari Pulavarty <pbadari@us.ibm.com>,
       Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       lkml <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>,
       netdev <netdev@vger.kernel.org>, linux-aio@kvack.org
In-Reply-To: <20060812192802.GO32572@devserv.devel.redhat.com>
References: <1153982954.3887.9.camel@frecb000686>
	 <44C8DB80.6030007@us.ibm.com> <44C9029A.4090705@oracle.com>
	 <1154024943.29920.3.camel@dyn9047017100.beaverton.ibm.com>
	 <44C90987.1040200@redhat.com>
	 <1154034164.29920.22.camel@dyn9047017100.beaverton.ibm.com>
	 <1154091500.13577.14.camel@frecb000686> <44DCDE73.9030901@redhat.com>
	 <20060812182928.GA1989@in.ibm.com> <44DE27AB.7040507@redhat.com>
	 <20060812192802.GO32572@devserv.devel.redhat.com>
Date: Mon, 04 Sep 2006 16:37:54 +0200
Message-Id: <1157380674.3895.55.camel@frecb000686>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 04/09/2006 16:43:26,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 04/09/2006 16:43:31,
	Serialize complete at 04/09/2006 16:43:31
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-08-12 at 15:28 -0400, Jakub Jelinek wrote:
> On Sat, Aug 12, 2006 at 12:10:35PM -0700, Ulrich Drepper wrote:
> > > I am wondering about that too. IIRC, the IO_NOTIFY_* constants are not
> > > part of the ABI, but only internal to the kernel implementation. I think
> > > Zach had suggested inferring THREAD_ID notification if the pid specified
> > > is not zero. But, I don't see why ->sigev_notify couldn't used directly
> > > (just like the POSIX timers code does) thus doing away with the 
> > > new constants altogether. Sebestian/Laurent, do you recall?
> > 
> > I suggest to model the implementation after the timer code which does
> > exactly what we need.
> 
> Yeah, and if at all possible we want to use just one helper thread for
> SIGEV_THREAD notification of timers/aio/etc., so it really should behave the
> same as timer thread notification.
> 

  That's exactly what is done in libposix-aio.

  Sébastien.

-- 
-----------------------------------------------------

  Sébastien Dugué                BULL/FREC:B1-247
  phone: (+33) 476 29 77 70      Bullcom: 229-7770

  mailto:sebastien.dugue@bull.net

  Linux POSIX AIO: http://www.bullopensource.org/posix
                   http://sourceforge.net/projects/paiol

-----------------------------------------------------

