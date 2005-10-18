Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751438AbVJRA7k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751438AbVJRA7k (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 20:59:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751441AbVJRA7k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 20:59:40 -0400
Received: from sccrmhc14.comcast.net ([204.127.202.59]:27780 "EHLO
	sccrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S1751438AbVJRA7j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 20:59:39 -0400
Date: Mon, 17 Oct 2005 18:00:28 -0700
From: Deepak Saxena <dsaxena@plexity.net>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] RNG rewrite...
Message-ID: <20051018010028.GA16005@plexity.net>
Reply-To: dsaxena@plexity.net
References: <20051015043120.GA5946@plexity.net> <4350DCB1.7010201@pobox.com> <20051016005341.GB5946@plexity.net> <43543455.4080206@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43543455.4080206@pobox.com>
Organization: Plexity Networks
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 17 2005, at 19:31, Jeff Garzik was caught saying:
> >PCI devices, but I don't know enough about x86 to say whether msr 
> >instructions can execute out of userspace (or if we want them to...).
> 
> All of the hot path RNG stuff can and should be moved to userspace.
> 
> Right now the path is
> 
> 	kernel /dev/hwrandom -> rngd -> add /dev/random entropy
> 
> All three current vendors shown in hw_random.c are doable in userspace. 
>  Intel uses MMIO, AMD uses PIO, and VIA uses a specialized CPU 
> instruction.  As HPA mentioned, you can use the MSR driver for control.
> 
> Patches welcome!  http://sf.net/projects/gkernel/

OK...I already did most of a rewrite keeping the driver in user space
and added support for IXP4xx and OMAP but will look at the msr driver. 
However, looking at the MPC85xx and the Alchemy MIPs parts with RNGs, 
they have interrupt sources for error conditions so those need to be 
in kernel...

~Deepak

-- 
Deepak Saxena - dsaxena@plexity.net - http://www.plexity.net

When law and duty are one, united by religion, you never become fully
conscious, fully aware of yourself. You are always a little less than
an individual. - Frank Herbert
