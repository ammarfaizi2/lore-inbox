Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266086AbUFDXWM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266086AbUFDXWM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 19:22:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266070AbUFDXTl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 19:19:41 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:6041 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264428AbUFDXPD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 19:15:03 -0400
Date: Sat, 5 Jun 2004 00:14:56 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: linux-kernel@vger.kernel.org
Cc: perex@suse.cz, torvalds@osdl.org
Subject: Re: [RFC] ASLA design, depth of code review and lack thereof
Message-ID: <20040604231456.GS12308@parcelfarce.linux.theplanet.co.uk>
References: <20040604230819.GR12308@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040604230819.GR12308@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 05, 2004 at 12:08:19AM +0100, viro@parcelfarce.linux.theplanet.co.uk wrote:
> Ladies and gentlemen, may I politely ask what description would fit somebody
> who have made the following
> 
>         case SNDRV_PCM_FORMAT_FLOAT_BE:
>         {
>                 union {
>                         float f;
>                         u_int32_t i;
>                 } u;
>                 u.f = 0.0;
> #ifdef SNDRV_LITTLE_ENDIAN
>                 return bswap_32(u.i);
> #else
>                 return u.i;
> #endif
>         }
> and quite a few similar, er, wonders an ioctl?

... immediately followed by a self-LART - it's still an ugly code, all
right, but that's not an ioctl.

My apologies to everyone.
