Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286263AbSA3BDd>; Tue, 29 Jan 2002 20:03:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287798AbSA3BDY>; Tue, 29 Jan 2002 20:03:24 -0500
Received: from ns.suse.de ([213.95.15.193]:27403 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S286263AbSA3BDN>;
	Tue, 29 Jan 2002 20:03:13 -0500
Date: Wed, 30 Jan 2002 02:03:12 +0100
From: Dave Jones <davej@suse.de>
To: Greg KH <greg@kroah.com>
Cc: mochel@osdl.org, linux-usb-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] driverfs support for USB - take 2
Message-ID: <20020130020312.C16379@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Greg KH <greg@kroah.com>, mochel@osdl.org,
	linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <20020130002418.GB21784@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020130002418.GB21784@kroah.com>; from greg@kroah.com on Tue, Jan 29, 2002 at 04:24:18PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2002 at 04:24:18PM -0800, Greg KH wrote:
 > Hi,
 > 
 > Well after determining that the last version of this patch doesn't show
 > the USB tree properly, here's another patch against 2.5.3-pre6 that
 > fixes this issue.
 > 
 > With this patch (the driver core changes were from Pat Mochel, thanks
 > Pat for putting up with my endless questions) my machine now shows the
 > following tree:

 Looks good, now when the PM bits can power down from the leaves,
 and turn off USB devices /before/ the USB controller and PCI bridges,
 which sounds much more sensible.

 > Yes, I need to have better names for the devices than just "usb_bus",
 > any suggestions?  These devices nodes are really the USB root hubs in
 > the USB controller, so they could just have the USB number as the name
 > like the other USB devices (001), but that's pretty boring :)

 "usb_root0" .. "usb_rootN" ?

 btw, a script to marry the busid's from driverfs to lspci/lsusb
 output may be useful in the future especially if combined somehow
 with tree(1). Could be very handy when it gets time to debug
 those "My system won't suspend to disk" "What does /driver look like?"
 situations.


-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
