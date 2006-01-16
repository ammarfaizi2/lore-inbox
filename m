Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751219AbWAPVw7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751219AbWAPVw7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 16:52:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751218AbWAPVw7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 16:52:59 -0500
Received: from mail.cs.umn.edu ([128.101.34.202]:64418 "EHLO mail.cs.umn.edu")
	by vger.kernel.org with ESMTP id S1751217AbWAPVw7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 16:52:59 -0500
Date: Mon, 16 Jan 2006 15:52:52 -0600
From: Dave C Boutcher <sleddog@us.ibm.com>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: Michael Ellerman <michael@ellerman.id.au>, Andrew Morton <akpm@osdl.org>,
       linuxppc64-dev@ozlabs.org, paulus@au1.ibm.com, anton@au1.ibm.com,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.15-mm4 failure on power5
Message-ID: <20060116215252.GA10538@cs.umn.edu>
Mail-Followup-To: "Serge E. Hallyn" <serue@us.ibm.com>,
	Michael Ellerman <michael@ellerman.id.au>,
	Andrew Morton <akpm@osdl.org>, linuxppc64-dev@ozlabs.org,
	paulus@au1.ibm.com, anton@au1.ibm.com, linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@elte.hu>
References: <20060116063530.GB23399@sergelap.austin.ibm.com> <20060115230557.0f07a55c.akpm@osdl.org> <200601170000.58134.michael@ellerman.id.au> <20060116153748.GA25866@sergelap.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060116153748.GA25866@sergelap.austin.ibm.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16, 2006 at 09:37:48AM -0600, Serge E. Hallyn wrote:
> Quoting Michael Ellerman (michael@ellerman.id.au):
> > On Mon, 16 Jan 2006 18:05, Andrew Morton wrote:
> > > "Serge E. Hallyn" <serue@us.ibm.com> wrote:
> > > > On my power5 partition, 2.6.15-mm4 hangs on boot
> 
> boot: quicktest
> Please wait, loading kernel...

...

> Page orders: linear mapping = 24, others = 12
>  -> smp_release_cpus()
>  <- smp_release_cpus()
>  <- setup_system()
> 
> So setup_system() at least finishes, though I don't see the
> printk's at the bottom of that function.

2.6.15-mm4 won't boot on my power5 either.  I tracked it down to the
following mutex patch from Ingo: kernel-kernel-cpuc-to-mutexes.patch

If I revert just that patch, mm4 boots fine.  Its really not obvious to
me at all why that patch is breaking things though...

-- 
Dave Boutcher
