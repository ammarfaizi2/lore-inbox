Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261628AbUJ0D1w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261628AbUJ0D1w (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 23:27:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261626AbUJ0D1v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 23:27:51 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:41434 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S261623AbUJ0D0Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 23:26:25 -0400
Subject: Re: Fixing MTRR smp breakage and suspending sysdevs.
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Li, Shaohua" <shaohua.li@intel.com>, Pavel Machek <pavel@ucw.cz>,
       Patrick Mochel <mochel@digitalimplant.org>
In-Reply-To: <200410262220.38052.dtor_core@ameritech.net>
References: <16A54BF5D6E14E4D916CE26C9AD30575699E58@pdsmsx402.ccr.corp.intel.com>
	 <200410262220.38052.dtor_core@ameritech.net>
Content-Type: text/plain
Message-Id: <1098847066.5661.47.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Wed, 27 Oct 2004 13:17:46 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Wed, 2004-10-27 at 13:20, Dmitry Torokhov wrote:
> On Tuesday 26 October 2004 09:48 pm, Li, Shaohua wrote:
> > >One thing I have noticed is that by adding the sysdev suspend/resume
> > >calls, I've gained a few seconds delay. I'll see if I can track down
> > the
> > >cause.
> > Is the problem MTRR resume must be with IRQ enabled, right? Could we
> > implement a method sysdev resume with IRQ enabled?
> 
> If I understand correctly the point of classifying device as sysdev is
> that it (device) is essential for the system and must be suspended last
> and resumed first, presumably with interrupts off. IRQ controller comes
> to mind...

Yes, but could we not do something like the process with regular
devices. ie a call with interrupts disabled and then a similar call with
interrupts enabled?

Regards,

Nigel 
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

Everyone lives by faith. Some people just don't believe it.
Want proof? Try to prove that the theory of evolution is true.

