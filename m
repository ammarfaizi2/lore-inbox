Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261337AbTH0SeS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 14:34:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261861AbTH0SeS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 14:34:18 -0400
Received: from www.13thfloor.at ([212.16.59.250]:33750 "EHLO www.13thfloor.at")
	by vger.kernel.org with ESMTP id S261337AbTH0SeQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 14:34:16 -0400
Date: Wed, 27 Aug 2003 20:34:28 +0200
From: Herbert =?iso-8859-1?Q?P=F6tzl?= <herbert@13thfloor.at>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: linux-kernel@vger.kernel.org, Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: UP optimizations ..
Message-ID: <20030827183428.GA18614@www.13thfloor.at>
Reply-To: herbert@13thfloor.at
Mail-Followup-To: Mikael Pettersson <mikpe@csd.uu.se>,
	linux-kernel@vger.kernel.org,
	Marcelo Tosatti <marcelo@conectiva.com.br>
References: <20030827160315.GD26817@www.13thfloor.at> <16204.62914.298711.293389@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <16204.62914.298711.293389@gargle.gargle.HOWL>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 27, 2003 at 08:17:38PM +0200, Mikael Pettersson wrote:
> Herbert =?iso-8859-1?Q?P=F6tzl?= writes:
>  > 
>  > Hi Mikael!
>  > Hi Marcelo!
>  > 
>  > stumbled repeatedly over the patches (or what remained of them)
>  > from Mikael?, replacing task->processor and friends by inline
>  > functions task_cpu(task), to eliminate them on UP systems ...
>  > 
>  > my questions: 
>  >  - is there an up to date patchset?
> 
> Yes, I've kept it up to date. In fact I've been using it in
> every single 2.4 kernel I've built for the last 18+ months.
> Lately also on ppc32 and x86-64.
> 
> Below is the current UP micro-optimisation patch set for 2.4.22.
> It changes p->processor, p->cpus_allowed, and p->cpus_runnable
> accesses (reads and writes) to use inline functions. In UP kernels
> these reduce to doing nothing or returning a constant.
> 
> To keep the patch small, it doesn't change accesses in SMP-only code.
> (This is also the reason why p->cpus_runnable only has a wrapper for
> updates, since all reads are in SMP-only code.)

good to know ... will use it in my patchset (now with reference ;)
let me know if you add/fix something ...

thanks for the patch,
Herbert

> /Mikael
