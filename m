Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272330AbSISSok>; Thu, 19 Sep 2002 14:44:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272334AbSISSok>; Thu, 19 Sep 2002 14:44:40 -0400
Received: from air-2.osdl.org ([65.172.181.6]:41991 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S272330AbSISSoj>;
	Thu, 19 Sep 2002 14:44:39 -0400
Date: Thu, 19 Sep 2002 11:49:46 -0700
From: Dave Olien <dmo@osdl.org>
To: Daniel Phillips <phillips@arcor.de>
Cc: Jens Axboe <axboe@suse.de>, Samium Gromoff <_deepfire@mail.ru>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.5] DAC960
Message-ID: <20020919114934.A27630@acpi.pdx.osdl.net>
References: <E17odbY-000BHv-00@f1.mail.ru> <20020915131920.GR935@suse.de> <20020916131359.A17880@acpi.pdx.osdl.net> <E17r2Rr-0001Vk-00@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <E17r2Rr-0001Vk-00@starship>; from phillips@arcor.de on Mon, Sep 16, 2002 at 10:26:23PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've been doing more work on the driver.  Wednesday, I was
going crazy because the data I read back from the device
was SOMETIMES NOT the same data I wrote there.

On Thursday, I switched from Linux 2.5.34 to Linux 2.5.36.
Now, the driver reads back the same data it wrote.  There must
have been some bio changes in 2.5.36.  2.5.36 also
calls the driver shutdown notifier routine, which 2.5.34 didn't.
This uncovered a coding bug that causes a kernel OOPS during shutdown.
That'll be fixed in the next patch.

I'm about to test changes that put the command and status memory
mailboxes into dma memory regions.  Once I've tested that,
I'll send you a new patch (Probably on Monday after week end
testing).

After that, I'll change the status reporting structures to be in dma
memory regions.  Expect a patch containing that maybe the end of
next week, or the Monday following ( September 30).



> > 
> > I have the DAC960 driver working in 2.5.34.  The work isn't
> > complete yet.  But, I'm able to boot, and do mke2fs
> > on partitions on logical drives, and then do e2fsck
> > on those partitions.  It seems to work, although more
> > testing is required.  Is there any interest in reviewing
> > the code so far, or should I continue testing and complete
> > the remaining issues first?
> 
> Please post the patch, I'll try it right away.
> 
> -- 
> Daniel
