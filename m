Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261920AbUBWPNz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 10:13:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261921AbUBWPNz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 10:13:55 -0500
Received: from mailgw.cvut.cz ([147.32.3.235]:42956 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S261920AbUBWPNx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 10:13:53 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Juha <juhis@trinity.is-a-geek.com>
Date: Mon, 23 Feb 2004 16:13:24 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: matroxfb not working after trying to upgrade to 2.6.3
Cc: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.50
Message-ID: <6801343D94@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 Feb 04 at 12:35, Juha wrote:
> I've got a problem with matroxfb not working in either 2.4.23 or 2.6.3 after
> trying to upgrade to 2.6 series. My videocard is a G400 and it's built as a
> module. Previously, when I modprobed the module, it would register itself in
> /etc/log/syslog, but now nothing is printed in the syslog when inserting the
> modules. And I don't understand, what has changed. These are the parameters I
> give to lilo on boot:
> 
> Feb 23 14:06:27 linux kernel: Kernel command line: auto BOOT_IMAGE=Linux ro
> root=303 video=matrox:vesa:0x115
> 
> And this is my .config:
> 
> CONFIG_FB_MATROX=m

Do not build it as a module. It is not going to work in usual configurations.
Also, did you built CONFIG_FRAMEBUFFER_CONSOLE as a module and insmod-ded it
AFTER matroxfb?

> but when I try to use matroxset, with both 2.4 and 2.6, I get:
> 
> bash:# matroxset -f /dev/fb0 -m 2
> ioctl failed: Device or resource busy

Probably output #1 is already used by someone else. Build everything
to the kernel, you'll get much saner defaults then, as it forces 
correct order for crtc2 & maven initializations.

What reports 'matroxset -f /dev/fb0 -m' and 'matroxset -f /dev/fb1 -m' ?
Does not second one report that /dev/fb1 is currently displayed on that
output?
                                                                Petr
                                                                

