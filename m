Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262171AbUJZHkH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262171AbUJZHkH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 03:40:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262170AbUJZHjP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 03:39:15 -0400
Received: from mxc.rambler.ru ([81.19.66.31]:3079 "EHLO mxc.rambler.ru")
	by vger.kernel.org with ESMTP id S262171AbUJZHgd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 03:36:33 -0400
Date: Tue, 26 Oct 2004 11:33:37 +0400
From: Pavel Fedin <sonic_amiga@rambler.ru>
To: linux-kernel@vger.kernel.org
Subject: Parallel port driver patch
Message-Id: <20041026113337.536ea493.sonic_amiga@rambler.ru>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Tue__26_Oct_2004_11_33_37_+0400_NHZGs_.WP9p2EGWm"
X-Auth-User: sonic_amiga, whoson: (null)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart=_Tue__26_Oct_2004_11_33_37_+0400_NHZGs_.WP9p2EGWm
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

 Hello, all!
 First let me introduce myself. I live in Moscow and own Pegasos-II PowerPC-based computer from Genesi (www.pegasosppc.com). I wrote a patch for parallel port driver in 2.6.8 kernel to handle VIA8231 southbridge used in this machine and i'd like to offer the patch for including into future kernels.
 This patch allows the kernel to configure port's mode without help of BIOS. It is needed on my machine because its firmware simply ignores the parallel port leaving in unidirectional SPP mode. The patch adds init_mode=spp|epp|ecp|ecpepp option to the kernel (when driver is linked statically into the kernel parameter name is parport_init_mode). If you omit the option the driver will read current 8231 configuration. This means that on PCs you can still use BIOS to configure the port.
 Currently the patch itself is 100% working, i tried all modes and parport_pc driver recognises all of them and shows in /proc/sys/dev/parport/parport0 correctly except ECP+EPP (it is also not detected on all my PCs on which i tried Linux, so this is generic driver problem which i didn't find). ECP+EPP mode is detected as standalone ECP instead. But i left this option for experimental purposes.
 Unfortunately the whole system still does not work, i tried my Genuis-HR6 parallel port scanner and parallel ZIP drive and both of them don't work. ZIP drive is detected properly but then suddenly gets offline. Scanner does not answer any command at all. But this is not due to the patch, without it the same thing happens. Obviously Pegasos has some more problems which are not discovered and not fixed yet.

-- 
Best regards,
Pavel Fedin,									mailto:sonic_amiga@rambler.ru

--Multipart=_Tue__26_Oct_2004_11_33_37_+0400_NHZGs_.WP9p2EGWm
Content-Type: application/x-gzip;
 name="parport_pc-via8231.diff.gz"
Content-Disposition: attachment;
 filename="parport_pc-via8231.diff.gz"
Content-Transfer-Encoding: base64

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

--Multipart=_Tue__26_Oct_2004_11_33_37_+0400_NHZGs_.WP9p2EGWm--
