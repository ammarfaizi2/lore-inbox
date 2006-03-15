Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752128AbWCOWun@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752128AbWCOWun (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 17:50:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751625AbWCOWun
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 17:50:43 -0500
Received: from mail.dvmed.net ([216.237.124.58]:56715 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751360AbWCOWum (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 17:50:42 -0500
Message-ID: <44189A3D.5090202@garzik.org>
Date: Wed, 15 Mar 2006 17:50:37 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>,
       Andi Kleen <ak@suse.de>, Lee Revell <rlrevell@joe-job.com>,
       Jason Baron <jbaron@redhat.com>, linux-kernel@vger.kernel.org,
       john stultz <johnstul@us.ibm.com>
Subject: Re: libata/sata_nv latency on NVIDIA CK804 [was Re: AMD64 X2 lost
 ticks on PM timer]
References: <200602280022.40769.darkray@ic3man.com> <4408BEB5.7000407@garzik.org> <20060303234330.GA14401@ti64.telemetry-investments.com> <200603040107.27639.ak@suse.de> <20060315213638.GA17817@ti64.telemetry-investments.com> <20060315215020.GA18241@elte.hu> <20060315221119.GA21775@elte.hu> <44189654.2080607@garzik.org> <20060315224408.GC24074@elte.hu>
In-Reply-To: <20060315224408.GC24074@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Jeff Garzik <jeff@garzik.org> wrote:
> 
> 
>>It won't work at all...
> 
> 
> ok.
> 
> 
>>You have to stop talking to PCI IDE registers completely (consumes 5 
>>PCI BARs), and talk exclusively to the MMIO 6th PCI BAR, at 
>>non-standard offsets and a using a proprietary DMA descriptor format 
>>[all public now in that link I just sent].
> 
> 
> just to make it easier to test: i've attached the new sata_nv.c file, 
> which, to test it, should be copied over the existing 
> drivers/scsi/sata_nv.c file, correct?

Alas, it is far from that simple :(

The code I linked to isn't in a working state.  NV contributed it 
largely as "it worked at one time" documentation of a 
previously-undocumented register interface.

Someone needs to debug it.

	Jeff



