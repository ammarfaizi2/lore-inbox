Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280949AbRKTHoO>; Tue, 20 Nov 2001 02:44:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280950AbRKTHoF>; Tue, 20 Nov 2001 02:44:05 -0500
Received: from cx570538-a.elcjn1.sdca.home.com ([24.5.14.144]:1413 "EHLO
	keroon.dmz.dreampark.com") by vger.kernel.org with ESMTP
	id <S280949AbRKTHn4>; Tue, 20 Nov 2001 02:43:56 -0500
Message-ID: <3BFA09B3.20F31B78@randomlogic.com>
Date: Mon, 19 Nov 2001 23:43:47 -0800
From: "Paul G. Allen" <pgallen@randomlogic.com>
Organization: Akamai Technologies, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.7-ac10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Chris Wedgwood <cw@f00f.org>,
        "Linux kernel developer's mailing list" 
	<linux-kernel@vger.kernel.org>
Subject: Re: What Athlon chipset is most stable in Linux?
In-Reply-To: <20011113.183256.15406047.davem@redhat.com> <Pine.LNX.4.30.0111131910440.9658-100000@anime.net> <20011113.191607.00304518.davem@redhat.com> <3BF31459.BB4BE456@randomlogic.com> <20011116144835.A22537@weta.f00f.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wedgwood wrote:
> 
> On Wed, Nov 14, 2001 at 05:03:21PM -0800, Paul G. Allen wrote:
> 
>     I am running 2.4.9ac10 with a few minor tweaks, agpgart slightly
>     tweaked compiled in, and a tweaked Detonator 3 nVidia driver. I
>     plan to upgrade all these soon and see what happens.
> 
> Is this different from 1541? If so, where might I find this
> 

I just D/L, modified and compiled 1541. A cat of /proc/nv/card0 shows:

[root@keroon /root]# cat /proc/nv/card0 
----- Driver Info ----- 
NVRM Version: 1.0-1541
------ Card Info ------
Model:        GeForce3
IRQ:          17
Video BIOS:   03.20.00.10
------ AGP Info -------
AGP status:   Enabled
AGP Driver:   NVIDIA
Bridge:       AMD Irongate MP
SBA:          Supported [enabled]
FW:           Supported [disabled]
Rates:        4x 2x 1x  [4x]
Registers:    0x0f000217:0x00000304
[root@keroon /root]# 

So, AGP 4x and Side Band Addressing is enabled, but for some reason Fast
Writes are not. I am still using the 2.06 Tyan BIOS (as shipped) and
need to upgrade to the latest (I've had trouble getting the BIOS file
from the Tyan web site). agpgart is not compiled into this kernel, so as
you can see it's using the NVIDIA driver instead. I e-mailed developer
support at nVidia to ask why FW is disabled even though it's supported
(it could very well be the BIOS).

I also installed thier GLX libraries.

PGA
-- 
Paul G. Allen
UNIX Admin II/Network Security
Akamai Technologies, Inc.
www.akamai.com
