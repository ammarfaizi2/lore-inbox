Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266613AbUHQTHz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266613AbUHQTHz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 15:07:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268359AbUHQTHz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 15:07:55 -0400
Received: from outbound05.telus.net ([199.185.220.224]:3045 "EHLO
	priv-edtnes40.telusplanet.net") by vger.kernel.org with ESMTP
	id S266613AbUHQTHm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 15:07:42 -0400
From: Shaun Jackman <sjackman@telus.net>
To: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Subject: Re: Hang after "BIOS data check successful" with DVI
Date: Tue, 17 Aug 2004 12:07:53 -0700
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <E82D6B0981@vcnet.vc.cvut.cz>
In-Reply-To: <E82D6B0981@vcnet.vc.cvut.cz>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408171207.53962.sjackman@telus.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue August 17, 2004 03h57, Petr Vandrovec wrote:
> On 16 Aug 04 at 16:55, Shaun Jackman wrote:
> > When I have a DVI display plugged into my Matrox G550 video card the
> > boot process hangs at "BIOS data check successful". I am running Linux
> > kernel 2.6.6. This problem does not affect Linux kernel 2.4.26. If I
> > boot without the DVI display plugged in, I can plug it in after the
> > boot process and the display works.
> 
> Try disabling CONFIG_VIDEO_SELECT and/or comment out call to store_edid
> in arch/i386/boot/video.S. Also which bootloader you use? From
> quick glance at bootloaders, grub1 seems to set %sp to 0x9000, while 
> LILO to 0x0800. And I think that 2048 byte stack (plus something already 
> allocated by loader) might be too small for DDC call, as MGA BIOS first
> creates EDID copy on stack...
>                                            Best regards,
>                                                 Petr Vandrovec

I tried removing the call to store_edid and that does indeed fix my
problem!

Many thanks!
Shaun

