Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264324AbTKUItU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Nov 2003 03:49:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264330AbTKUItU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Nov 2003 03:49:20 -0500
Received: from adsl-66-124-9-168.dsl.lsan03.pacbell.net ([66.124.9.168]:45205
	"EHLO cocoabitch") by vger.kernel.org with ESMTP id S264324AbTKUItI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Nov 2003 03:49:08 -0500
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Making Linux HID compliant
From: James Lamanna <jlamanna@ugcs.caltech.edu>
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Date: Fri, 21 Nov 2003 00:50:24 -0800
Message-ID: <opryzb6a0rz4tciz@192.168.1.4>
User-Agent: Opera7.22/Win32 M2 build 3221
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While Linux is mostly HID compliant, it does not totally match the HID specification, which causes some HID compliant devices (most notably Phidgets) to have problems.

Linux assumes that there is a 1-1 correspondence from Usages to device controls. This may not be the case. As the HID specification states:
"While Local items do not carry over to the next Main item, they may apply to
more than one control within a single item. For example, if an Input item
defining five controls is preceded by three Usage tags, the three usages would
be assigned sequentially to the first three controls, and the third usage would
also be assigned to the fourth and fifth controls."

Linux does not do this, which prevents HID devices like Phidgets from working properly,
Is there any plans to get this fixed in the near 2.6.x timeframe? (I'm pretty sure it should be fairly simple, just duplicated the last usage...)
This issue was brought up on usb-devel but it didn't seem like anything came of it.
