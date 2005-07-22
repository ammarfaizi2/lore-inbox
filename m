Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262129AbVGVSGZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262129AbVGVSGZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 14:06:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262130AbVGVSDy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 14:03:54 -0400
Received: from mail.charite.de ([160.45.207.131]:54938 "EHLO mail.charite.de")
	by vger.kernel.org with ESMTP id S262124AbVGVSCG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 14:02:06 -0400
Date: Fri, 22 Jul 2005 20:02:04 +0200
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: linux-kernel@vger.kernel.org
Subject: Re: ALSA, snd_intel8x0m and kexec() don't work together (2.6.13-rc3-git4 and 2.6.13-rc3-git3)
Message-ID: <20050722180204.GD30517@charite.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20050721180621.GA25829@charite.de> <20050722062548.GJ25829@charite.de> <200507221614.28096.vda@ilport.com.ua> <20050722131825.GR8528@charite.de> <1122054941.877.6.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1122054941.877.6.camel@mindpipe>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Lee Revell <rlrevell@joe-job.com>:

> > 2.6.12 didn't have kexec (unless it's a -mm kernel)
> > So how could you boot using kexec then?
> > 
> 
> Is kexec supposed to be transparent to all the subsystems, or does ALSA
> have to know how to stop all DMA in order for kexec to work?

The way I used it was to replace the "reboot" call in
/etc/init.d/reboot. So at that time, ALSA was already "stopped"
(/etc/init.d/also stop ran)  -- shouldn't that suffice?

Kconfig says:

kexec is a system call that implements the ability to shutdown your
current kernel, and to start another kernel.  It is like a reboot but it
is indepedent of the system firmware.  And like a reboot you can start
any kernel with it, not just Linux.
	  
The name comes from the similiarity to the exec system call.

It is an ongoing process to be certain the hardware in a machine is
properly shutdown, so do not be surprised if this code does not initially
work for you.  It may help to enable device hotplugging support.  As of
this writing the exact hardware interface is strongly in flux, so no good
recommendation can be made.
	    
		    
-- 
Ralf Hildebrandt (i.A. des IT-Zentrums)         Ralf.Hildebrandt@charite.de
Charite - Universitätsmedizin Berlin            Tel.  +49 (0)30-450 570-155
Gemeinsame Einrichtung von FU- und HU-Berlin    Fax.  +49 (0)30-450 570-962
IT-Zentrum Standort CBF                 send no mail to spamtrap@charite.de
