Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273976AbRI0WTv>; Thu, 27 Sep 2001 18:19:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273977AbRI0WTl>; Thu, 27 Sep 2001 18:19:41 -0400
Received: from air-1.osdlab.org ([65.201.151.5]:58376 "EHLO
	osdlab.pdx.osdl.net") by vger.kernel.org with ESMTP
	id <S273976AbRI0WTi>; Thu, 27 Sep 2001 18:19:38 -0400
Message-ID: <3BB3A572.BF263906@osdlab.org>
Date: Thu, 27 Sep 2001 15:17:22 -0700
From: "Randy.Dunlap" <rddunlap@osdlab.org>
Organization: OSDL
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-20mdk i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alex Cruise <acruise@infowave.com>
CC: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: apm suspend broken in 2.4.10
In-Reply-To: <6B90F0170040D41192B100508BD68CA1015A81AE@earth.infowave.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Cruise wrote:
> 
> From: Randy.Dunlap [mailto:rddunlap@osdlab.org]
> 
> > Verified here.
> > APM doesn't install if apm=on or apm=off is used in 2.4.10.
> >
> > Here's a small patch for it.  With this patch, apm thread,
> > /proc/apm, misc apm_bios device etc. are created.
> 
> Thanks... apm=on works now, but APM functionality itself still suffers from
> the same failure as before (Resource temporarily unavailble.)
> 
> I should mention that before your patch, /dev/misc/apm_bios, /dev/apm_bios
> and /proc/apm were already being created by the driver; it's going through
> the motions but not delivering the goods.
> 
> -0xe1a

{little-endian n[iy]bbles ?}


Sounds like our 2.4.10's are different then.  :)
Without this patch, mine didn't create /proc/apm, register as a
misc device, or create the kapmd-idle kernel thread.
Must be a distro thingy.

Return of EAGAIN from the SUSPEND ioctl means that
send_event() failed, which means that some device driver
didn't want suspend to happen...which means that some
device driver got changed. :(

What was the last working kernel AFAUK (for this APM stuff)?

~Randy
