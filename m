Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135906AbRDTRUM>; Fri, 20 Apr 2001 13:20:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135943AbRDTRUC>; Fri, 20 Apr 2001 13:20:02 -0400
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:10757 "EHLO
	bug.ucw.cz") by vger.kernel.org with ESMTP id <S135906AbRDTRTq>;
	Fri, 20 Apr 2001 13:19:46 -0400
Message-ID: <20010420190844.C905@bug.ucw.cz>
Date: Fri, 20 Apr 2001 19:08:44 +0200
From: Pavel Machek <pavel@suse.cz>
To: John Fremlin <chief@bandits.org>, Patrick Mochel <mochel@transmeta.com>
Cc: "Acpi-PM (E-mail)" <linux-power@phobos.fachschaften.tu-muenchen.de>,
        linux-kernel@vger.kernel.org
Subject: Re: Next gen PM interface
In-Reply-To: <Pine.LNX.4.10.10104182122250.7690-100000@nobelium.transmeta.com> <m2zodcoghs.fsf@bandits.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <m2zodcoghs.fsf@bandits.org>; from John Fremlin on Thu, Apr 19, 2001 at 08:07:43PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > This can also handle the user-dictated policy, which I haven't seen
> > discussed yet. For instance, when you close the lid or press the power
> > button, the system can enter suspend or it can power off. If the kernel
> > simply exported the event, the userspace daemon could simply check its
> > config file for the proper thing to do and initiate the transition.
> 
> Exactly what I was suggesting. In this case, you'd get the event
> 
>         SLEEP ACPI Laptop case closed
> 
> and your perl script could do something vaguely like
> 
>         /ACPI Laptop case closed$/ && system "shutdown -p now";
> 
> to turn the machine off instead of sleeping.


Lid is polled device, at least in ACPI case. Take a look at current
/proc/power/ -- it contains file "ac" saying "on-line" or
"off-line". I believe we should add another device file "lid"
containing either "open" or "closed"
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
