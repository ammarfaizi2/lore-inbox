Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265707AbTFSGcM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 02:32:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265709AbTFSGcM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 02:32:12 -0400
Received: from mid-1.inet.it ([213.92.5.18]:19594 "EHLO mid-1.inet.it")
	by vger.kernel.org with ESMTP id S265707AbTFSGcL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 02:32:11 -0400
Content-Type: text/plain; charset=US-ASCII
From: Paolo Ornati <javaman@katamail.com>
To: Dialtone <dialtone@despammed.com>, linux-kernel@vger.kernel.org
Subject: Re: [2.4.21-ck1] Problem with nforce2 and X
Date: Thu, 19 Jun 2003 08:39:38 +0200
X-Mailer: KMail [version 1.3.2]
References: <3EF0A1A3.3020606@despammed.com>
In-Reply-To: <3EF0A1A3.3020606@despammed.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <S265707AbTFSGcL/20030619063211Z+6415@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Have you read "NVIDIA Accelerated Linux Driver Set README & Installation 
Guide"?

Try to add this option to the Section "Device" of your XF86Config-4 file:
Option "NvAgp" "0"

AND READ THIS:

(app-f) APPENDIX F: CONFIGURING AGP
__________________________________________________________________________

There are several choices for configuring the NVIDIA kernel module's
use of AGP: you can choose to either use NVIDIA's AGP module (NVAGP),
or the AGP module that comes with the linux kernel (AGPGART).  This is
controlled through the "NvAGP" option in your XF86Config file:

         Option "NvAgp" "0"  ... disables AGP support
         Option "NvAgp" "1"  ... use NVAGP, if possible
         Option "NvAgp" "2"  ... use AGPGART, if possible
         Option "NvAGP" "3"  ... try AGPGART; if that fails, try NVAGP


On Wednesday 18 June 2003 19:30, Dialtone wrote:
> Hi all. I've been using kernel 2.4.21-rc3 for some time without
> any problems since the day it was released.
>
> Now that official 2.4.21 has been released I compiled it but
> problems started.
>
> Ok now, where is the problem. Well the screen seems to go
> in standby after I run X, and I must reboot since
> Alt+Ctrl+123456 doesn't work. I have the same problem when
> I upgrade to the latest bios from Epox (I have an Epox 8RDA+
> with nforce2 chipset and GeForce Ti4200) with kernel 2.4.21-rc3.
>
> I patched the kernel 2.4.21 with ck1 patch for O(1) sched and
> agpgart and so on. But I think the problem is not here since it
> comes also with another BIOS and the working kernel.
>
> Down here I report my dmesg and my kernel conf file. There are
> no Xfree errors so I guess is not its fault too.
>
> Thanks for your help.
>
> I forgot... I use vesa framebuffer for console, and apm
> (acpi gives me more errors like "Lost hdb interrupt").
> My CPU is an Athlon Xp 2000+ core Palomino.
> Here is my lspci:
>

