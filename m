Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269269AbSISWEh>; Thu, 19 Sep 2002 18:04:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269685AbSISWEg>; Thu, 19 Sep 2002 18:04:36 -0400
Received: from air-2.osdl.org ([65.172.181.6]:46341 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S269269AbSISWEf>;
	Thu, 19 Sep 2002 18:04:35 -0400
Date: Thu, 19 Sep 2002 15:09:58 -0700
From: Dave Olien <dmo@osdl.org>
To: Daniel Phillips <phillips@arcor.de>
Cc: Jens Axboe <axboe@suse.de>, Samium Gromoff <_deepfire@mail.ru>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.5] DAC960
Message-ID: <20020919150958.A27837@acpi.pdx.osdl.net>
References: <E17odbY-000BHv-00@f1.mail.ru> <E17r2Rr-0001Vk-00@starship> <20020919114934.A27630@acpi.pdx.osdl.net> <E17s6nH-0000xq-00@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <E17s6nH-0000xq-00@starship>; from phillips@arcor.de on Thu, Sep 19, 2002 at 09:16:53PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Daniel,

My mailer here has been misbehaving.  I didn't think THIS mail
had actually made it out.  So, you may be seeing another version
of this mail sometime.  Just ignore it.

I think some coding style repairs would be great!  But I'd like to
hold off on that until we've finished all the functional changes.
That way, anyone doing a code review can easily see only the
changes to make the driver function.

Once functional changes are mostly complete, then cleaning up
some coding style issues would be a good thing.

Regarding being a mainteiner, lets get the code changes done
first ;-)


On Thu, Sep 19, 2002 at 09:16:53PM +0200, Daniel Phillips wrote:
> On Thursday 19 September 2002 20:49, Dave Olien wrote:
> > I've been doing more work on the driver.  Wednesday, I was
> > going crazy because the data I read back from the device
> > was SOMETIMES NOT the same data I wrote there.
> > 
> > On Thursday, I switched from Linux 2.5.34 to Linux 2.5.36.
> > Now, the driver reads back the same data it wrote.  There must
> > have been some bio changes in 2.5.36.  2.5.36 also
> > calls the driver shutdown notifier routine, which 2.5.34 didn't.
> > This uncovered a coding bug that causes a kernel OOPS during shutdown.
> > That'll be fixed in the next patch.
> > 
> > I'm about to test changes that put the command and status memory
> > mailboxes into dma memory regions.  Once I've tested that,
> > I'll send you a new patch (Probably on Monday after week end
> > testing).
> > 
> > After that, I'll change the status reporting structures to be in dma
> > memory regions.  Expect a patch containing that maybe the end of
> > next week, or the Monday following ( September 30).
> 
> I was in the process of writing to you as this one came in...
> 
> I have booted 2.5.34 and 2.5.36, the same controller as yours, on my dual
> PIII box and it is apparently functioning well.  I have not done any kind
> of load testing yet.
> 
> Congratulations!  I presume you are now the DAC960 maintainer, subject to
> approval from on high of course, and assuming you are willing.  I'd like
> to do some spelling changes, just obvious ones for now, like removing
> spelling wrappers from standard kernel interfaces.  Want patches?
> 
> -- 
> Daniel
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
