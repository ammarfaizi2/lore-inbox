Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261787AbUBWMkm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 07:40:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261796AbUBWMkm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 07:40:42 -0500
Received: from main.gmane.org ([80.91.224.249]:45496 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261787AbUBWMkk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 07:40:40 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Juha <juhis@trinity.is-a-geek.com>
Subject: matroxfb not working after trying to upgrade to 2.6.3
Date: Mon, 23 Feb 2004 12:35:01 +0000 (UTC)
Message-ID: <loom.20040223T132140-441@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 193.110.64.16 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5b) Gecko/20030819 Mozilla Firebird/0.6.1+)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello list,

I've got a problem with matroxfb not working in either 2.4.23 or 2.6.3 after
trying to upgrade to 2.6 series. My videocard is a G400 and it's built as a
module. Previously, when I modprobed the module, it would register itself in
/etc/log/syslog, but now nothing is printed in the syslog when inserting the
modules. And I don't understand, what has changed. These are the parameters I
give to lilo on boot:

Feb 23 14:06:27 linux kernel: Kernel command line: auto BOOT_IMAGE=Linux ro
root=303 video=matrox:vesa:0x115

And this is my .config:

CONFIG_FB_MATROX=m
CONFIG_FB_MATROX_G450=y
CONFIG_FB_MATROX_G100=y
CONFIG_FB_MATROX_I2C=m
CONFIG_FB_MATROX_MAVEN=m

and lsmod:

matroxfb_crtc2          8308   0  (unused)
matroxfb_maven         13308   0  (unused)
i2c-matroxfb            2772   0  (unused)
matroxfb_base          20580  63  [matroxfb_crtc2 i2c-matroxfb]
matroxfb_g450           4708   0  [matroxfb_base]
matroxfb_DAC1064        9500   0  [matroxfb_crtc2 matroxfb_base]
g450_pll                3536   0  [matroxfb_g450 matroxfb_DAC1064]
matroxfb_accel          9448   0  [matroxfb_base matroxfb_DAC1064]
matroxfb_misc          15364   0  [matroxfb_crtc2 matroxfb_maven i2c-matroxfb
matroxfb_base matroxfb_g450 matroxfb_DAC1064 g450_pll matroxfb_accel]

but when I try to use matroxset, with both 2.4 and 2.6, I get:

bash:# matroxset -f /dev/fb0 -m 2
ioctl failed: Device or resource busy

I'd be very grateful for any help,  juhis

