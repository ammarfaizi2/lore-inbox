Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293510AbSCYCl1>; Sun, 24 Mar 2002 21:41:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311317AbSCYClU>; Sun, 24 Mar 2002 21:41:20 -0500
Received: from [209.250.58.45] ([209.250.58.45]:15118 "EHLO
	hapablap.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S293510AbSCYCk6>; Sun, 24 Mar 2002 21:40:58 -0500
Date: Sun, 24 Mar 2002 20:40:27 -0600
From: Steven Walter <srwalter@yahoo.com>
To: Andre Pang <ozone@algorithm.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Screen corruption in 2.4.18
Message-ID: <20020325024027.GA23315@hapablap.dyn.dhs.org>
Mail-Followup-To: Steven Walter <srwalter@yahoo.com>,
	Andre Pang <ozone@algorithm.com.au>, linux-kernel@vger.kernel.org
In-Reply-To: <200203192112.WAA09721@jagor.srce.hr> <20020323160647.GA22958@hapablap.dyn.dhs.org> <1016953516.189201.5912.nullmailer@bozar.algorithm.com.au> <200203241507.g2OF7WN26069@ls401.hinet.hr> <1017020598.420771.13343.nullmailer@bozar.algorithm.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-Uptime: 20:36:46 up 3 days, 19:34,  1 user,  load average: 1.96, 1.24, 1.05
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2002 at 12:43:18PM +1100, Andre Pang wrote:
> I've had a quick look at the pci-pc.c file which handles the PCI
> fixups, but I can't see of a way to say "if this chip is detected
> _and_ that chip is detected, modify this bit in the first chip."
> It's possible, but not without some real ugly hackery.
> 
> Assuming that _only_ the integrated KT133+KM133 chipset uses the
> VT8365 PCI ID (0x8305), it'd be easy to make a special-case patch
> for it.  My only worry is that other chipsets (like the 'normal'
> KT133 without the KM133) use the same PCI ID; we should avoid
> modifying the fix for the other chipsets, if possible.
> 
> Can somebody with a KT133/KT133A do a "lspci -n" and grep for
> '8305'?  If it doesn't appear, I'll send off my patch.

I fear this as well.  In fact, I'm relatively certain that they /do/
both use the same PCI ID.  Hence why lspci lists KT133/KM133.  But I
hope to big mistaken.  If not, the only way I can see of detecting that
it is a KM133 is by checking what device 01:00 is an S3 ProSavage.
Yuck.

Hopefully I'll here back from VIA with a definitive answer about when to
clear what bits, though.
-- 
-Steven
In a time of universal deceit, telling the truth is a revolutionary act.
			-- George Orwell
He's alive.  He's alive!  Oh, that fellow at RadioShack said I was mad!
Well, who's mad now?
			-- Montgomery C. Burns
