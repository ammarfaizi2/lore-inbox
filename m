Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265506AbTA2JG4>; Wed, 29 Jan 2003 04:06:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265513AbTA2JG4>; Wed, 29 Jan 2003 04:06:56 -0500
Received: from postoffice.erunway.com ([12.40.51.200]:51469 "EHLO
	mailserver.virtusa.com") by vger.kernel.org with ESMTP
	id <S265506AbTA2JGz>; Wed, 29 Jan 2003 04:06:55 -0500
Date: Wed, 29 Jan 2003 15:16:08 +0600
From: Anuradha Ratnaweera <ARatnaweera@virtusa.com>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Where are the matroxfb updates?
Message-ID: <20030129091608.GA549@aratnaweera.virtusa.com>
References: <20030129020639.GA10213@aratnaweera.virtusa.com> <20030129053159.GA5999@platan.vc.cvut.cz> <20030129073629.GA26091@aratnaweera.virtusa.com> <20030129080420.GB4950@vana.vc.cvut.cz> <20030129082226.GA668@aratnaweera.virtusa.com> <20030129083752.GD4950@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030129083752.GD4950@vana.vc.cvut.cz>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 29, 2003 at 12:37:52AM -0800, Petr Vandrovec wrote:
>
> On Wed, Jan 29, 2003 at 02:22:26PM +0600, Anuradha Ratnaweera wrote:
> 
> > both monitors display the same screen.  /dev/fb1 gets registered, and
> > ttys get moved to it with con2fb, but not to any of the monitors.  Both
> > monitors still seem to act as /dev/fb0.  The moved tty no longer exist.
> 
> What about using matroxset to set things up?

Config.in patch applied.

  # ./matroxset -m 00001111
  # ioctl failed: Device or resource busy

Have tried other variations, too.

  # ls /proc/drivers/mga/
  fb0
  # cat /proc/drivers/mga/fb0/bios
  BIOS:   1.2.21
  Output: 0x00
  TVOut:  no
  PINS:   found
  Info:   c02a0a8c

Howerver, fb1 gets registered (yes as the secondary head of fb0).

  # dmesg | grep matrox
  Kernel command line: BOOT_IMAGE=linux ro root=306 video=matrox:vesa:0x192,font:SUN12x22,nopan
  matroxfb: Matrox G450 detected
  matroxfb: MTRR's turned on
  matroxfb: 1152x864x16bpp (virtual: 1152x864)
  matroxfb: framebuffer at 0x42000000, mapped to 0xe0805000, size 33554432
  matroxfb_crtc2: secondary head of fb0 was registered as fb1

	Anuradha

-- 

Debian GNU/Linux (kernel 2.4.21-pre4)

Adore, v.:
	To venerate expectantly.
		-- Ambrose Bierce, "The Devil's Dictionary"

