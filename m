Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261241AbULEDKf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261241AbULEDKf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Dec 2004 22:10:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261242AbULEDKf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Dec 2004 22:10:35 -0500
Received: from out011pub.verizon.net ([206.46.170.135]:45250 "EHLO
	out011.verizon.net") by vger.kernel.org with ESMTP id S261241AbULEDJ4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Dec 2004 22:09:56 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm2-V0.7.32-0
Date: Sat, 4 Dec 2004 22:10:48 -0500
User-Agent: KMail/1.7
Cc: "K.R. Foley" <kr@cybsft.com>, Ingo Molnar <mingo@elte.hu>,
       Rui Nuno Capela <rncbc@rncbc.org>, Lee Revell <rlrevell@joe-job.com>,
       mark_h_johnson@raytheon.com, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>,
       Esben Nielsen <simlo@phys.au.dk>
References: <20041116130946.GA11053@elte.hu> <20041204224641.GA14850@elte.hu> <41B24E6D.4010205@cybsft.com>
In-Reply-To: <41B24E6D.4010205@cybsft.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412042210.48637.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out011.verizon.net from [151.205.11.214] at Sat, 4 Dec 2004 21:09:50 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 04 December 2004 18:55, K.R. Foley wrote:
>Ingo Molnar wrote:
>> * Rui Nuno Capela <rncbc@rncbc.org> wrote:
>>>Ingo Molnar wrote:
>>>>i have released the -V0.7.32-0 Real-Time Preemption patch, which
>>>> can be downloaded from the usual place:
>>>
>>>I have a bug to report, it shows on both of my machines (SMP and
>>> UP) now running RT-V0.7.32-2. It seems to be present also on
>>> previous RT releases, and don't even know if it's upstream.
>>>
>>>When one usb-storage flash stick is first time unplugged:
>>
>> hm, doesnt seem to be directly related to -RT. Could you try the
>> vanilla -rc2-mm3 kernel, does it trigger there too?
>>
>>  Ingo
>
>Gene Heskett reported a very similar problem yesterday with the
> subject: Re:2.6.10-rc2-mm3-V0.7.31-19

Yes, and I can confirm that it does not do it right now, running
the UP version of 2.6.10-rc3.  I just tried it and this is all
I got in the log:
-----------------
Dec  4 22:06:38 coyote kernel: usb 3-2.2: new full speed USB device using ohci_hcd and address 7
Dec  4 22:06:38 coyote kernel: scsi0 : SCSI emulation for USB Mass Storage devices
Dec  4 22:06:44 coyote kernel:   Vendor: OLYMPUS   Model: C-3020ZOOM(U)     Rev: 1.00
Dec  4 22:06:44 coyote kernel:   Type:   Direct-Access                      ANSI SCSI revision: 02
Dec  4 22:06:44 coyote kernel: Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
Dec  4 22:06:44 coyote scsi.agent[26069]: disk at /devices/pci0000:00/0000:00:02.1/usb3/3-2/3-2.2/3-2.2:1.0/host0/target0:0:0/0:0:0:0
Dec  4 22:06:44 coyote kernel: SCSI device sda: 128000 512-byte hdwr sectors (66 MB)
Dec  4 22:06:44 coyote kernel: sda: assuming Write Enabled
Dec  4 22:06:44 coyote kernel: sda: assuming drive cache: write through
Dec  4 22:06:44 coyote kernel: SCSI device sda: 128000 512-byte hdwr sectors (66 MB)
Dec  4 22:06:44 coyote kernel: sda: assuming Write Enabled
Dec  4 22:06:44 coyote kernel: sda: assuming drive cache: write through
Dec  4 22:06:44 coyote kernel:  sda: sda1
Dec  4 22:06:44 coyote kernel: Attached scsi removable disk sda at scsi0, channel 0, id 0, lun 0
Dec  4 22:06:51 coyote kernel: usb 3-2.2: USB disconnect, address 7
-----------------
-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.30% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
