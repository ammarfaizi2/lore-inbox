Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312991AbSC0LoA>; Wed, 27 Mar 2002 06:44:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312992AbSC0Lnu>; Wed, 27 Mar 2002 06:43:50 -0500
Received: from ns.suse.de ([213.95.15.193]:34320 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S312991AbSC0Lng>;
	Wed, 27 Mar 2002 06:43:36 -0500
Date: Wed, 27 Mar 2002 12:43:33 +0100
From: Dave Jones <davej@suse.de>
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] P4/Xeon Thermal LVT support
Message-ID: <20020327124333.A17832@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Zwane Mwaikambo <zwane@linux.realnet.co.sz>,
	Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0203270751400.22305-100000@netfinity.realnet.co.sz> <Pine.LNX.4.44.0203270803150.22597-100000@netfinity.realnet.co.sz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2002 at 08:04:37AM +0200, Zwane Mwaikambo wrote:

 > +	rdmsr(MSR_IA32_THERM_STATUS, l, h);
 > +	if (l & 1) {
 > +		printk(KERN_EMERG "CPU#%d: Temperature above threshold\n", cpu);
 > +		printk(KERN_EMERG "CPU#%d: Running in modulated clock mode\n", cpu);
 > +	} else {
 > +		printk(KERN_INFO "CPU#%d: Temperature/speed normal\n", cpu);
 > +	}

This chunk probably wants to be rate-limited to avoid flooding the
same message over and over.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
