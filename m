Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317054AbSH1Q4T>; Wed, 28 Aug 2002 12:56:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317396AbSH1Q4T>; Wed, 28 Aug 2002 12:56:19 -0400
Received: from web40203.mail.yahoo.com ([66.218.78.64]:10268 "HELO
	web40203.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S317054AbSH1Q4R>; Wed, 28 Aug 2002 12:56:17 -0400
Message-ID: <20020828170033.10142.qmail@web40203.mail.yahoo.com>
Date: Wed, 28 Aug 2002 10:00:33 -0700 (PDT)
From: mike heffner <mdheffner@yahoo.com>
Subject: Re: PROBLEM:  conflict between apm and system clock on Inspiron 8100
To: Frank.Otto@tc.pci.uni-heidelberg.de, linux-kernel@vger.kernel.org
In-Reply-To: <200208281504.g7SF4Xl04292@goedel.pci.uni-heidelberg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frank,

 From your e-mail it seems that the kernel is the
problem, not the bios.  Is that your understanding?  I
started pestering Dell for a bios without this
problem.  Should I be digging through the kernel code
instead?

Mike

--- Frank.Otto@tc.pci.uni-heidelberg.de wrote:
> Alan Cox wrote:
> > On Mon, 2002-08-26 at 18:00, mike heffner wrote:
> > > Well, isn't that a nice feature.  Is there a
> > > workaround for this hardware?
> >  
> >  A thinkpad ;)
> 
> Unfortunately, that's not true -- I just got an IBM
> Thinkpad R32
> which exhibits the same behaviour as Mike's Dell
> Inspiron 8100,
> it's only a tad worse. When I have the
> battstat_applet running (which
> checks the battery every second), kernel time runs
> about 3% slow
> compared to the RTC (which seems to be half-way
> accurate on my machine).
> 
> The cause seems to be definitely APM. If I shut off
> battstat_applet
> and apmd, kernel time and RTC are in sync. With only
> apmd, I lose about
> 15 seconds per hour. With battstat_applet, I lose 2
> minutes per hour.
> With
>   while true; do cat /proc/apm >/dev/null; done
> the system runs at about 1/4 of the right speed.
> Using a kernel with ACPI
> eliminates the problem (of course, you lose almost
> all power management
> functionality too).
> 
> BTW, I have set CONFIG_APM_ALLOW_INT, and on startup
> the kernel even says
> "IBM machine detected. Enabling interrupts during
> APM calls." Doesn't
> seem to help, though.
> 
> Alan Cox continues:
> >  In theory you could try writing some code to
> measure the elapsed time by
> >  other means and then correct the kernel for the
> number of lost ticks.
> >  Not trivial. Or for that matter dont run battstat
> 
> I've hacked together a small daemon that tries to
> adjust the value
> and speed of the kernel clock (via adjtimex) to the
> RTC. An ugly solution,
> I know, but better than nothing. If anyone is
> interested, mail me.
> 
> Regards,
> Frank
> 
> -- 
> Please CC replies to me since I'm not on the list.


__________________________________________________
Do You Yahoo!?
Yahoo! Finance - Get real-time stock quotes
http://finance.yahoo.com
