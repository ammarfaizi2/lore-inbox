Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274862AbSBUXKq>; Thu, 21 Feb 2002 18:10:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287408AbSBUXKg>; Thu, 21 Feb 2002 18:10:36 -0500
Received: from mail.credit.com ([209.155.227.90]:947 "EHLO gatekeeper")
	by vger.kernel.org with ESMTP id <S274862AbSBUXKZ>;
	Thu, 21 Feb 2002 18:10:25 -0500
Date: Thu, 21 Feb 2002 15:09:57 -0800 (PST)
From: Eugene Chupkin <ace@credit.com>
To: Andreas Dilger <adilger@turbolabs.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.x ram issues?
In-Reply-To: <Pine.LNX.4.10.10202131229480.683-100000@mail.credit.com>
Message-ID: <Pine.LNX.4.10.10202211506050.2031-100000@mail.credit.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 13 Feb 2002, Eugene Chupkin wrote:

> 
> 
> On Wed, 13 Feb 2002, Andreas Dilger wrote:
> 
> > On Feb 13, 2002  11:05 -0800, Eugene Chupkin wrote:
> > > On Tue, 12 Feb 2002, Andreas Dilger wrote:
> > > > The other possibility with that much RAM is that the page tables are taking
> > > > up all of the low RAM.  Andrea has a patch to put the page tables into
> > > > higmem in the recent -aa kernels.
> > > 
> > > I got it, the 2.4.18pre2aa2/pte-highmem-5 but I can't seem to figure out
> > > what to patch this on, I tried patching it on to 2.2.17, 2.2.18-pre1,
> > > and 2.2.18-pre2. On all those I get a Hunk failed. Any feedback is
> > > appreciated.
> > 
> > You may need to use a whole bunch of -aa patches to get it to apply.  In
> > general, the -aa tree is tuned for large machines such as yours, so you
> > are probably better off getting the whole thing.
> > 
> 
> Whola!!! This fixed my problem. CONFIG_HIGHIO did it. So my kernel is lets
> see here... 2.4.18pre2aa2+pte-highmem-5. I hope this will be included in
> the 2.4.18 final. Thanks for all your help.
> 

I am still having problems even with that kernel, it appears that the
memory that is taken is not given back, after a few hours the load
shoots up, the system gets really slow and then it crashes.. Solutions,
ideas?

Thanks.

