Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136036AbRD0OOM>; Fri, 27 Apr 2001 10:14:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136037AbRD0OOC>; Fri, 27 Apr 2001 10:14:02 -0400
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:4100 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S136036AbRD0ON5>;
	Fri, 27 Apr 2001 10:13:57 -0400
Message-ID: <20010426001323.B351@bug.ucw.cz>
Date: Thu, 26 Apr 2001 00:13:23 +0200
From: Pavel Machek <pavel@suse.cz>
To: "Grover, Andrew" <andrew.grover@intel.com>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Lid support for ACPI
In-Reply-To: <4148FEAAD879D311AC5700A0C969E89006CDDDC9@orsmsx35.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <4148FEAAD879D311AC5700A0C969E89006CDDDC9@orsmsx35.jf.intel.com>; from Grover, Andrew on Wed, Apr 25, 2001 at 10:23:12AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> We already have lid support in the latest ACPI versions (not in the official
> kernel yet.) You can download this code from
> http://developer.intel.com/technology/iapc/acpi/downloads.htm .
> 
> It'd be great if you could focus your testing and patches on this code base
> -- I think it's a lot better but it's still a work in progress.

I was just browsing its sources:

+       if (tz->policy.temperature >=
+               tz->policy.critical.threshold->temperature) {
+               DEBUG_PRINT(ACPI_WARN, ("Critical threshold reached - shutting down system.\n"));
+               /* TODO: 'halt' */
+       }

Are you sure that kill(init, SIGTERM) is not right answer here?

								Pavel
PS: This seems very strange. What if machine is so crashed so that it
can no longer shutdown properly. Will that mean that its CPU will
damage itself?
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
