Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261625AbUJ0DWe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261625AbUJ0DWe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 23:22:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261621AbUJ0DWd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 23:22:33 -0400
Received: from smtp812.mail.sc5.yahoo.com ([66.163.170.82]:52111 "HELO
	smtp812.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261620AbUJ0DUk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 23:20:40 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Fixing MTRR smp breakage and suspending sysdevs.
Date: Tue, 26 Oct 2004 22:20:38 -0500
User-Agent: KMail/1.6.2
Cc: "Li, Shaohua" <shaohua.li@intel.com>, <ncunningham@linuxmail.org>,
       "Pavel Machek" <pavel@ucw.cz>,
       "Patrick Mochel" <mochel@digitalimplant.org>
References: <16A54BF5D6E14E4D916CE26C9AD30575699E58@pdsmsx402.ccr.corp.intel.com>
In-Reply-To: <16A54BF5D6E14E4D916CE26C9AD30575699E58@pdsmsx402.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200410262220.38052.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 26 October 2004 09:48 pm, Li, Shaohua wrote:
> >One thing I have noticed is that by adding the sysdev suspend/resume
> >calls, I've gained a few seconds delay. I'll see if I can track down
> the
> >cause.
> Is the problem MTRR resume must be with IRQ enabled, right? Could we
> implement a method sysdev resume with IRQ enabled?

If I understand correctly the point of classifying device as sysdev is
that it (device) is essential for the system and must be suspended last
and resumed first, presumably with interrupts off. IRQ controller comes
to mind...
 
-- 
Dmitry
