Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129846AbRACTSc>; Wed, 3 Jan 2001 14:18:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130204AbRACTSR>; Wed, 3 Jan 2001 14:18:17 -0500
Received: from whiterose.net ([199.245.105.145]:23824 "EHLO whiterose.net")
	by vger.kernel.org with ESMTP id <S129846AbRACTSE>;
	Wed, 3 Jan 2001 14:18:04 -0500
Date: Wed, 3 Jan 2001 13:47:46 -0500 (EST)
From: M Sweger <mikesw@whiterose.net>
To: alan@redhat.com, linux-kernel@vger.kernel.org
Subject: linux 2.2.19pre5 /proc problem.
Message-ID: <Pine.LNX.4.21.0101031344340.32532-100000@whiterose.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan,

    I have linux 2.2.19pre5 on a UMSDOS based Dell Optiplex Gx1 using
libc5 v2.0.7. Below is my "lsmod" of all modules loaded.
Note: the  cpuid module when it isn'tloaded and oopsing the kernel is
fixed now. However, I found a new problem in /proc.

A). Problem:   If you "cat /proc/sys/net/ipv4/route/flush" you'll get
     Invalid argument as an error message. This is a zero length file
     (as expected) and I'm not sure what it is supposed to contain.
     I can send my kernel ".config" file if you can't duplicate this one.
     Note: I do have a regular T1 internet connection, even though I have
     the ppp and slip stuff loaded -- these modules aren't being used.



Module                  Size  Used by
cpuid                    676   0  (unused)
usb-storage            21496   0  (unused)
usbserial              17288   0  (unused)
usb-uhci               18652   0  (unused)
usbcore                46056   0  [usb-storage usbserial usb-uhci]
loop                    7616   0  (unused)
dummy                    688   0  (unused)
3c59x                  20552   1 
opl3                   11208   0 
cs4232                  2408   0 
uart401                 5968   0  [cs4232]
ad1848                 16080   0  [cs4232]
sound                  57164   0  [opl3 cs4232 uart401 ad1848]
soundcore               2340   5  [sound]
ppp_deflate            40652   0  (unused)
bsd_comp                3656   0  (unused)
ppp                    19948   0  [ppp_deflate bsd_comp]
slip                    7220   0  (unused)
slhc                    4328   0  [ppp slip]
parport_pc              7252   0 
parport                 7028   0  [parport_pc]


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
