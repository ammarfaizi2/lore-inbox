Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265436AbUABIkW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 03:40:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265437AbUABIkW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 03:40:22 -0500
Received: from mx13.sac.fedex.com ([199.81.197.53]:7182 "EHLO
	mx13.sac.fedex.com") by vger.kernel.org with ESMTP id S265436AbUABIkU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 03:40:20 -0500
Date: Fri, 2 Jan 2004 16:28:52 +0800 (SGT)
From: Jeff Chua <jeffchua@silk.corp.fedex.com>
X-X-Sender: root@boston.corp.fedex.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: GetASF failed on DVD authentication
Message-ID: <Pine.LNX.4.58.0401021616580.4954@boston.corp.fedex.com>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 01/02/2004
 04:40:17 PM,
	Serialize by Router on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 01/02/2004
 04:40:19 PM,
	Serialize complete at 01/02/2004 04:40:19 PM
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Got the following error while authenticating DVD ...

GetASF failed
N/A, invalidating: Function not implemented
N/A, invalidating: Function not implemented
N/A, invalidating: Function not implemented
Request AGID [1]...     Request AGID [2]...     Request AGID [3]...
Cannot get AGID


This error happens only on USB DVD drive using /dev/scd0 ...

Linux version is 2.4.24-pre3.


Module                  Size  Used by    Tainted: P
ehci-hcd               15368   0  (unused)
usb-storage            23800   0
usbcore                56672   1  [ehci-hcd usb-storage]
ds                      6504   2
yenta_socket            9568   2
isofs                  17580   0  (autoclean)
loop                    8408   0  (autoclean)
sr_mod                 12560   0  (autoclean)
cdrom                  27296   0  (autoclean) [sr_mod]
scsi_mod               86472   2  (autoclean) [usb-storage sr_mod]



Problem does not happen on _real_ IDE DVD drive (/dev/hdc). Could it be
something to do with usb-storage or the sg module? Looks like the code
does not implement the DVD_LU_SEND_ASF DVD_AUTH ioctl?

Is there a patch for this?

Thanks.
