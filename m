Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751970AbWCOWtS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751970AbWCOWtS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 17:49:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752128AbWCOWtS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 17:49:18 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:11232 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751970AbWCOWtR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 17:49:17 -0500
Date: Wed, 15 Mar 2006 23:46:59 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>,
       Jeff Garzik <jeff@garzik.org>, Lee Revell <rlrevell@joe-job.com>,
       Andi Kleen <ak@suse.de>, Jason Baron <jbaron@redhat.com>,
       linux-kernel@vger.kernel.org, john stultz <johnstul@us.ibm.com>
Subject: Re: libata/sata_nv latency on NVIDIA CK804 [was Re: AMD64 X2 lost ticks on PM timer]
Message-ID: <20060315224659.GD24074@elte.hu>
References: <200602280022.40769.darkray@ic3man.com> <4408BEB5.7000407@garzik.org> <20060303234330.GA14401@ti64.telemetry-investments.com> <200603040107.27639.ak@suse.de> <20060315213638.GA17817@ti64.telemetry-investments.com> <1142459152.1671.64.camel@mindpipe> <20060315215848.GB18241@elte.hu> <441893AB.1070300@garzik.org> <20060315222441.GA24074@elte.hu> <20060315223656.GC17817@ti64.telemetry-investments.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060315223656.GC17817@ti64.telemetry-investments.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Bill Rugolsky Jr. <brugolsky@telemetry-investments.com> wrote:

> On Wed, Mar 15, 2006 at 11:24:41PM +0100, Ingo Molnar wrote:
> > well, it's a PIO inb() op i think, and could thus in theory trigger SMM 
> > BIOS code.
>  
> Is there any easy way to disable more SMM stuff than "noacpi"?

not that i know of. Point of SMM is to make it hard to disable by OSs.
They are a kind of hypervisor mode for the purposes of seemless hardware 
soft-extensions, from the days when it wasnt yet fashionable to call 
them virtualization ;)

> If push comes to shove, I'll go all the way and just install LinuxBIOS 
> on the damn thing.  Though I'm sure that will be a chore.

i think it might be easier to try the new sata_nv.c driver first.

	Ingo
