Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135608AbRDSMdm>; Thu, 19 Apr 2001 08:33:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135610AbRDSMdd>; Thu, 19 Apr 2001 08:33:33 -0400
Received: from oboe.it.uc3m.es ([163.117.139.101]:5647 "EHLO oboe.it.uc3m.es")
	by vger.kernel.org with ESMTP id <S135608AbRDSMdV>;
	Thu, 19 Apr 2001 08:33:21 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200104191233.f3JCX8s22171@oboe.it.uc3m.es>
Subject: Re: block devices don't work without plugging in 2.4.3
In-Reply-To: <20010419135417.Q16822@suse.de> from "Jens Axboe" at "Apr 19, 2001
 01:54:17 pm"
To: "Jens Axboe" <axboe@suse.de>
Date: Thu, 19 Apr 2001 14:33:08 +0200 (MET DST)
CC: "linux kernel" <linux-kernel@vger.kernel.org>
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"A month of sundays ago Jens Axboe wrote:"
> On Thu, Apr 19 2001, Peter T. Breuer wrote:
> > So the consensus is that I should enable plugging while the plugging
> > function is still here and do nothing when it goes? I must say I don't
> > think it should really "go", since that means I have to add a no-op
> > macro to replace it, and I don't like #ifdefs. 
> 
> The moral would be that you should never do anything. You didn't enable
> plugging with blk_queue_pluggable, only disabled it by using a noop
> plug.

I was thinking about what has to be done to allow my code to compile in
older kernels. I _believe_ (I may be mistaken) that I had to _explicitly_
disable plugging at some stage. Probably in 2.2. and possibly in 2.4.0.

On that basis, I do need a plug_fn and a blk_queue_pluggable for
compilation against those kernels, and these should both be macro'ed to
oblivion in the newest kernels. No? 

Apologies for the continued vagueness. There are a lot of states to
consider: two machine states (plugged/not plugged) and several code
states (whatever had to be done when to cause what).

Peter
