Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135610AbRDSMlC>; Thu, 19 Apr 2001 08:41:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135647AbRDSMkw>; Thu, 19 Apr 2001 08:40:52 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:34310 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S135610AbRDSMkj>;
	Thu, 19 Apr 2001 08:40:39 -0400
Date: Thu, 19 Apr 2001 14:40:25 +0200
From: Jens Axboe <axboe@suse.de>
To: "Peter T. Breuer" <ptb@it.uc3m.es>
Cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: block devices don't work without plugging in 2.4.3
Message-ID: <20010419144025.T16822@suse.de>
In-Reply-To: <20010419135417.Q16822@suse.de> <200104191233.f3JCX8s22171@oboe.it.uc3m.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200104191233.f3JCX8s22171@oboe.it.uc3m.es>; from ptb@it.uc3m.es on Thu, Apr 19, 2001 at 02:33:08PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 19 2001, Peter T. Breuer wrote:
> "A month of sundays ago Jens Axboe wrote:"
> > On Thu, Apr 19 2001, Peter T. Breuer wrote:
> > > So the consensus is that I should enable plugging while the plugging
> > > function is still here and do nothing when it goes? I must say I don't
> > > think it should really "go", since that means I have to add a no-op
> > > macro to replace it, and I don't like #ifdefs. 
> > 
> > The moral would be that you should never do anything. You didn't enable
> > plugging with blk_queue_pluggable, only disabled it by using a noop
> > plug.
> 
> I was thinking about what has to be done to allow my code to compile in
> older kernels. I _believe_ (I may be mistaken) that I had to _explicitly_
> disable plugging at some stage. Probably in 2.2. and possibly in 2.4.0.
> 
> On that basis, I do need a plug_fn and a blk_queue_pluggable for
> compilation against those kernels, and these should both be macro'ed to
> oblivion in the newest kernels. No? 

Examine _why_ you don't want plugging. In 2.2, you would have to edit
the kernel manually to disable it for your device. For 2.4, as long as
there has been blk_queue_pluggable, there has also been the
disable-merge function mentioned. Why are you disabling plugging??

-- 
Jens Axboe

