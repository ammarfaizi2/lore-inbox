Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272025AbRIDRSt>; Tue, 4 Sep 2001 13:18:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272032AbRIDRSk>; Tue, 4 Sep 2001 13:18:40 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:58380 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S272025AbRIDRSe>; Tue, 4 Sep 2001 13:18:34 -0400
Date: Tue, 4 Sep 2001 12:53:04 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Jan Harkes <jaharkes@cs.cmu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: page_launder() on 2.4.9/10 issue
In-Reply-To: <20010904131401.A30296@cs.cmu.edu>
Message-ID: <Pine.LNX.4.21.0109041249310.2038-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 4 Sep 2001, Jan Harkes wrote:

> On Tue, Sep 04, 2001 at 12:24:36PM -0300, Marcelo Tosatti wrote:
> > On Tue, 4 Sep 2001, Jan Harkes wrote:
> > > On Mon, Sep 03, 2001 at 11:57:09AM -0300, Marcelo Tosatti wrote:
> > > > I already have some code which adds a laundry list -- pages being written
> > > > out (by page_launder()) go to the laundry list, and each page_launder()
> > > > call will first check for unlocked pages on the laundry list, for then
> > > > doing the usual page_launder() stuff.
> > > 
> > > NO, please don't add another list to fix the symptoms of bad page aging.
> > 
> > Please, read my message again.
> 
> Sorry, it was a reaction to all the VM nonsense that has been flying
> around lately. The a lot of complaints and discussions wouldn't even
> have started if we actually moved _inactive_ pages to the inactive list
> instead of random pages.

> To get back on the thread I jumped into, I totally agree with Linus that
> writeout should be as soon as possible. Probably even as soon as an
> inactive dirty page hits the inactive dirty list, which would
> effectively turn the inactive dirty list into your laundry list.

Wrong. The laundry list is something where on flight pages stay so users
can free memory from there as soon as the IO is finished.

Do you see what I mean ?



