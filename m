Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274314AbRITFlq>; Thu, 20 Sep 2001 01:41:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274316AbRITFlh>; Thu, 20 Sep 2001 01:41:37 -0400
Received: from smtp.linuxsecurity.com ([209.11.107.5]:13836 "HELO
	juggernaut.guardiandigital.com") by vger.kernel.org with SMTP
	id <S274314AbRITFlU>; Thu, 20 Sep 2001 01:41:20 -0400
Date: Thu, 20 Sep 2001 01:41:24 -0400 (EDT)
From: "Ryan W. Maple" <ryan@guardiandigital.com>
To: David Brownell <david-b@pacbell.net>
Cc: Greg KH <greg@kroah.com>, linux-hotplug-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
        Linux-usb-users@lists.sourceforge.net
Subject: Re: 2001-09-19 release of hotplug scripts
In-Reply-To: <005b01c1418e$b08433a0$6800000a@brownell.org>
X-Base: ALL YOUR BASE ARE BELONG TO US. (http://www.scene.org/redhound/AYB.swf)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Message-Id: <20010920054137.C03E011D304@juggernaut.guardiandigital.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 19 Sep 2001, David Brownell wrote:

> > Here's the full changelog:
> > - Added ieee1394.agent from Kristian Hogsberg
> >   <hogsberg@users.sourceforge.net>
> > - with docs, "sh -x" debug support, minor fix.  Needs kernel
> >   2.4.10 and modutils 2.4.9 to hotplug.
> 
> To clarify, the ieee1394 support is what needs software that's
> as-yet not quite released.  Other hotplugging (USB, PCI, network)
> still works just fine with 2.4.0 (and, for USB, 2.2.current).  The
> release is not (as one person suspected :) Science Fiction!

Actually, it appears that the option to enable CONFIG_HOTPLUG was taken
out in 2.2.19, and is not in any of the 2.2.20-pre's.  I emailed Greg K-H
about this earlier this week.

I enabled it and it's "working for me" with hotplug-2001_04_24.  One-liner
follows:

--- linux-2.2.19/drivers/usb/Config.in  Sun Mar 25 11:37:37 2001
+++ linux-2.2.18/drivers/usb/Config.in  Sun Dec 10 19:49:43 2000
@@ -10,6 +10,7 @@
 
 comment 'Miscellaneous USB options'
    bool '  Preliminary USB device filesystem' CONFIG_USB_DEVICEFS
+   bool '  Support for hot-pluggable USB devices' CONFIG_HOTPLUG
    if [ "$CONFIG_EXPERIMENTAL" = "y" ]; then
       bool '  Enforce USB bandwidth allocation (EXPERIMENTAL)' CONFIG_USB_BANDWIDTH
    else

Cheers,
Ryan

 +-- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --+
   Ryan W. Maple          "I dunno, I dream in Perl sometimes..."  -LW
   Guardian Digital, Inc.                     ryan@guardiandigital.com
 +-- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --+

