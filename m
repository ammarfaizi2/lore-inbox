Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264698AbSIQXrM>; Tue, 17 Sep 2002 19:47:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264699AbSIQXrM>; Tue, 17 Sep 2002 19:47:12 -0400
Received: from ns.suse.de ([213.95.15.193]:45330 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S264698AbSIQXrM>;
	Tue, 17 Sep 2002 19:47:12 -0400
Date: Wed, 18 Sep 2002 01:52:09 +0200
From: Andi Kleen <ak@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: johnstul@us.ibm.com, jamesclv@us.ibm.com, ak@suse.de,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
       anton.wilson@camotion.com
Subject: Re: do_gettimeofday vs. rdtsc in the scheduler
Message-ID: <20020918015209.B31263@wotan.suse.de>
References: <200209171555.52872.jamesclv@us.ibm.com> <20020917.161215.03597459.davem@redhat.com> <1032305535.7481.204.camel@cog> <20020917.163246.113965700.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020917.163246.113965700.davem@redhat.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 17, 2002 at 04:32:46PM -0700, David S. Miller wrote:
>    From: john stultz <johnstul@us.ibm.com>
>    Date: 17 Sep 2002 16:32:15 -0700
>    
>    Additionally, where is this system tick thing? You make it sound like
>    its a register in the cpu, and while the Ultra-III may have one, I'm
>    unaware of a system/bus tick register on intel chips. Is it in some
>    semi-documented MSR?
> 
> It's in a register on Ultra-III.  The whole point of this
> conversation, if you read my initial postings, is that
> "this should have been specified in the x86 architecture"
> 
> I know full well it isn't currently :-)

Sorry, it's wrong. The x86 architecture has several such registers
(apic timers, 8253 timer, HPET [Microsoft requires this for new 
hardware that will be w*s certified]) 
They just all suck on various systems or in general. HPET is ok, 
but still not widespread enough.

-Andi

