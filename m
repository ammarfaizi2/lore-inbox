Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317468AbSHHLhf>; Thu, 8 Aug 2002 07:37:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317469AbSHHLhe>; Thu, 8 Aug 2002 07:37:34 -0400
Received: from ns.suse.de ([213.95.15.193]:17939 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S317468AbSHHLhe>;
	Thu, 8 Aug 2002 07:37:34 -0400
Date: Thu, 8 Aug 2002 13:41:13 +0200
From: Andi Kleen <ak@suse.de>
To: Harald Welte <laforge@gnumonks.org>
Cc: David Miller <davem@redhat.com>, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix HIPQUAD macro in kernel.h
Message-ID: <20020808134113.A2552@wotan.suse.de>
References: <20020808133112.E11828@sunbeam.de.gnumonks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020808133112.E11828@sunbeam.de.gnumonks.org>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 08, 2002 at 01:31:12PM +0200, Harald Welte wrote:
> Hi Dave!
> 
> Below is a fix for the HIPQUAD macro in kernel.h.  The macro is currently
> not endian-aware - it just assumes running on a little-endian machine.
> 
> If you don't like the #ifdefs in kernel.h, the macros could be moved into 
> include/linux/byteorder/.
> 
> Please apply, thanks

That change is wrong. IP address should be always in network order (=BE) 
while in kernel.

-Andi
