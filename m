Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270821AbUJUTB3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270821AbUJUTB3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 15:01:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270822AbUJUS6R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 14:58:17 -0400
Received: from mail3.utc.com ([192.249.46.192]:21194 "EHLO mail3.utc.com")
	by vger.kernel.org with ESMTP id S270812AbUJUS52 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 14:57:28 -0400
Message-ID: <41780687.8030408@cybsft.com>
Date: Thu, 21 Oct 2004 13:57:11 -0500
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: tglx@linutronix.de
CC: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Mark_H_Johnson@Raytheon.com, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U9
References: <20041013061518.GA1083@elte.hu> <20041014002433.GA19399@elte.hu>	 <20041014143131.GA20258@elte.hu> <20041014234202.GA26207@elte.hu>	 <20041015102633.GA20132@elte.hu> <20041016153344.GA16766@elte.hu>	 <20041018145008.GA25707@elte.hu> <20041019124605.GA28896@elte.hu>	 <20041019180059.GA23113@elte.hu> <20041020094508.GA29080@elte.hu>	 <20041021132717.GA29153@elte.hu>  <4177FADC.6030905@cybsft.com> <1098384016.27089.42.camel@thomas>
In-Reply-To: <1098384016.27089.42.camel@thomas>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner wrote:
> On Thu, 2004-10-21 at 20:07, K.R. Foley wrote:
> 
>>Ingo Molnar wrote:
>>
>>>i have released the -U9 Real-Time Preemption patch, which can be
>>>downloaded from:
>>>
>>>  http://redhat.com/~mingo/realtime-preempt/
>>>
>>
>>Finally a patch that I can get booted on my older SMP system at home 
>>again. More correctly it is U9.2. I have been having problems with these 
>>hanging after U5. Haven't had a ton of time to try to track down the 
>>problems and didn't want to report problems without having done enough 
>>troubleshooting. Anyway, I got this while booting U9.2.
> 
> 
> I guess, you don't have a tulip network card in your box, as the module
> is removed.
> 
> The question is, if it got registered correctly before the removal.
> 
> tglx

Actually I do have the tulip card in the box and I am pulling this stuff 
from the logs over that connection now. Here are the next lines from the 
log that might help.

Oct 21 12:33:22 porky kernel: tulip 0000:04:0a.0: Device was removed 
without pro
perly calling pci_disable_device(). This may need fixing.
Oct 21 12:33:22 porky kernel: hda: ATAPI 48X CD-ROM CD-R/RW drive, 
8192kB Cache,
  UDMA(33)
Oct 21 12:33:22 porky kernel: Uniform CD-ROM driver Revision: 3.20
Oct 21 12:33:22 porky kernel: hdc: ATAPI 48X CD-ROM drive, 120kB Cache, 
UDMA(33)
Oct 21 12:33:22 porky kernel: ip_tables: (C) 2000-2002 Netfilter core team
Oct 21 12:33:22 porky kernel: Linux Tulip driver version 1.1.13 (May 11, 
2002)
Oct 21 12:33:22 porky kernel: PCI: Found IRQ 5 for device 0000:04:0a.0
Oct 21 12:33:22 porky kernel: PCI: Sharing IRQ 5 with 0000:04:05.1
Oct 21 12:33:22 porky kernel: tulip0:  EEPROM default media type Autosense.
Oct 21 12:33:22 porky kernel: tulip0:  Index #0 - Media MII (#11) 
described by a
  21140 MII PHY (1) block.
Oct 21 12:33:22 porky kernel: tulip0:  MII transceiver #3 config 3100 
status 780
9 advertising 01e1.
Oct 21 12:33:22 porky kernel: eth0: Digital DS21140 Tulip rev 32 at 
0xe480, 00:0
0:C0:7F:A0:E9, IRQ 5.
