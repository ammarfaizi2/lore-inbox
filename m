Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319404AbSH3DYi>; Thu, 29 Aug 2002 23:24:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319406AbSH3DYi>; Thu, 29 Aug 2002 23:24:38 -0400
Received: from warden-b.diginsite.com ([208.29.163.249]:42954 "HELO
	wardenb.diginsite.com") by vger.kernel.org with SMTP
	id <S319404AbSH3DYh>; Thu, 29 Aug 2002 23:24:37 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Dominik Brodowski <devel@brodo.de>, cpufreq@www.linux.org.uk,
       linux-kernel@vger.kernel.org
Date: Thu, 29 Aug 2002 20:21:36 -0700 (PDT)
Subject: Re: [PATCH][2.5.32] CPU frequency and voltage scaling (0/4)
In-Reply-To: <1030618420.7290.112.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0208292017160.30080-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

be careful here, it's not unreasonable to imagine a power saving mode that
shuts down one CPU of a SMP machine.

don't make assumptions about what parameters make sense for all possible
policies, try to find some way for the parameters to depend on the policy
selected.

David Lang


On 29 Aug 2002, Alan Cox wrote:

> Date: 29 Aug 2002 11:53:40 +0100
> From: Alan Cox <alan@lxorguk.ukuu.org.uk>
> To: Linus Torvalds <torvalds@transmeta.com>
> Cc: Dominik Brodowski <devel@brodo.de>, cpufreq@www.linux.org.uk,
>      linux-kernel@vger.kernel.org
> Subject: Re: [PATCH][2.5.32] CPU frequency and voltage scaling (0/4)
>
> >  { min-Hz, max-Hz, policy }
> >
>
> For a few of the processors "event-hz" or similar would be nice. The
> Geode supports hardware assisted bursting to full processor speed when
> doing SMM, I/O and IRQ handling.
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
