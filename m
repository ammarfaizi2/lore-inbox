Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271682AbRHUODq>; Tue, 21 Aug 2001 10:03:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271681AbRHUODg>; Tue, 21 Aug 2001 10:03:36 -0400
Received: from age.cs.columbia.edu ([128.59.22.100]:38411 "EHLO
	age.cs.columbia.edu") by vger.kernel.org with ESMTP
	id <S271677AbRHUODZ>; Tue, 21 Aug 2001 10:03:25 -0400
Date: Tue, 21 Aug 2001 10:03:20 -0400 (EDT)
From: Ion Badulescu <ionut@cs.columbia.edu>
To: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] allow hdX=scsi when ide-scsi is a module
In-Reply-To: <200108202214.AAA09066@green.mif.pg.gda.pl>
Message-ID: <Pine.LNX.4.33.0108211000520.14783-100000@age.cs.columbia.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Aug 2001, Andrzej Krzysztofowicz wrote:

> Even worse.
> As the following legal steps:
> 
> CONFIG_BLK_DEV_IDESCSI=y
> CONFIG_SCSI=y
>     |
>     V
> make config
>     |
>     V
>   SCSI emulation support (CONFIG_BLK_DEV_IDESCSI) [Y/m/n/?] y
>   ...
>   SCSI support (CONFIG_SCSI) [Y/m/n/?] m
>     |
>     V
> CONFIG_BLK_DEV_IDESCSI=y
> CONFIG_SCSI=m
> 
> result in an invalid configuration.

Right. Unfortunately there isn't much we can do about it, other that what 
you proposed. Hopefully CML2 in 2.5 will fix this problem.

> So I suggest also the following change:
[...]

Makes sense. Alan, can you apply both patches?

Thanks,
Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.

