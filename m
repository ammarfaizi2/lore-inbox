Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263574AbTJQR5a (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 13:57:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263577AbTJQR53
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 13:57:29 -0400
Received: from bgp01360964bgs.sandia01.nm.comcast.net ([68.35.68.128]:15232
	"EHLO orion.dwf.com") by vger.kernel.org with ESMTP id S263574AbTJQR5Z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 13:57:25 -0400
Message-Id: <200310171757.h9HHvGiY006997@orion.dwf.com>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4
To: linux-hotplug-devel@lists.sourceforge.net, greg@kroah.com
cc: linux-kernel@vger.kernel.org, reg@orion.dwf.com
From: clemens@dwf.com
Subject: Re: [ANNOUNCE] udev 003 release 
In-Reply-To: Message from Greg KH <greg@kroah.com> 
   of "Thu, 16 Oct 2003 22:56:52 PDT." <20031017055652.GA7712@kroah.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 17 Oct 2003 11:57:16 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The new udev is nice, and it 'works', but Im still having two problems:
    (1) Although the messages file shows that it is reading my 
        /etc/udev/namedev.config file, the entries are being ignored.
        Ive tried both:
	    LABEL, BUS="usb", serial="0B0201420527B284", NAME="usb_disk"
        and
            LABEL, BUS="usb", vendor="DMI", NAME="usb_disk"

        and all I get are /udev/ sda, sdb, sdc, sdd, ... as I plug and unplug.

    (2) This worked in -0.2, but not -0.3:  When a device is created in
        /udev, I now get just /udev/sda .  Previously (0.2) I got both
        sda and sda1 .  Needless to say, a mount attempt on /udev/sda1
        now fails.  [[ and if I tell it NAME="usb_disk" what should I
        expect for the name of the first partition???

Am I missing something???
-- 
                                        Reg.Clemens
                                        reg@dwf.com


