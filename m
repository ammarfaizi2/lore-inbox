Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263338AbUDZTKb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263338AbUDZTKb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 15:10:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263440AbUDZTKb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 15:10:31 -0400
Received: from mail-ext.curl.com ([66.228.88.132]:39940 "HELO
	mail-ext.curl.com") by vger.kernel.org with SMTP id S263338AbUDZTK0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 15:10:26 -0400
From: "Patrick J. LoPresti" <patl@users.sourceforge.net>
Message-ID: <s5g8ygi4l3q.fsf@patl=users.sf.net>
To: linux-kernel@vger.kernel.org
Subject: Load hid.o module synchronously?
Date: 26 Apr 2004 15:10:24 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am using the 2.6.5 kernel on a modular boot disk.  I am finding that
invocations of "modprobe" are returning sooner than I would like.

For example, I invoke "modprobe hid" to make my USB keyboard work.
This loads the module and exits immediately, causing my script to
proceed, before the USB keyboard is probed and ready.

I want to wait until the driver is finished initializing (i.e., a USB
keyboard is either found or not found) before my script continues.
How can I do that?

I seem to be having similar problems loading certain other modules
(PCMCIA, Ethernet), but hid.o is the only one for which I have not
found a convenient workaround.

I apologize if this is a stupid question.  I have spent some time
searching both the Linux source code and the linux-kernel archives to
no avail.

Thanks!

 - Pat
