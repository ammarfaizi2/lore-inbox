Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265303AbTFFFQb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 01:16:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265307AbTFFFQb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 01:16:31 -0400
Received: from stress.telefonica.net ([213.4.129.135]:8064 "EHLO
	tnetsmtp2.mail.isp") by vger.kernel.org with ESMTP id S265303AbTFFFQ3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 01:16:29 -0400
Subject: Re: PROBLEM: 2.4.21-rcX hangs when accessing HW clock on Toshiba
	laptop
From: Alfonso =?ISO-8859-1?Q?Mu=F1oz-Pomer?= Fuentes 
	<etinarcadiaego@terra.es>
To: Michael Frank <mflt1@micrologica.com.hk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200306051001.18672.mflt1@micrologica.com.hk>
References: <1054765786.448.22.camel@roamer>
	 <200306051001.18672.mflt1@micrologica.com.hk>
Content-Type: text/plain; charset=ISO-8859-15
Organization: 
Message-Id: <1054803938.12198.17.camel@roamer>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 05 Jun 2003 11:05:38 +0200
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-06-05 at 04:01, Michael Frank wrote:
> Problem is related to a number of toshiba and Intel implementations
> running ACPI since rel 20030424.
> 
> Temporary solution:
> 
> 1) Boot with single or ACPI=off
> 
> 2) Add --directisa to lines containing hwclock in rc.sysinit and halt
> 
> 3) Reboot normally
> 
> Regards
> Michael

Thanks a lot. Already fixed it.

>From what you tell me, do I have to deduce that the solution depends on
the ACPI developers? I have been looking the latest unstable kernel,
2.5.70, and I've seen there is something like 'Emulate /dev/rtc', so
maybe it's going to be left like it is now? It would be a problem,
though, because of how the default scripts (at least in Debian) are
written, but I guess that the Debian people are more than aware of the
problem.

Best regards...


> On Thursday 05 June 2003 06:29, Alfonso Muñoz-Pomer Fuentes wrote:
> > Hi, this is the first time that I post a bug relating to the Linux
> > kernel, so if I'm not including enough information, please tell me what
> > else is needed. I understand that the kernel being a critical system
> > element makes a lot of information be needed in order to solve bugs.
> >
> > I'll try to follow the form given for bug reports:
> >
> > 1. Kernel 2.4.21-rcX hangs when trying to access HW clock on a Toshiba
> > DynaBook V4/493PMHW
> >
> > 2. The program hwclock and thus the /etc/init.d scripts hwclock.sh and
> > hwclockfirst.sh are run the computer freezes. No response from the
> > keyboard or mouse. The cursor keeps blinking forever after the Enter key
> > is pressed if 'hwclock --show' is run, for instance, or the computer
> > hangs when it comes to adjust the system clock from the hardware clock
> > while running the /etc/init.d scripts. The HW clock in 2.4.20 works
> > perfectly.
> >
> > 3. Module: Character devices ---> Enhanced Real Time Clock Support
> >
> > 4. Linux version 2.4.21-rc7-ac1 (root@roamer) (gcc version 2.95.4
> > 20011002 (Debian prerelease)) -- Also happened in rc2 and rc5.

-- 
Alfonso Muñoz-Pomer Fuentes <etinarcadiaego@terra.es>

