Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261781AbVDEPeq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261781AbVDEPeq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 11:34:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261773AbVDEPeo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 11:34:44 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:61114 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261789AbVDEPbg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 11:31:36 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: acpi-devel@lists.sourceforge.net, romano@dea.icai.upco.es
Subject: Re: [ACPI] Re: 2.6.12-rc1-mm4 and suspend2ram (and synaptics)
Date: Tue, 5 Apr 2005 17:31:52 +0200
User-Agent: KMail/1.7.1
Cc: Pavel Machek <pavel@ucw.cz>, Stefan Schweizer <sschweizer@gmail.com>,
       Norbert Preining <preining@logic.at>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
References: <20050331220822.GA22418@gamma.logic.tuwien.ac.at> <20050402085935.GC1330@openzaurus.ucw.cz> <20050405150105.GA26149@pern.dea.icai.upco.es>
In-Reply-To: <20050405150105.GA26149@pern.dea.icai.upco.es>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504051731.52845.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tuesday, 5 of April 2005 17:01, Romano Giannetti wrote:
> > 
> > Same way to debug it, then.... try minimal drivers.
> 
> Yes, the lifer of a kernel debugger is hard... 
> 
> Pavel, one question (maybe stupid, I am not at all an expert). Wouldn't be
> possible to add a printk when invoking and returning from suspend/resume
> methods of drivers, telling if they are specific or generic on? Maybe with
> the help of the serial console could be an aid to detect wich drivers are
> failing in that case.

The serial sonsole itself is disabled during suspend/resume, so you have to
hack the serial driver's suspend/resume routines to get any output on it
at that time. :-)

Anyway, if you want to put some debug printks somewhere, IMO a good place
to start is in resume_device() in drivers/base/power/resume.c or
in suspend_device() in drivers/base/power/suspend.c (actually, there already
is one, you only need to enable it).

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
