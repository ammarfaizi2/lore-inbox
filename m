Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264282AbTKZSES (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 13:04:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264283AbTKZSES
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 13:04:18 -0500
Received: from docsis106-17.menta.net ([62.57.106.17]:12698 "EHLO
	pau.newtral.org") by vger.kernel.org with ESMTP id S264282AbTKZSEM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 13:04:12 -0500
Date: Wed, 26 Nov 2003 19:04:10 +0100 (CET)
From: Pau Aliagas <linuxnow@newtral.org>
X-X-Sender: pau@pau.intranet.ct
To: lkml <linux-kernel@vger.kernel.org>
Subject: usb bluetooth adapter does not work with 2.6.0-test10-mm1
Message-ID: <Pine.LNX.4.44.0311261900370.5021-100000@pau.intranet.ct>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've been trying to get this gadget working for a long time now, with all 
the 2.6.0test kerenl to no success. It works with rh9 and fedora standard 
kernels, that is with 2.4.

I include the messages I get. Any help will be appreciated. I'm willing to 
test patches promptly to have it working:

# cat /var/log/messages
Nov 26 11:10:50 pau kernel: hub 2-0:1.0: new USB device on port 2, assigned address 2
Nov 26 11:10:50 pau /etc/hotplug/usb.agent: Bad USB agent invocation
Nov 26 11:10:53 pau /etc/hotplug/usb.agent: Setup bluetooth for USB product a12/1/525
Nov 26 11:10:53 pau kernel: usb 2-2: control timeout on ep0in
Nov 26 11:10:54 pau last message repeated 18 times
Nov 26 11:10:54 pau /etc/hotplug/usb.agent: Setup bluetooth for USB product a12/1/525
Nov 26 11:10:54 pau kernel: usb 2-2: control timeout on ep0in


# dmesg
hub 2-0:1.0: new USB device on port 2, assigned address 2
usb 2-2: control timeout on ep0in
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 2 rqt 128 rq 6 len 9 ret -110
usb 2-2: control timeout on ep0in
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 2 rqt 128 rq 6 len 9 ret -110
usb 2-2: control timeout on ep0in
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 2 rqt 128 rq 6 len 9 ret -110
usb 2-2: control timeout on ep0in
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 2 rqt 128 rq 6 len 9 ret -110
usb 2-2: control timeout on ep0in
usb 2-2: control timeout on ep0in
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 2 rqt 128 rq 6 len 193 ret -110
usb 2-2: control timeout on ep0in
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 2 rqt 128 rq 6 len 9 ret -110
usb 2-2: control timeout on ep0in
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 2 rqt 128 rq 6 len 193 ret -110
usb 2-2: control timeout on ep0in
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 2 rqt 128 rq 6 len 193 ret -110
usb 2-2: control timeout on ep0in
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 2 rqt 128 rq 6 len 18 ret -110
usb 2-2: control timeout on ep0in
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 2 rqt 128 rq 6 len 193 ret -110
usb 2-2: control timeout on ep0in
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 2 rqt 128 rq 6 len 193 ret -110
usb 2-2: control timeout on ep0in
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 2 rqt 128 rq 6 len 18 ret -110
usb 2-2: control timeout on ep0in
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 2 rqt 128 rq 6 len 9 ret -110
usb 2-2: control timeout on ep0in
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 2 rqt 128 rq 6 len 193 ret -110
usb 2-2: control timeout on ep0in
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 2 rqt 128 rq 6 len 9 ret -110
usb 2-2: control timeout on ep0in
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 2 rqt 128 rq 6 len 193 ret -110
usb 2-2: control timeout on ep0in
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 2 rqt 128 rq 6 len 9 ret -110
usb 2-2: control timeout on ep0in
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 2 rqt 128 rq 6 len 9 ret -110
usb 2-2: control timeout on ep0in
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 2 rqt 128 rq 6 len 9 ret -110
usb 2-2: control timeout on ep0in
usb 2-2: control timeout on ep0in
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 2 rqt 128 rq 6 len 193 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 2 rqt 128 rq 6 len 18 ret -110
usbfs: USBDEVFS_CONTROL failed cmd usbmodules dev 2 rqt 128 rq 6 len 9 ret -75
usb 2-2: control timeout on ep0in
usb 2-2: control timeout on ep0in
usb 2-2: control timeout on ep0in

If I change it to the other USB slot:
# dmesg
hub 2-0:1.0: new USB device on port 1, assigned address 3
usb 2-1: control timeout on ep0out
-- 

Pau

