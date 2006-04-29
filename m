Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750859AbWD2JEa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750859AbWD2JEa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Apr 2006 05:04:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750864AbWD2JEa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Apr 2006 05:04:30 -0400
Received: from holly.csn.ul.ie ([193.1.99.76]:4513 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S1750844AbWD2JEa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Apr 2006 05:04:30 -0400
Date: Sat, 29 Apr 2006 10:04:25 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet.skynet.ie
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: Andrew Morton <akpm@osdl.org>, greg@kroah.com,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       pjones@redhat.com
Subject: Re: Add a "enable" sysfs attribute to the pci devices to allow
 userspace (Xorg) to enable devices without doing foul direct access
In-Reply-To: <1146301148.3125.7.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.64.0604291001490.2080@skynet.skynet.ie>
References: <1146300385.3125.3.camel@laptopd505.fenrus.org> 
 <20060429015116.2c3d964b.akpm@osdl.org> <1146301148.3125.7.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> This patch adds an "enable" sysfs attribute to each PCI device. When read it
> shows the "enabled-ness" of the device, but you can write a "0" into it to
> disable a device, and a "1" to enable it.
>
> This later is needed for X and other cases where userspace wants to enable
> the BARs on a device (typical example: to run the video bios on a secundary
> head). Right now X does all this "by hand" via bitbanging, that's just evil.
> This allows X to no longer do that but to just let the kernel do this.
>
> Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
> CC: Peter Jones <pjones@redhat.com>
> CC: Dave Airlie <airlied@linux.ie>

ACK

This would allow me to remove the issue in X where loading the DRM at X 
startup acts differently than loading the DRM before X runs, due to Xs PCI 
probe running in-between... with this I can just enable all VGA devices 
and no worry whether they have a DRM or not..

Dave.

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
Linux kernel - DRI, VAX / pam_smb / ILUG

