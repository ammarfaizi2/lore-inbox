Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263285AbTC0Qt2>; Thu, 27 Mar 2003 11:49:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263297AbTC0Qt1>; Thu, 27 Mar 2003 11:49:27 -0500
Received: from tapu.f00f.org ([202.49.232.129]:60891 "EHLO tapu.f00f.org")
	by vger.kernel.org with ESMTP id <S263285AbTC0Qt0>;
	Thu, 27 Mar 2003 11:49:26 -0500
Date: Thu, 27 Mar 2003 09:00:39 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Larry McVoy <lm@work.bitmover.com>, linux-kernel@vger.kernel.org
Subject: Re: ECC error in 2.5.64 + some patches
Message-ID: <20030327170039.GA26452@f00f.org>
References: <20030324212813.GA6310@osiris.silug.org> <20030324180107.A14746@vger.timpanogas.org> <20030324234410.GB10520@work.bitmover.com> <20030324182508.A15039@vger.timpanogas.org> <20030327160220.GA29195@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030327160220.GA29195@work.bitmover.com>
User-Agent: Mutt/1.3.28i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 27, 2003 at 08:02:20AM -0800, Larry McVoy wrote:

> My guess is that this means there was a memory error and ECC fixed
> it.

Nope.

There is an ecc driver for RAM and you'll be able to detect these
using that.  RAM ECC errors in my experience don't cause MCEs, usually
the CPU never notices.

> The only problem is that I'm reasonably sure that there isn't ECC on
> these DIMMs.

Dump the SPD and you can check...  usually the BIOS will tell you too.

> Does anyone have the table of error codes to explanations?  Google
> didn't find anything for this one.

as someone else pointed our, parsemce is what you want

> Message from syslogd@slovax at Thu Mar 27 05:53:49 2003 ...
> slovax kernel: Bank 1: 9000000000000151

Status: (9000000000000151) Restart IP valid.

*Exactly* what this means I don't know --- but I'm guessing the CPU is
overheating.  Check fans, air-flow, etc. and see if that helps.  So
far whenever I've seen the above problem it's *ALWAYS* been related to
the CPU getting too hot.


  --cw
