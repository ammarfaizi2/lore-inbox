Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262453AbUDAPSC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 10:18:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262644AbUDAPSC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 10:18:02 -0500
Received: from fed1mtao04.cox.net ([68.6.19.241]:22491 "EHLO
	fed1mtao04.cox.net") by vger.kernel.org with ESMTP id S262453AbUDAPRz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 10:17:55 -0500
Date: Thu, 1 Apr 2004 08:17:43 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Martin Schaffner <schaffner@gmx.li>
Cc: linux-kernel@vger.kernel.org
Subject: Re: booting 2.6.4 from OpenFirmware
Message-ID: <20040401151743.GF21709@smtp.west.cox.net>
References: <321B041D-8298-11D8-AC61-0003931E0B62@gmx.li> <1080687527.1198.48.camel@gaston> <555BCB50-837A-11D8-8BC8-0003931E0B62@gmx.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <555BCB50-837A-11D8-8BC8-0003931E0B62@gmx.li>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 01, 2004 at 02:17:24AM +0100, Martin Schaffner wrote:
> 
> On 30.03.2004, at 23:58, Benjamin Herrenschmidt wrote:
> 
> >On Wed, 2004-03-31 at 08:18, Martin Schaffner wrote:
> >>Hi,
> >>
> >>I try to boot linux-2.6.4 from OpenFirmware on my Apple iBook2 (dual
> >>USB). I'm using the image named "vmlinux.elf-pmac". While linux-2.4.25
> >>boots fine, linux-2.6.4 doesn't  [...]
> >>
> >>If I try to boot the stock kernel, OpenFirmware tells me "Claim
> >>failed", and returns to the command prompt.
> >
> >That's strange, I do such netbooting everyday on a wide range of
> >machines without trouble. Are you using some kind of cross compiler ?
> >Maybe there are some issues with cross compiling of the boot wrapper...
> 
> I WAS cross-compiling, but the problem persists when compiling 
> natively. I don't net-boot but load the image from a HFS+ partition. I 
> can't boot
> 
> http://membres.lycos.fr/schaffner/vmlinux.orig
> 
> which is a compilation of linux-2.6.4 with
> 
> http://membres.lycos.fr/schaffner/.config
> 
> I can, however, boot
> 
> http://membres.lycos.fr/schaffner/vmlinux.patched
> 
> which is the same after the following patch:
> 
> http://membres.lycos.fr/schaffner/boot-of-works.patch
> 
> Maybe the problem is specific to the model of the machine?

I suspect that there's some ELF sections which need to be dropped.
Can you do an objdump -x on the vmlinux.elf-pmac with and without that
patch and tell us which names are missing from the working one?  Thanks.

-- 
Tom Rini
http://gate.crashing.org/~trini/
