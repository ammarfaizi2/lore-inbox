Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129740AbRBYARC>; Sat, 24 Feb 2001 19:17:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129744AbRBYAQx>; Sat, 24 Feb 2001 19:16:53 -0500
Received: from ns.suse.de ([213.95.15.193]:26126 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S129740AbRBYAQn>;
	Sat, 24 Feb 2001 19:16:43 -0500
Date: Sun, 25 Feb 2001 01:16:40 +0100
From: Andi Kleen <ak@suse.de>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: New net features for added performance
Message-ID: <20010225011640.A23953@gruyere.muc.suse.de>
In-Reply-To: <3A9842DC.B42ECD7A@mandrakesoft.com> <oupsnl3k5gs.fsf@pigdrop.muc.suse.de> <3A984BDA.190B4D8E@mandrakesoft.com> <3A984E1A.DF67E730@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A984E1A.DF67E730@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Sat, Feb 24, 2001 at 07:13:14PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 24, 2001 at 07:13:14PM -0500, Jeff Garzik wrote:
> Sorry... I should also point out that I was thinking of tulip
> architecture and similar architectures, where you have a fixed number of
> Skbs allocated at all times, and that number doesn't change for the
> lifetime of the driver.
> 
> Clearly not all cases would benefit from skb recycling, but there are a
> number of rx-ring-based systems where this would be useful, and (AFAICS)
> reduce the work needed to be done by the system, and reduce the amount
> of overall DMA traffic by a bit.

A simple way to do it currently is just to compare the new skb with the old
one. If it is the same, do a shortcut. That should usually work out when the
system has enough memory.


-Andi
