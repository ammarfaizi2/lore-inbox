Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269294AbTGJOwZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 10:52:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269297AbTGJOve
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 10:51:34 -0400
Received: from air-2.osdl.org ([65.172.181.6]:9425 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269294AbTGJOu4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 10:50:56 -0400
Date: Thu, 10 Jul 2003 08:03:45 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Michael Frank <mflt1@micrologica.com.hk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.74 CONFIG_USB_SERIAL_CONSOLE gone?
Message-Id: <20030710080345.7907d810.rddunlap@osdl.org>
In-Reply-To: <200307101453.57857.mflt1@micrologica.com.hk>
References: <200307101453.57857.mflt1@micrologica.com.hk>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jul 2003 14:53:57 +0800 Michael Frank <mflt1@micrologica.com.hk> wrote:

| Tried to config usb serial console on 2.5.74 but it's no more configurable.
| 
| Searched the tree and these are the only references
| 
| ./BitKeeper/deleted/.del-Config.help~23cda2581f02cfcb
| ./BitKeeper/deleted/.del-Config.in~92fe774f90db89d
| ./drivers/usb/serial/Makefile
| ./drivers/usb/serial/usb-serial.h
| 
| Has this been deleted?

No, but there is a typo in the Kconfig file for it.
Patch for it is below.  (It is from the -kj patchset. :)
Patch by Francois Romieu <romieu@fr.zoreil.com>.

--
~Randy
| http://developer.osdl.org/rddunlap/ | http://www.xenotime.net/linux/ |



diff -puN drivers/usb/serial/Kconfig~typo-usb-serial-kconfig drivers/usb/serial/Kconfig

 ----------- Diffstat output ------------
 ./drivers/usb/serial/Kconfig |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff ./drivers/usb/serial/Kconfig~current~ ./drivers/usb/serial/Kconfig
--- ./drivers/usb/serial/Kconfig~current~	2003-07-09 00:12:22.000000000 -0700
+++ ./drivers/usb/serial/Kconfig	2003-07-09 00:12:22.000000000 -0700
@@ -31,7 +31,7 @@ config USB_SERIAL_DEBUG
 
 config USB_SERIAL_CONSOLE
 	bool "USB Serial Console device support (EXPERIMENTAL)"
-	depends on USB_SERIAL=y && EXPERIMENTAL
+	depends on USB_SERIAL && EXPERIMENTAL
 	---help---
 	  If you say Y here, it will be possible to use a USB to serial
 	  converter port as the system console (the system console is the
