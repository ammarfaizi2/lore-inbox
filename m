Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290184AbSCRRRS>; Mon, 18 Mar 2002 12:17:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290228AbSCRRRI>; Mon, 18 Mar 2002 12:17:08 -0500
Received: from imag.imag.fr ([129.88.30.1]:63460 "EHLO imag.imag.fr")
	by vger.kernel.org with ESMTP id <S290184AbSCRRRA>;
	Mon, 18 Mar 2002 12:17:00 -0500
Date: Mon, 18 Mar 2002 18:16:44 +0100
From: Pierre Lombard <pierre.lombard@imag.fr>
To: linux-kernel@vger.kernel.org
Subject: Re: Suspicious about 2.4.18
Message-ID: <20020318171644.GA30872@sci41.imag.fr>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <200203180743.g2I7hfmj007702@bert.webservepro.com> <Pine.LNX.4.33.0203181010520.7930-100000@macadam.madscilab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2002 at 10:20:50AM +0100, Adam Johansson wrote:
> On Mon, 18 Mar 2002, Michael wrote:
> 
> > I'm not really a linux expert, so I can only be suspicious.
> 
> Neither am I but I after seeing strange cron-jobs being run in the
> future according to the log,I upgraded to 2.4.19pre3 and all was ok
> again.

Not sure it is quite relevant but...

I had such a weird behavior on my Abit KT7 (with VIA chipsets) based
system: the time often went wild when I started doing heavy I/O between
IDE0 and IDE1... and after that the system had to be restarted :/

The workaround below by Vojtech Pavlik has fixed this issue on my system:

  Re: [PATCH] VIA timer fix was removed?
  From: Vojtech Pavlik (vojtech@suse.cz)
  Date: Mon Nov 12 2001 - 16:58:32 EST

  http://www.uwsg.iu.edu/hypermail/linux/kernel/0111.1/0951.html

> > Masquerading of iptables 1.2.5 sudently idles when "iptables -L" shows
> > everything is alright. A realoading of rc.firewall brings everything back to
> > normal. That happened 7 days after a normal operation. I've now upgraded to
> > 1.2.6 and see what happens.
> >
> > Also, crond doesn't seem to operate very precisely. It is sometimes seems
> > idle for 30 minutes.
> 
> I tried running this small script under 2.4.18 and noticed very strange
> outputs..
> 
> // --- start ---
> #!/bin/tcsh
> while (1)
>   date
> end
> // --- end ---
> 
> ./timescript > output
> 
> output gives me this;
> Fri Mar 15 10:17:12 CET 2002
> Fri Mar 15 10:17:12 CET 2002
> Fri Mar 15 10:17:12 CET 2002
> Fri Mar 15 10:17:12 CET 2002
> Fri Mar 15 10:17:12 CET 2002
> Fri Mar 15 10:17:12 CET 2002
> Fri Mar 15 11:29:43 CET 2002
> Fri Mar 15 11:29:43 CET 2002
> Fri Mar 15 11:29:43 CET 2002
> Fri Mar 15 10:17:13 CET 2002
> Fri Mar 15 10:17:13 CET 2002
> Fri Mar 15 10:17:13 CET 2002
> Fri Mar 15 10:17:13 CET 2002
> Fri Mar 15 10:17:13 CET 2002
> Fri Mar 15 10:17:13 CET 2002
> 
> 
> Which clearly shows that something is very very strange.
> I've no idea where or why this happens but since upgrading to 2.4.19pre3
> helped I assume that there is something in the kernel that is wrong.
> I run SuSE7.2 with a vanilla 2.4.18 (now 2.4.19pre3).
> 
> > I know that these may be application-specific problems, but I was curious if
> > there are any current kernel issues related to them so I can quit searching
> > for another cure.

-- 
Best regards,
  Pierre Lombard
