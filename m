Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750860AbWIROdr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750860AbWIROdr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 10:33:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751662AbWIROdr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 10:33:47 -0400
Received: from mail.windriver.com ([147.11.1.11]:28297 "EHLO mail.wrs.com")
	by vger.kernel.org with ESMTP id S1750857AbWIROdq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 10:33:46 -0400
Subject: Re: [linux-pm] OpPoint summary
From: "Richard A. Griffiths" <richard.griffiths@windriver.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: David Singleton <daviado@gmail.com>, linux-pm@lists.osdl.org,
       kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20060917174835.GA2225@elf.ucw.cz>
References: <20060911195546.GB11901@elf.ucw.cz> <4505CCDA.8020501@gmail.com>
	 <20060911210026.GG11901@elf.ucw.cz> <4505DDA6.8080603@gmail.com>
	 <20060911225617.GB13474@elf.ucw.cz>
	 <20060912001701.GC14234@linux.intel.com> <20060912033700.GD27397@kroah.com>
	 <b324b5ad0609131650q1b7a78cfsa90e3fbe8d7b4093@mail.gmail.com>
	 <20060914055529.GA18031@kroah.com>
	 <b324b5ad0609141007i2a26cf60r45ebf1175c7bcc7d@mail.gmail.com>
	 <20060917174835.GA2225@elf.ucw.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 18 Sep 2006 07:33:24 -0700
Message-Id: <1158590004.8239.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 (2.6.1-1.fc5.2) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-09-17 at 19:48 +0200, Pavel Machek wrote:
> Hi!
> 
> > >Care to resend your patches in the proper format, through email so that
> > >we can see them, and possibly get some testing in -mm if they look sane?
> > 
> > Greg,
> >   here's the patch that implements operating points for different 
> >   frequencies
> > for the speedstep-centrino line of processors.  Operating points are created
> > in much the same manner that cpufreq tables are.  This works for both
> > simple implementations like the centrino and more complex SoC systems
> > like the arm-pxa72x which has several clocks to control, and different clock
> > divisors and multipliers.
> 
> > +static struct oppoint lowest = {
> > +       .name = "lowest",
> > +       .type = PM_FREQ_CHANGE,
> > +       .frequency = 0,
> > +       .voltage = 0,
> > +       .latency = 15,
> > +       .prepare_transition  = cpufreq_prepare_transition,
> > +       .transition = centrino_transition,
> > +       .finish_transition = cpufreq_finish_transition,
> > +};
> 
> We had nice, descriptive interface... with numbers. Now you want to
> introduce english state names... looks like a step back to me.

Maybe a compromise could be reached where a defined set of numbers maps
to  string names ala Unix init states. Many people (at least me) still
invoke init 6 to reboot a system.  A defined table would satisfy both
the number and string camps.

Richard
