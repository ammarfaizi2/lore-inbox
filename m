Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265132AbUABKkM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 05:40:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265499AbUABKkM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 05:40:12 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:53947 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S265132AbUABKkH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 05:40:07 -0500
Date: Fri, 2 Jan 2004 11:39:49 +0100
From: Jens Axboe <axboe@suse.de>
To: Jeff Chua <jeffchua@silk.corp.fedex.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: GetASF failed on DVD authentication
Message-ID: <20040102103949.GL5523@suse.de>
References: <Pine.LNX.4.58.0401021616580.4954@boston.corp.fedex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0401021616580.4954@boston.corp.fedex.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 02 2004, Jeff Chua wrote:
> 
> Got the following error while authenticating DVD ...
> 
> GetASF failed
> N/A, invalidating: Function not implemented
> N/A, invalidating: Function not implemented
> N/A, invalidating: Function not implemented
> Request AGID [1]...     Request AGID [2]...     Request AGID [3]...
> Cannot get AGID
> 
> 
> This error happens only on USB DVD drive using /dev/scd0 ...
> 
> Linux version is 2.4.24-pre3.
> 
> 
> Module                  Size  Used by    Tainted: P
> ehci-hcd               15368   0  (unused)
> usb-storage            23800   0
> usbcore                56672   1  [ehci-hcd usb-storage]
> ds                      6504   2
> yenta_socket            9568   2
> isofs                  17580   0  (autoclean)
> loop                    8408   0  (autoclean)
> sr_mod                 12560   0  (autoclean)
> cdrom                  27296   0  (autoclean) [sr_mod]
> scsi_mod               86472   2  (autoclean) [usb-storage sr_mod]
> 
> 
> 
> Problem does not happen on _real_ IDE DVD drive (/dev/hdc). Could it be
> something to do with usb-storage or the sg module? Looks like the code
> does not implement the DVD_LU_SEND_ASF DVD_AUTH ioctl?

sr passes those ioctls through, or rather the uniform layer handles
them.

I can't say what goes wrong from the info above. Do you get any kernel
messages?

> Is there a patch for this?

Good one ;) Please make a proper bug report, you don't even include
drive info.

-- 
Jens Axboe

