Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264035AbSIVKhr>; Sun, 22 Sep 2002 06:37:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264036AbSIVKhr>; Sun, 22 Sep 2002 06:37:47 -0400
Received: from mail.zmailer.org ([62.240.94.4]:8077 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id <S264035AbSIVKhp>;
	Sun, 22 Sep 2002 06:37:45 -0400
Date: Sun, 22 Sep 2002 13:42:52 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: walairat kladmuk <praduddao@hotmail.com>
Cc: linux-kernel@vger.kernel.org, dominicscaife@yahoo.com
Subject: Re: Kernel Issues
Message-ID: <20020922104252.GH30392@mea-ext.zmailer.org>
References: <F138D7O5CkJNQNXSqVd00002250@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F138D7O5CkJNQNXSqVd00002250@hotmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 22, 2002 at 09:42:21AM +0000, walairat kladmuk wrote:
> I have a problem installing Mandrake 8.2.
> 
> Installation appears to work fine but when I try and boot the system the 
> following is a copy of the kernel messages as boot fails (last 8 lines)
> 
> PCI <something>
> PCI <something>
> PCI <something>
> PCI <something>
> Isapnp: Scanning for PnP Cards
> CPU0: Machine Check Exception: 00000000000000000007
> Bank 3: b40000000000000000000083b at 0000000000000001fc0003b3
> Kernel Panic: Unable to continue

  This is reporting memory problems.  However you should not
  have 4 banks of memory...   Possibly your single memory module
  is at Bank-1 when it should be at Bank-0 connector ?
  (That should manifest a lot earlier, though..)

  If the MCE code is broken (it is possible) at your hardware,
  try booting with boot-line option "nomce".

  Or perhaps you are running with kernel optimized for intel
  Pentum-III+ and some deep detail disagrees with AMD Athlon XP ?

  The installation boot kernels are very "unadvanced", 386, or such.
  The installed kernel tries to be as advanced as the system allows.

  I haven't had a need to guide the installation to use some other
  kernel, than its own internal default,  however you might want
  to try to get it to install a 486 or 586 kernel.

  Then, latter, install an alternate kernel optimized for Athlon XP,
  and select it manually during the boot.

> Having played around with numerous installation techniques (full/min, 
> various partition configs/types) over the last 4 days I haven't made any 
> progress.
> 
> I even tried Red Hat 7.3 (Valhalla) and the same happened.
> 
> I built the system last week.
> Here is an outline of my system:
> 
> Motherboard:
> http://www.octek.com.hk/products/ATI/ati13xp-mse.htm
> 
> CPU:
> AMD Athlon 1.6 XP
> 
> RAM:
> 256MB 266 DDR one module (1 free)
> 
> HD:
> Seagate 40MB
> 
> CDROM:
> LG DVD Drive
> 
> No PCI Cards mounted or AGP cards.
> 
> Sound and Video is onboard, see http above for details.
...
> Can anyone offer me a little advice here?  Is there any way to do it 
> without having to recompile the kernel? (Not done this before relatively 
> new to Linux, though I have plenty of time to burn :)
> 
> D Scaife
> dominicscaife@yahoo.com (yahoo only sends html style mail which list sees 
> as spam hence the reason this comes from elsewhere)

    That is odd..  MSN also sends HTML as default, but can be
    configured not to do so.    Odd if Yahoo does not give
    option to control that...  At the bottom of "Compose"
    page there is some "HTML" related control.  Make sure that
    one is off.

> p.s. Also played with the System.map and tried deleting all those lines 
> beginning with isapnp... no luck... these are shots in the dark :)ut 
> feeling is that given the error message the boot fails when looking for an 
> ISApnp card... my motherboard is very new (see profile) and doesn't have an 
> ISA slot.

    The "Config" and "System.map" files relate to the kernel you are
    using, and are produced during its compilation.  Editing them
    afterwards won't affect a thing -- except harm certain parts of
    kernel error reporting support at klogd.

/Matti Aarnio
