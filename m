Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264957AbUFOIim@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264957AbUFOIim (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 04:38:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265370AbUFOIil
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 04:38:41 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:28423 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264957AbUFOIiK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 04:38:10 -0400
Date: Tue, 15 Jun 2004 09:38:07 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 1/5] kbuild: default kernel image
Message-ID: <20040615093807.A1164@flint.arm.linux.org.uk>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
References: <20040614204029.GA15243@mars.ravnborg.org> <20040614204405.GB15243@mars.ravnborg.org> <20040614220549.L14403@flint.arm.linux.org.uk> <20040615044020.GC16664@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040615044020.GC16664@mars.ravnborg.org>; from sam@ravnborg.org on Tue, Jun 15, 2004 at 06:40:20AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2004 at 06:40:20AM +0200, Sam Ravnborg wrote:
> The advantage is that you now have a good place to document all of
> these formats - your Kconfig file.
> And you select the default target for the user.
> 
> How did I know uboot required mkimage before - now it can be documented
> in Kconfig.
> So the situation above is actually a good example why it is whortwhile
> to move the kernel image selection to the config stage.
> 
> If they all should be part of the kernel build is another discussion.

You missed my point.

How does a user know which format they need to build the kernel with
_if_ the kernel configuration contains all the formats and the boot
loader documentation fails to mention it?

Sure you can document each format in minute detail, but that doesn't
tell the user anything useful.

As I tried to point out, boot loaders on ARM historically seem to have
been "My First ARM Project" type things so there's lots of them out
there - there aren't 3 or so found on x86.

AFAIAC, if the boot loader does not support the standard Image or
zImage format, both of which are the fully documented "official"
ARM kernel formats, it is up to the boot loader to provide whatever
scripts or programs are needed to manipulate the output of the kernel
build to whatever the boot loader wants.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
