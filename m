Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932263AbWBXSNv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932263AbWBXSNv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 13:13:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932412AbWBXSNv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 13:13:51 -0500
Received: from albireo.ucw.cz ([84.242.65.108]:54661 "EHLO albireo.ucw.cz")
	by vger.kernel.org with ESMTP id S932263AbWBXSNu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 13:13:50 -0500
Date: Fri, 24 Feb 2006 19:13:46 +0100
From: Martin Mares <mj@ucw.cz>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Asfand Yar Qazi <ay0106@qazi.f2s.com>, linux-kernel@vger.kernel.org
Subject: Re: Kernel 'vga=' parameter wierdness
Message-ID: <mj+md-20060224.181006.23057.albireo@ucw.cz>
References: <43FC1624.8090607@qazi.f2s.com> <200602221130.13872.vda@ilport.com.ua> <43FC54B8.7070706@qazi.f2s.com> <mj+md-20060222.121130.6225.albireo@ucw.cz> <43FC574A.4000100@qazi.f2s.com> <Pine.LNX.4.61.0602240832150.16363@yvahk01.tjqt.qr> <mj+md-20060224.101038.705.atrey@ucw.cz> <Pine.LNX.4.61.0602241904570.3694@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0602241904570.3694@yvahk01.tjqt.qr>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> That /^0[xX][0-9a-fA-F]+$/ is required to interpret $_ as a hexadecimal 
> number, that /^0[0-7]+$/ is required to interpret it as an octal,
> and everything else for a normal decimal number.
> IOW, using strtol(my_vga_string, NULL, 0) everywhere (GRUB, as well as the 
> "vga selector" in the kernel).
> And making sure the vga selector (i.e. when booting with 
> vga=ask) always prefix numbers with 0x when they are supposed to be in 
> hexadecimal, i.e. e.g.
>   for(i=0; ...) 
>       printf("%#x   %dx%d\n", i, vga_modes[i].width, vga_modes[i].height);
> instead of currently
>       printf("%x    %dx%d\n", ...)

However, this would change meaning of numbers entered at the video mode
prompt (with vga=ask), which doesn't look good.

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
Uncle Ed's Rule of Thumb:  Never use your thumb for a rule.
