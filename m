Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264871AbTK3HYs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 02:24:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264875AbTK3HYs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 02:24:48 -0500
Received: from mail.ic.sunysb.edu ([129.49.1.4]:20956 "EHLO mail.ic.sunysb.edu")
	by vger.kernel.org with ESMTP id S264871AbTK3HYq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 02:24:46 -0500
Message-ID: <3FC99B0B.6010701@cs.sunysb.edu>
Date: Sun, 30 Nov 2003 02:23:55 -0500
From: Sean Callanan <spyffe@cs.sunysb.edu>
User-Agent: Mozilla/5.0 (Macintosh; U; PPC Mac OS X Mach-O; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [MOUSE] "Virtual PC" mouse no longer works
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear mailing list,

I'm running Debian inside Connectix Virtual PC 6.0.1. This software 
simulates Pentium-based hardware on a Macintosh. It lets the guest OS 
"captue" the Macintosh mouse - when the guest OS wants to use the mouse, 
the Macintosh pointer disappears and the guest OS receives mouse events. 
This is done using a virtual PS/2 device.

This functionality works with the following kernels (with relevant 
configuration options). They are stock Debian kernels.

2.2.20:
    CONFIG_MOUSE=y
    CONFIG_PSMOUSE=y
2.4.18:
    CONFIG_PSMOUSE=y

The mouse is free until X starts up (getting mouse events from 
/dev/psaux) and is then "captured" and usable in X. But with 
2.6.0-test11, this functionality is broken. The relevant parameters in 
my .config are:

    CONFIG_INPUT=y
    CONFIG_INPUT_MOUSEDEV=y
    CONFIG_INPUT_MOUSEDEV_PSAUX=y
    CONFIG_INPUT_MOUSE=y
    CONFIG_MOUSE_PS2=y
    CONFIG_BUSMOUSE=y

I have tried:
  1) Using /dev/input/mice and /dev/psaux in my XF86Config
  2) Passing psmouse_noext=1 to the kernel
Neither gave any success.

Please cc: me on any replies as I am not subscribed. Thank you for your 
time.

Sincerely,
Sean Callanan

