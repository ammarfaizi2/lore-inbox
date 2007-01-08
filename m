Return-Path: <linux-kernel-owner+w=401wt.eu-S1030501AbXAHTLa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030501AbXAHTLa (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 14:11:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030499AbXAHTL3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 14:11:29 -0500
Received: from smtp-101-monday.nerim.net ([62.4.16.101]:4793 "EHLO
	kraid.nerim.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1030503AbXAHTL3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 14:11:29 -0500
Date: Mon, 8 Jan 2007 20:11:30 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Sylvain Munaut <tnt@246tNt.com>, Greg KH <gregkh@suse.de>
Cc: Mariusz Kozlowski <m.kozlowski@tuxland.pl>,
       Linus Torvalds <torvalds@osdl.org>, linuxppc-dev@ozlabs.org,
       paulus@samba.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.20-rc4
Message-Id: <20070108201130.46755bb9.khali@linux-fr.org>
In-Reply-To: <45A25C17.5070606@246tNt.com>
References: <Pine.LNX.4.64.0701062216210.3661@woody.osdl.org>
	<200701081550.27748.m.kozlowski@tuxland.pl>
	<45A25C17.5070606@246tNt.com>
X-Mailer: Sylpheed version 2.2.10 (GTK+ 2.8.20; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sylvain,

On Mon, 08 Jan 2007 15:58:31 +0100, Sylvain Munaut wrote:
> Mariusz Kozlowski wrote:
> > Hello,
> >
> > Doesn't build on iMac G3 machine. Relevant info attached.
> >
> > In file included from drivers/usb/host/ohci-hcd.c:893:
> > drivers/usb/host/ohci-ppc-soc.c:225: error: redefinition of '__inittest'
> > drivers/usb/host/ohci-pci.c:252: error: previous definition of '__inittest' was here
> > drivers/usb/host/ohci-ppc-soc.c:225: error: redefinition of 'init_module'
> > drivers/usb/host/ohci-pci.c:252: error: previous definition of 'init_module' was here
> > drivers/usb/host/ohci-ppc-soc.c:226: error: redefinition of '__exittest'
> > drivers/usb/host/ohci-pci.c:260: error: previous definition of '__exittest' was here
> > drivers/usb/host/ohci-ppc-soc.c:226: error: redefinition of 'cleanup_module'
> > drivers/usb/host/ohci-pci.c:260: error: previous definition of 'cleanup_module' was here
> > make[3]: *** [drivers/usb/host/ohci-hcd.o] Blad 1
> > make[2]: *** [drivers/usb/host] Blad 2
> > make[1]: *** [drivers/usb] Blad 2
> > make: *** [drivers] Blad 2
>
> Don't build ohci as module for now.
> A fix for that is already in gregkh usb tree for 2.6.21

We shouldn't have to wait for 2.6.21 to fix a known compilation
breakage. Greg, can you please push the fix to Linus quickly?

Thanks,
-- 
Jean Delvare
