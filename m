Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261583AbSJYUXx>; Fri, 25 Oct 2002 16:23:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261584AbSJYUXx>; Fri, 25 Oct 2002 16:23:53 -0400
Received: from dhcp80ff23b2.dynamic.uiowa.edu ([128.255.35.178]:34948 "EHLO
	localhost") by vger.kernel.org with ESMTP id <S261583AbSJYUXw>;
	Fri, 25 Oct 2002 16:23:52 -0400
Date: Fri, 25 Oct 2002 15:29:57 -0500
From: Joseph Pingenot <trelane@digitasaru.net>
To: Patti Ordonez <Patti@trainingetc.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Question about problem you posted at http://www.cs.helsinki.fi/linux/linux-kernel/2002-18/0689.html
Message-ID: <20021025202953.GA2290@digitasaru.net>
Reply-To: trelane@digitasaru.net
Mail-Followup-To: Patti Ordonez <Patti@trainingetc.com>,
	linux-kernel@vger.kernel.org
References: <01C27C41.41FE52A0.Patti@trainingetc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01C27C41.41FE52A0.Patti@trainingetc.com>
User-Agent: Mutt/1.4i
X-School: University of Iowa
X-vi-or-emacs: vi *and* emacs!
X-MSMail-Priority: High
X-Priority: 1 (Highest)
X-MS-TNEF-Correlator: <AFJAUFHRUOGRESULWAOIHFEAUIOFBVHSHNRAIU.monkey@spamcentral.invalid>
X-MimeOLE: Not Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Posted to Linux-Kernel since it's still a valid ALi 15XX driver problem.

>From Patti Ordonez on Friday, 25 October, 2002:
>Hello,
>I found a problem you posted at 
> http://www.cs.helsinki.fi/linux/linux-kernel/2002-18/0689.html.
>I am having the same problem while trying to load Linux on my Toshiba 
>1625CDT.  Did you ever find a solution to your problem? Were you able to 
>install linux on your machine.  I believe it has to do with repartitioning 
>space for hibernation.
>Any recommendations would be greatly appreciated.

Yes; I have everything working on this laptop (with maybe the exception of
  the lid-close switch, which somehow causes the laptop to crash or simply
  not suspend properly.).

What I did was create (with Toshiba's/Phoenix's hibernation partition
  creation utility; I forget what it's called and where I got it; if you
  find it, please tell me so I can archive off a copy of it for later. :)
  a suspend partition for the BIOS.  I set the laptop to suspend to disk
  (otherwise, suspending to RAM causes the processor to overheat (I
  highly suspect a BIOS bug, but, natch, Linux is unsupported so they
  won't look into it.  *sigh*)).

The critical point is to *disable* ALi 15xx IDE support.  Otherwise,
  the laptop suspends everything but "extended" memory and simply hangs
  at the start of saving off that data.

You can get around using PIO mode by creating one ALi kernel, booting
  into it to activate DMA, then rebooting into a non-ALi (generic IDE
  drivers) kernel so that you can suspend to disk.  It's an annoying
  workaround, though, and I'd like to finally have BIOS and the ALi
  drivers play nice.

I look forward to the software suspend coming up, since I can then not
  have to rely on a gronky, highly proprietary (so far as I can tell)
  BIOS.

-Joseph

-- 
Joseph===============================================trelane@digitasaru.net
"Alt text doesn't pop up unless you use an ancient browser from the days of
 yore. The relevant standards clearly indicate that it should not, and I
 only know about one browser released in the last two years that violates
 this, and it's still claiming compatibility with Mozilla 4 (which was
 obsolete quite long ago), so it really can't be considered a modern
 browser."  --jonadab, in a slashdot.org comment.



