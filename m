Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264922AbUAIWUg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 17:20:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264929AbUAIWUf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 17:20:35 -0500
Received: from smtp.sys.beep.pl ([195.245.198.13]:63748 "EHLO maja.beep.pl")
	by vger.kernel.org with ESMTP id S264922AbUAIWUa convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 17:20:30 -0500
From: Arkadiusz Miskiewicz <arekm@pld-linux.org>
Organization: SelfOrganizing
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.24 SMP lockups
Date: Fri, 9 Jan 2004 23:20:19 +0100
User-Agent: KMail/1.5.94
References: <20040109210450.GA31404@netnation.com>
In-Reply-To: <20040109210450.GA31404@netnation.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Message-Id: <200401092320.19500.arekm@pld-linux.org>
X-Authenticated-Id: arekm 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 09 of January 2004 22:04, Simon Kirby wrote:
> 'lo all,
>
> We've had about 6 cases of this now, across 4 separate boxes. 
I had several such cases with 2.4.23 on two separate boxes. First is dual PIII 
1GHz Intel SRMK2 platform - 
http://www.intel.com/support/motherboards/server/srmk2/ with 1,5GB RAM, 
reiserfs as filesystem, scsi disks and Adaptec AIC-7899P U160/m controller.

Second was UP PIII 500MHz machine on some Intel BX mainboard, 256MB RAM, ext3 
as filesystem, software raid 5 on scsi disks using aic7xxx (Adaptec AIC-7892B 
U160/m).

First one was locking up few times per day (pretty big load), second one maybe 
once per day/two (lower load).

Both machines are working _fine_ with 2.4.21 kernel (one was also using 2.4.22 
for some time and no problems occured).

kernels on both machines were exactly the same (just copied) but using 
different modules - kernel was compiled using 2.95.4 (3+some parts from 2.95 
branch of gcc cvs)

> These boxes are all dual CPU, and the failure case shows up suddenly with
> no warning.  Sysreq-P works, but only reports from one CPU no matter how
> many times I try.  In normal operation, every machine distributes all
> IRQs across both CPUs, and Sysreq-P reports from both CPUs.
Similar here - but sometimes even sysrq wasn't working (on second machine).

> Even on boxes with nmi_watchdog=1, nothing is reported from the NMI
> watchdog.
Exactly same here.
append=" console=tty0 console=ttyS0,9600n81 panic=60 nmi_watchdog=1"

I was thinking that maybe that's due to some problem in aic7xxx driver and 
updated it on one machine to latest available version (these in kernel are 
very old) but that didn't help.

> Simon-

-- 
Arkadiusz Mi¶kiewicz    CS at FoE, Wroclaw University of Technology
arekm.pld-linux.org AM2-6BONE, 1024/3DB19BBD, arekm(at)ircnet, PLD/Linux
