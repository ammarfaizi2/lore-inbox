Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263661AbTEEQ0V (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 12:26:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263650AbTEEQYt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 12:24:49 -0400
Received: from franka.aracnet.com ([216.99.193.44]:23488 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S263654AbTEEQYG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 12:24:06 -0400
Date: Mon, 05 May 2003 09:36:03 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 643] New: Problems when using both fbcon and vgacon
Message-ID: <10390000.1052152563@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=643

           Summary: Problems when using both fbcon and vgacon
    Kernel Version: 2.5.68
            Status: NEW
          Severity: normal
             Owner: jsimmons@infradead.org
         Submitter: ursg@uni.de


Distribution: Debian Testing
Hardware Environment: PC with Matrox Mysitque and Voodoo 2
Software Environment: Linux 2.5.68, fbset 2.1
Problem Description:

The Mystique running as vgacon, while the Voodoo2 is handled by sstfb.
VCs ahve been assigned to both screens.
If I change the framebuffer resolution after startup, the actual console
size is not changed, so changing from 640x480 to 1024x768 shows the vc
content in the upper left corner of the screen only. Additionally, the
screen is filled with "pixel rubbish", only the areas containing text are
actually redrawn.

Once I change to a VC on the vgacon and back, the monitor goes into
energy-sving mode (seems like the timings are screwed up).

I can't test any other framebuffer drivers at the moment, this bug may be
sstfb-specific.

Steps to reproduce:
 - Build kernel with vgacon and a sstfb console.
 - boot with something like "fbcon=vc:1-4"
 - change the fb video mode.
 - switch to a vgacon VC and back.


