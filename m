Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285553AbRLGVRX>; Fri, 7 Dec 2001 16:17:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285554AbRLGVRN>; Fri, 7 Dec 2001 16:17:13 -0500
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:11179 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S285553AbRLGVRB>; Fri, 7 Dec 2001 16:17:01 -0500
Date: Fri, 7 Dec 2001 16:16:59 -0500
From: Arjan van de Ven <arjanv@redhat.com>
To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] [RFC] [PATCH] Scalable Statistics Counters
Message-ID: <20011207161659.A22935@devserv.devel.redhat.com>
In-Reply-To: <3C0F6D99.8CF24014@redhat.com> <951177670.1007759364@[195.224.237.69]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <951177670.1007759364@[195.224.237.69]>; from linux-kernel@alex.org.uk on Fri, Dec 07, 2001 at 09:09:25PM -0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

yOn Fri, Dec 07, 2001 at 09:09:25PM -0000, Alex Bligh - linux-kernel wrote:
> 
> 
> --On Thursday, 06 December, 2001 1:07 PM +0000 Arjan van de Ven 
> <arjanv@redhat.com> wrote:
> 
> > Would you care to point out a statistic in the kernel that is
> > incremented
> > more than 10.000 times/second ? (I'm giving you a a factor of 100 of
> > playroom
> > here) [One that isn't per-cpu yet of course]
> 
> cat /proc/net/dev
> 
> 80,000 increments a second here on at least 4 counters

except that
1) you can (and should) bind nics to cpus
and 
2) the cacheline for nic stats should (for good drivers) be in the cacheline
the ISR gets into the cpu ANYWAY to get to the device data -> no extra
cacheline pingpong
