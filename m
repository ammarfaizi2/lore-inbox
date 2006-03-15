Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751282AbWCOVp7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751282AbWCOVp7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 16:45:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751327AbWCOVp7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 16:45:59 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:24532 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751282AbWCOVp7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 16:45:59 -0500
Subject: Re: libata/sata_nv latency on NVIDIA CK804 [was Re: AMD64 X2 lost
	ticks on PM timer]
From: Lee Revell <rlrevell@joe-job.com>
To: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>
Cc: Andi Kleen <ak@suse.de>, Jeff Garzik <jeff@garzik.org>,
       Jason Baron <jbaron@redhat.com>, linux-kernel@vger.kernel.org,
       john stultz <johnstul@us.ibm.com>, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20060315213638.GA17817@ti64.telemetry-investments.com>
References: <200602280022.40769.darkray@ic3man.com>
	 <4408BEB5.7000407@garzik.org>
	 <20060303234330.GA14401@ti64.telemetry-investments.com>
	 <200603040107.27639.ak@suse.de>
	 <20060315213638.GA17817@ti64.telemetry-investments.com>
Content-Type: text/plain
Date: Wed, 15 Mar 2006 16:45:51 -0500
Message-Id: <1142459152.1671.64.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-03-15 at 16:36 -0500, Bill Rugolsky Jr. wrote:
>    <...>-2913  0d.h.    9us : ata_host_intr (nv_interrupt)
>    <...>-2913  0d.h.    9us!: ata_bmdma_status (ata_host_intr)
>    <...>-2913  0d.h. 16641us : nv_check_hotplug_ck804 (nv_interrupt)
>    <...>-2913  0d.h. 16642us : _spin_unlock_irqrestore (nv_interrupt) 

There's your problem - it looks like ata_bmdma_status() stalled the
machine for almost 17ms.

Lee

