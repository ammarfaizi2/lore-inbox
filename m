Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267344AbUGNKH0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267344AbUGNKH0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 06:07:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267345AbUGNKH0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 06:07:26 -0400
Received: from smtp-b2c.tiscali.nl ([195.241.80.19]:63721 "EHLO
	ha-smtp0.tiscali.nl") by vger.kernel.org with ESMTP id S267344AbUGNKHZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 06:07:25 -0400
Subject: Saitek X45 Joystick broken in kernelversions > 2.6.5-rc1
	(hid-core.c)
From: Paul Heldens <pheldens@tiscali.nl>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Wed, 14 Jul 2004 12:04:43 +0200
Message-Id: <1089799483.293.18.camel@borgir.sleepynet>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.9 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The stick gets Initialized properly, as dmesg shows. But then when
running an application like for instance "js_demo" the stick does not
respond to axial or button input, several of the axes are locked solid
in weird (-1) positions. (Calibrating does not fix this, nor does the
stick need to be manually calibrated normally)

The problem seems to be in a change of usb/input/hid-core.c that
appeared in 2.6.5-rc2. When I use rc1's hid-core.c with some minor
editing to force it to build with the rest of the rc2 kernel, the
joystick works. I've tested every release kernel since and none of those
worked.

Another two X45 users confirmed a non working stick in atleast 2.6.7,
and there's also a Saitek P750 joypaduser that might be suffering the
same problem.

my stick's serial number:
SZ00169829



