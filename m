Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312993AbSC0Lru>; Wed, 27 Mar 2002 06:47:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312994AbSC0Lrk>; Wed, 27 Mar 2002 06:47:40 -0500
Received: from netfinity.realnet.co.sz ([196.28.7.2]:26518 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S312993AbSC0Lrd>; Wed, 27 Mar 2002 06:47:33 -0500
Date: Wed, 27 Mar 2002 13:36:04 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Dave Jones <davej@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] P4/Xeon Thermal LVT support
In-Reply-To: <20020327124333.A17832@suse.de>
Message-ID: <Pine.LNX.4.44.0203271334060.31636-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Mar 2002, Dave Jones wrote:

> On Wed, Mar 27, 2002 at 08:04:37AM +0200, Zwane Mwaikambo wrote:
> 
>  > +	rdmsr(MSR_IA32_THERM_STATUS, l, h);
>  > +	if (l & 1) {
>  > +		printk(KERN_EMERG "CPU#%d: Temperature above threshold\n", cpu);
>  > +		printk(KERN_EMERG "CPU#%d: Running in modulated clock mode\n", cpu);
>  > +	} else {
>  > +		printk(KERN_INFO "CPU#%d: Temperature/speed normal\n", cpu);
>  > +	}
> 
> This chunk probably wants to be rate-limited to avoid flooding the
> same message over and over.

That shouldn't be a problem since the interrupt only occurs on thermal 
transition, ie when you hit over the threshold or hit below. Therefore we 
shouldn't be fluctuating since the clock modulation will be in effect and 
the temperature will drop. However i can't be 100% certain.

	Zwane

-- 
http://function.linuxpower.ca
		

