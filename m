Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965110AbWIQVTT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965110AbWIQVTT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Sep 2006 17:19:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965107AbWIQVTT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Sep 2006 17:19:19 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:43663 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S965111AbWIQVTS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Sep 2006 17:19:18 -0400
Date: Sun, 17 Sep 2006 19:48:35 +0200
From: Pavel Machek <pavel@ucw.cz>
To: David Singleton <daviado@gmail.com>
Cc: Greg KH <greg@kroah.com>, linux-pm@lists.osdl.org,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: OpPoint summary
Message-ID: <20060917174835.GA2225@elf.ucw.cz>
References: <20060911195546.GB11901@elf.ucw.cz> <4505CCDA.8020501@gmail.com> <20060911210026.GG11901@elf.ucw.cz> <4505DDA6.8080603@gmail.com> <20060911225617.GB13474@elf.ucw.cz> <20060912001701.GC14234@linux.intel.com> <20060912033700.GD27397@kroah.com> <b324b5ad0609131650q1b7a78cfsa90e3fbe8d7b4093@mail.gmail.com> <20060914055529.GA18031@kroah.com> <b324b5ad0609141007i2a26cf60r45ebf1175c7bcc7d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b324b5ad0609141007i2a26cf60r45ebf1175c7bcc7d@mail.gmail.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >Care to resend your patches in the proper format, through email so that
> >we can see them, and possibly get some testing in -mm if they look sane?
> 
> Greg,
>   here's the patch that implements operating points for different 
>   frequencies
> for the speedstep-centrino line of processors.  Operating points are created
> in much the same manner that cpufreq tables are.  This works for both
> simple implementations like the centrino and more complex SoC systems
> like the arm-pxa72x which has several clocks to control, and different clock
> divisors and multipliers.

> +static struct oppoint lowest = {
> +       .name = "lowest",
> +       .type = PM_FREQ_CHANGE,
> +       .frequency = 0,
> +       .voltage = 0,
> +       .latency = 15,
> +       .prepare_transition  = cpufreq_prepare_transition,
> +       .transition = centrino_transition,
> +       .finish_transition = cpufreq_finish_transition,
> +};

We had nice, descriptive interface... with numbers. Now you want to
introduce english state names... looks like a step back to me.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
