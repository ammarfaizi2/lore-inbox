Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752117AbWCOWZx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752117AbWCOWZx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 17:25:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752119AbWCOWZw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 17:25:52 -0500
Received: from mail.dvmed.net ([216.237.124.58]:36746 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1752117AbWCOWZw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 17:25:52 -0500
Message-ID: <44189468.6000201@garzik.org>
Date: Wed, 15 Mar 2006 17:25:44 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Lee Revell <rlrevell@joe-job.com>,
       "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>,
       Andi Kleen <ak@suse.de>, Jason Baron <jbaron@redhat.com>,
       linux-kernel@vger.kernel.org, john stultz <johnstul@us.ibm.com>
Subject: Re: libata/sata_nv latency on NVIDIA CK804 [was Re: AMD64 X2 lost
 ticks on PM timer]
References: <200602280022.40769.darkray@ic3man.com> <4408BEB5.7000407@garzik.org> <20060303234330.GA14401@ti64.telemetry-investments.com> <200603040107.27639.ak@suse.de> <20060315213638.GA17817@ti64.telemetry-investments.com> <1142459152.1671.64.camel@mindpipe> <20060315215848.GB18241@elte.hu> <20060315220046.GA20469@elte.hu>
In-Reply-To: <20060315220046.GA20469@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> so my guess would be that this device doesnt do MMIO, and the PIO inb() 
> causes some bad BIOS-based SMM handler/emulator to trigger, which takes 
> 16.6 msecs. If indeed the device is not in MMIO mode, is there a way to 
> force it into MMIO mode, to test this theory?

Yes, but that carries with it an entirely new programming set, to use 
MMIO: http://marc.theaimsgroup.com/?l=linux-ide&m=114124501116060&w=2

Not like NICs, where you can just point it at another PCI BAR.

	Jeff


