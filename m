Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291022AbSB0BCV>; Tue, 26 Feb 2002 20:02:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291020AbSB0BCL>; Tue, 26 Feb 2002 20:02:11 -0500
Received: from asooo.flowerfire.com ([63.254.226.247]:20419 "EHLO
	asooo.flowerfire.com") by vger.kernel.org with ESMTP
	id <S290797AbSB0BCE>; Tue, 26 Feb 2002 20:02:04 -0500
Date: Tue, 26 Feb 2002 19:01:49 -0600
From: Ken Brownfield <brownfld@irridia.com>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] ServerWorks autodma behavior
Message-ID: <20020226190149.B16048@asooo.flowerfire.com>
In-Reply-To: <20020226032629.A930@asooo.flowerfire.com> <3C7B6DAE.1090809@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3C7B6DAE.1090809@evision-ventures.com>; from dalecki@evision-ventures.com on Tue, Feb 26, 2002 at 12:12:46PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2002 at 12:12:46PM +0100, Martin Dalecki wrote:
| Ken Brownfield wrote:
[...]
| > In any case, I've appended the patch I'm using to be able to turn off
| > auto-DMA at config-time rather than run-time for ServerWorks.  One
| > alternative is to shed this code altogether, since ide-pci.c seems to
| > set a rational default.
| 
| I think (not 100% becouse not re-checked against the code),
| you could just have removed the lines
| 
| if (!noautodma)
| 	hwif->autodma = 1;
| 
| and all should be well ;-).

Yes, and that's what I found as well.  That was my first patch until I
noticed the AUTO check in the VIA driver around this same code.

That being said, which of these solutions is worthy of going into the
kernel (if any) and should that decision be applied to the other IDE
drivers?

I feel like I'm okay with my own little patchbase, but this seems like a
useful type of change to make for everyone and all drivers in 2.4 (and
2.5 if it's even still applicable).  And it's just dirt simple enough
for me to do it. ;)

Thanks,
-- 
Ken.
brownfld@irridia.com

