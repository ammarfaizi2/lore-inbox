Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265626AbRFWFEd>; Sat, 23 Jun 2001 01:04:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265631AbRFWFEX>; Sat, 23 Jun 2001 01:04:23 -0400
Received: from aslan.scsiguy.com ([63.229.232.106]:38666 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S265626AbRFWFET>; Sat, 23 Jun 2001 01:04:19 -0400
Message-Id: <200106230504.f5N54AU84337@aslan.scsiguy.com>
To: stimits@idcomm.com
cc: linux-kernel@vger.kernel.org
Subject: Re: Cleanup kbuild for aic7xxx 
In-Reply-To: Your message of "Fri, 22 Jun 2001 22:17:12 MDT."
             <3B341848.1EF6DA3B@idcomm.com> 
Date: Fri, 22 Jun 2001 23:04:10 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> >Users don't have to manually select "rebuild firmware".  They can
>> >rely on the generated files already in the aic7xxx directory.  This
>> >is why the option defaults to off.
>
>For the SGI patched kernels based on either 2.4.5 or 2.4.6-pre1, I have
>had to manually select this for a 7892 controller. Without manually
>selecting it, it guarantees boot failure. I don't know if this is due to
>the SGI modifications or not. The real problem I found is that during
>boot failure, there was no meaningful debug message.

I don't know why your kernel source is out of sync.  I will have to
go pull down the 2.4.5 and 2.4.6 trees and see if some portion of
my patches never made it into those trees.  It also looks like the
comment section for this option didn't make it into my 2.4.4 and above
patches.  I'll correct this on this on Monday.  Here's the relevent
info.  Do you have any comments on what would make it more useful?

+Build Adapter Firmware with Kernel Build
+CONFIG_AIC7XXX_BUILD_FIRMWARE
+  This option should only be enabled if you are modifying the
+  firmware source to the aic7xxx driver and wish to have the
+  generated firmware include files updated during a normal
+  kernel build.  The assmebler for the firmware requires
+  lex and yacc or their equivalents, as well as the db v1
+  library.  You may have to install additional packages or
+  modify the assmebler make file or the files it includes
+  if your build environment is different than that of the
+  author.


>Missing firmware rebuild is fatal for my system, SMP x86 with integrated
>7892. Messages and config menu information is inadequate, it requires a
>bit of pounding the head on the wall to figure it out.

It is hard to make the kernel driver give a reasonable message for every
possible error that running with incompatible components may cause.

--
Justin
