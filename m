Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932680AbWCPGa2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932680AbWCPGa2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 01:30:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932678AbWCPGa2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 01:30:28 -0500
Received: from ookhoi.xs4all.nl ([213.84.114.66]:56792 "EHLO
	favonius.humilis.net") by vger.kernel.org with ESMTP
	id S932381AbWCPGa1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 01:30:27 -0500
Date: Thu, 16 Mar 2006 07:30:24 +0100
From: Sander <sander@humilis.net>
To: Jeff Garzik <jeff@garzik.org>
Cc: Dax Kelson <dax@gurulabs.com>, linux-kernel@vger.kernel.org,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: Re: Warning - Maxtor SATA II and Nvidia nforce4
Message-ID: <20060316063024.GB8825@favonius>
Reply-To: sander@humilis.net
References: <1142461887.2521.44.camel@station14.example.com> <4418996E.6010808@garzik.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4418996E.6010808@garzik.org>
X-Uptime: 06:27:37 up 13 days, 10:37, 24 users,  load average: 2.99, 2.29, 2.59
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote (ao):
> Ah, I see this made it to LKML :)

I'm not the OP. The Maxtor notice is a few months old already.

> Dax Kelson wrote:
> >Short version
> >==============
> >Nvidia Nforce4 chipset with Maxtor SATA II drives with certain firmware
> >revisions cause data corruption and system instability when under
> >moderate to heavy I/O load.
> 
> I'm a bit suspicious of this.
> 
> Looking at the link, there are three problem areas and two problem blame 
> targets implied:
> 
> 	Data corruption	-> blame nvidia driver
> 	NCQ		-> blame nvidia driver
> 	Detection	-> blame maxtor firmware
> 
> The first one likely applies to the Windows driver not Linux's sata_nv, 
> and thus irrelevant here.  The second one OBVIOUSLY applies only to 
> Windows, since sata_nv (and libata itself) don't yet enable NCQ.  The 
> third one could potentially apply to Linux.  Lastly, your mention of 
> "nforce fake raid" almost certainly indicates Windows or proprietary 
> drivers.
> 
> Therefore, I ask:
> * are you reporting a only drive detection problem?
> * why are you reporting unrelated Windows problems to a Linux list?
> * if you are indeed reporting a problem on Linux, where is the kernel 
> and driver version info, as requested in REPORTING-BUGS?
> * and can you provide such info *and reproduce the problems* without 
> proprietary drivers loaded?
> 
> Your email is just a list of highly general symptoms.  Your link seems 
> to indicate two NV driver bugs on Windows, and a Maxtor firmware upgrade 
> for undescribed detection problems.
> 
> My recommended action for users is:
> 1) Avoid Windows.
> 2) Don't panic.

Last december I requested new firmware for my drives. Maxtor called me
and asked if I did have any problems. I did not, but just wanted to fix
the problem before I would notice any.

The Maxtor guy then told me that harddisk firmware upgrades are best not
to be done if not needed, and asked what operating system I run (answer:
Linux). He said that the problems only exists with Windows, and that
Linux should be ok.

In fact, I have yet to see a problem with my sata Maxtor disks connected
to the onboard nForce4 controller. This supports Jeff Garziks story.

I do notice that the nForce4 controller most of the times fails to
detect some of the drives (seems random) on a reboot. A powerdown and
fresh boot lets the controller detect all disks again.

	Sander

-- 
Humilis IT Services and Solutions
http://www.humilis.net
