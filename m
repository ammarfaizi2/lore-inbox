Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262280AbTD3R4f (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 13:56:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262281AbTD3R4e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 13:56:34 -0400
Received: from [65.244.37.61] ([65.244.37.61]:34624 "EHLO
	WSPNYCON1IPC.corp.root.ipc.com") by vger.kernel.org with ESMTP
	id S262280AbTD3R4b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 13:56:31 -0400
Message-ID: <170EBA504C3AD511A3FE00508BB89A9202032A8E@exnanycmbx4.ipc.com>
From: "Downing, Thomas" <Thomas.Downing@ipc.com>
To: linux-kernel@vger.kernel.org
Subject: CPIA unknown symbol - ?bug?
Date: Wed, 30 Apr 2003 14:08:39 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I load the module cpia_usb dmesg shows:

cpia_usb: Unknown symbol cpia_register_camera
cpia_usb: Unknown symbol cpia_unregister_camera

Normally this would be no problem, I could fix that; BUT

1. cpia.c does export both these methods, in fact they are
the only two exported.

2. more peculiar still - cpia_usb then successfully calls
cpia_register_camera, the camera is registered according
to dmesg, /proc/bus/usb/devices, /proc/cpia /proc/video/dev.

And the camera works just fine!  So why the error?

Am I missing something here?
