Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265648AbRFWFkT>; Sat, 23 Jun 2001 01:40:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265646AbRFWFj7>; Sat, 23 Jun 2001 01:39:59 -0400
Received: from mailhost.idcomm.com ([207.40.196.14]:18361 "EHLO
	mailhost.idcomm.com") by vger.kernel.org with ESMTP
	id <S265645AbRFWFjy>; Sat, 23 Jun 2001 01:39:54 -0400
Message-ID: <3B342C08.941D5F46@idcomm.com>
Date: Fri, 22 Jun 2001 23:41:28 -0600
From: "D. Stimits" <stimits@idcomm.com>
Reply-To: stimits@idcomm.com
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-pre1-xfs-4 i686)
X-Accept-Language: en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: Re: Cleanup kbuild for aic7xxx
In-Reply-To: <200106230504.f5N54AU84337@aslan.scsiguy.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Justin T. Gibbs" wrote:
> 
> >> >Users don't have to manually select "rebuild firmware".  They can
> >> >rely on the generated files already in the aic7xxx directory.  This
> >> >is why the option defaults to off.
> >
> >For the SGI patched kernels based on either 2.4.5 or 2.4.6-pre1, I have
> >had to manually select this for a 7892 controller. Without manually
> >selecting it, it guarantees boot failure. I don't know if this is due to
> >the SGI modifications or not. The real problem I found is that during
> >boot failure, there was no meaningful debug message.
> 
> I don't know why your kernel source is out of sync.  I will have to
> go pull down the 2.4.5 and 2.4.6 trees and see if some portion of
> my patches never made it into those trees.  It also looks like the
> comment section for this option didn't make it into my 2.4.4 and above
> patches.  I'll correct this on this on Monday.  Here's the relevent
> info.  Do you have any comments on what would make it more useful?
> 
> +Build Adapter Firmware with Kernel Build
> +CONFIG_AIC7XXX_BUILD_FIRMWARE
> +  This option should only be enabled if you are modifying the
> +  firmware source to the aic7xxx driver and wish to have the
> +  generated firmware include files updated during a normal
> +  kernel build.  The assmebler for the firmware requires
> +  lex and yacc or their equivalents, as well as the db v1
> +  library.  You may have to install additional packages or
> +  modify the assmebler make file or the files it includes
> +  if your build environment is different than that of the
> +  author.

I would add a note to try without it at first, but if bootup starts
normally, then hangs in what seems like a controller or filesystem
failure of a scsi drive, try to enable the option.

(this would give some hint about debugging an aic7xxx failure,
regardless of error messages)

D. Stimits, stimits@idcomm.com

> 
> >Missing firmware rebuild is fatal for my system, SMP x86 with integrated
> >7892. Messages and config menu information is inadequate, it requires a
> >bit of pounding the head on the wall to figure it out.
> 
> It is hard to make the kernel driver give a reasonable message for every
> possible error that running with incompatible components may cause.
> 
> --
> Justin
