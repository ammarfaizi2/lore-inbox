Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965880AbWKEUw4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965880AbWKEUw4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 15:52:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965885AbWKEUw4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 15:52:56 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:17090 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S965880AbWKEUwz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 15:52:55 -0500
Date: Sun, 5 Nov 2006 21:52:18 +0100
From: Pavel Machek <pavel@ucw.cz>
To: U Kuehn <ukuehn@acm.org>
Cc: linux-thinkpad@linux-thinkpad.org,
       Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Greg KH <greg@kroah.com>,
       Shem Multinymous <multinymous@gmail.com>,
       David Zeuthen <davidz@redhat.com>, Richard Hughes <hughsient@gmail.com>,
       David Woodhouse <dwmw2@infradead.org>, Dan Williams <dcbw@redhat.com>,
       linux-kernel@vger.kernel.org, devel@laptop.org, sfr@canb.auug.org.au,
       len.brown@intel.com, benh@kernel.crashing.org,
       Jean Delvare <khali@linux-fr.org>
Subject: Re: [ltp] Re: [PATCH v2] Re: Battery class driver.
Message-ID: <20061105205218.GB1847@elf.ucw.cz>
References: <1162048148.2723.61.camel@zelda.fubar.dk> <41840b750610281112q7790ecao774b3d1b375aca9b@mail.gmail.com> <20061031074946.GA7906@kroah.com> <41840b750610310528p4b60d076v89fc7611a0943433@mail.gmail.com> <20061101193134.GB29929@kroah.com> <41840b750611011153w3a2ace72tcdb45a446e8298@mail.gmail.com> <20061101205330.GA2593@kroah.com> <20061101235540.GA11581@khazad-dum.debian.net> <20061102220145.GB2192@elf.ucw.cz> <454B4042.7050307@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <454B4042.7050307@acm.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2006-11-03 14:12:22, U Kuehn wrote:
> Hi,
> 
> Pavel Machek wrote:
> > 
> > echo '(700 mA * hour) / (14*day) \ A' | ucalc
> > 
> > ucalc> OK:  0.002083
> > ucalc>
> > 
> >  ...that is about 2mA in low power standby mode (but still listening on
> > GSM, getting calls, etc).
> > 
> >  ...so, mAh are probably good enough for capacity_*_charge, but would
> > suck for current power consumption, as difference between 2mA and 3mA
> > would be way too big. We need some finer unit in that case.
> > 
> 
> That very much depends on the system. Having a laptop where the current
> power consumption is around 10 Watts (or, at about 10 to 12 Volts,
> nearly 1 A), having a resolution of 10 or even 100 mA would be OK.
> However, on your cellphone with a standby consumption of 2mA, such a
> resolution would be meaningless. What kind of resultion does the
> hardware usually support?

I do not know details. Siemens phones have current monitors, but I do
not recall how accurate those are. Anyway, at least for some
applications mA is not enough, so we probably should use finer
unit. Or use ampers and let kernel be "as precise as it needs" in
simulated floating point.
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
