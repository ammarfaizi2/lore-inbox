Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262708AbTH0Nba (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 09:31:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262989AbTH0Nba
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 09:31:30 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:60933 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S262708AbTH0NbX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 09:31:23 -0400
Subject: Re: 2.6.0-test4 kernel hangs on loading mouse driver
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Phil Stewart <phil@lichp.co.uk>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0308271256330.527-100000@henry>
References: <Pine.LNX.4.33.0308271256330.527-100000@henry>
Content-Type: text/plain
Message-Id: <1061991042.694.1.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Wed, 27 Aug 2003 15:30:43 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-08-27 at 14:13, Phil Stewart wrote:
> I'm having a problem booting the test4 kernel, which has developed since
> patching up from a functional test2 tree (I haven't compiled a test3
> kernel on my system, having patched to test3 and then again to test4). The
> problem seems to lie with the mouse, which is a USB HID mouse. The kernel
> gets as far as loading the hid core at boot time, giving these messages:
> 
> drivers/usb/core/usb.c: registered new driver hid
> drivers/usb/input/hid-core.c: v2.0: USB HID core driver
> mice: PS/2 mouse device common for all mice

It's a known problem related to ACPI changes in -test4. Please, see

http://bugzilla.kernel.org/show_bug.cgi?id=1123

for further information. For me, enabling APIC and IOAPIC solve the
problem. If you can't enable APIC and IOAPIC, please boot using
"pci=noacpi".

