Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313533AbSDEUrt>; Fri, 5 Apr 2002 15:47:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313534AbSDEUrk>; Fri, 5 Apr 2002 15:47:40 -0500
Received: from ip68-7-112-74.sd.sd.cox.net ([68.7.112.74]:2575 "EHLO
	clpanic.kennet.coplanar.net") by vger.kernel.org with ESMTP
	id <S313533AbSDEUr1>; Fri, 5 Apr 2002 15:47:27 -0500
Message-ID: <00c501c1dce3$0ed806d0$7e0aa8c0@bridge>
From: "Jeremy Jackson" <jerj@coplanar.net>
To: "Martin J. Bligh" <fletch@aracnet.com>, <linux-kernel@vger.kernel.org>
In-Reply-To: <1650399759.1018005181@[10.10.2.3]>
Subject: Re: Faster reboots (and a better way of taking crashdumps?)
Date: Fri, 5 Apr 2002 12:47:08 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

for 2, the BIOS sets the hardware to a known state,
or if you can trigger *the* hardware reset line,
which will also do that, then you're going through
the BIOS again.  Now if you made your own bios...
see www.linuxbios.org.

there are patches where a kernel can load another
kernel, also.

As for taking crashdumps on the way up, I believe
(SGI's ?) linux kernel crash dumps does *exactly*
this.

Jeremy

----- Original Message -----
From: "Martin J. Bligh" <fletch@aracnet.com>
To: <linux-kernel@vger.kernel.org>
Sent: Friday, April 05, 2002 11:13 AM
Subject: Faster reboots (and a better way of taking crashdumps?)


> My real motivation for this isn't actually faster reboots,
> it's rebooting at all - I have some strange hardware that
> won't do init 6 in traditional ways ... but it might mean
> a faster reboot for others.
>
> What's to stop me rebooting by having machine_restart load
> the first sector of the first disk (as the BIOS does), where
> the LILO code should be, and just jumping to it?
>
> 1. Are there tables that are created by the BIOS that we
> destroy during Linux runtime? mps tables spring to mind -
> I can't see where we preserve them ...
>
> 2. Things that are reset by reboot that we don't reset during
> normal kernel boot?
>
> As a side effect, this means we could potentially take
> crashdumps on the way up, rather than the way down, so
> the kernel is more likely to be in a working state (we'd
> have to load a minimal kernel / crashdumper to take the
> dump first ... this is similar to what we did with PTX).
>
> M.
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

