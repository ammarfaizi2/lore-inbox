Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750941AbWEEXIS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750941AbWEEXIS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 19:08:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751222AbWEEXIR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 19:08:17 -0400
Received: from waste.org ([64.81.244.121]:34023 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S1750941AbWEEXIR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 19:08:17 -0400
Date: Fri, 5 May 2006 18:03:24 -0500
From: Matt Mackall <mpm@selenic.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/14] random: Remove SA_SAMPLE_RANDOM from network drivers
Message-ID: <20060505230324.GX15445@waste.org>
References: <2.420169009@selenic.com> <8.420169009@selenic.com> <20060505.141040.53473194.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060505.141040.53473194.davem@davemloft.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 05, 2006 at 02:10:40PM -0700, David S. Miller wrote:
> From: Matt Mackall <mpm@selenic.com>
> Date: Fri, 05 May 2006 11:42:35 -0500
> 
> > Remove SA_SAMPLE_RANDOM from network drivers
> > 
> > /dev/random wants entropy sources to be both unpredictable and
> > unobservable. Network devices are neither as they may be directly
> > observed and controlled by an attacker. Thus SA_SAMPLE_RANDOM is not
> > appropriate.
> > 
> > Signed-off-by: Matt Mackall <mpm@selenic.com>
> 
> Besides the other issues discussed, what you are doing is
> essentially making a headless machine with a quiet disk have
> next to zero entropy available.
> 
> I don't think we can seriously consider this patch, as I've seen real
> users run into this lack of entropy issue.

And my claim is they don't actually have any entropy. If they want to
continue fooling themselves, they can copy the device node for
/dev/urandom to /dev/random.

-- 
Mathematics is the supreme nostalgia of our time.
