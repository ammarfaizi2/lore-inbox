Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264275AbUAUXoL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 18:44:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264283AbUAUXoL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 18:44:11 -0500
Received: from ms-smtp-03.rdc-kc.rr.com ([24.94.166.129]:50363 "EHLO
	ms-smtp-03.rdc-kc.rr.com") by vger.kernel.org with ESMTP
	id S264275AbUAUXoG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 18:44:06 -0500
From: Paul Misner <paul@misner.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Nvidia drivers and 2.6.x kernel
Date: Wed, 21 Jan 2004 17:44:03 -0600
User-Agent: KMail/1.6
References: <200401221012.17121.chakkerz@optusnet.com.au>
In-Reply-To: <200401221012.17121.chakkerz@optusnet.com.au>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200401211744.04064.paul@misner.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 21 January 2004 05:12 pm, Christian Unger wrote:
> Hi Everyone
>
> I'm not sure if this has been done to death or not, but i can not get the
> 4496 and 5328 versions of the NVidia kernel to work on the 2.6.1 version of
> (you guessed it) Linux.
>
> I've googled about but not really found any great stuff. I did find this:
>
> http://www.kerneltrap.org/node/view/1804
> and from there the link to http://minion.de
Did you try the installers from http://www.sh.nu/download/nvidia/ ?
 http://minion.de refers to them, and they appear to work fine here.

>
> I've tried it with both versions of the driver, with both versions of the
> drivers Makefile (Makefile.nvidia and Makefile.kbuild).
>
> With the installer and with just make install (make kernel_module_install).
> The message i get is that the module is the wrong format.
Wrong (or no) module-init-tools?  Mine currently is 
module-init-tools-3.0-0.pre5.2mdk from the Mandrake cooker, although I've not 
had trouble for some time with any version.  The nvidia.ko file is the one 
that will load under a 2.6 kernel.  The wrong format message sounds like you 
don't have module-init-tools installed, although I would expect getting your 
nvidia card to run would be the least of your problems.

You could also switch over in your XFConfig-4 to the nv driver that is part of 
the kernel build.  That should get your system running with X, letting you 
solve the nvidia driver problems later.

> The files that i can get to appear in:
> /lib/modules/2.6.1/kernel/drivers/video are nvidia.ko & nvidia.o
> Originally i thought they were the same file, but they have different sizes
> (afterall)
> chakkerz@stormcrow:/lib/modules/2.6.1/kernel/drivers/video$ ls -l
> total 4648
> -rw-rw-r--    1 root     root      2376880 Jan 21 12:14 nvidia.ko
> -rw-rw-r--    1 root     root      2376702 Jan 21 12:15 nvidia.o
>
> so: i've tried unpatched, patched, old and new drivers, installer and make,
> make in the installers root, and it's sub director usr/src/nv ... oh yes,
> and different versions of the patch.
>
> could someone please tell me where to find out how to make this work,
> because linux without GUI is little use to me.
>
> In case it matters:
> This is an AMD Athlon XP 2800+ on a Gigabyte GA-7N400 Pro2 MoBo (nforce2).
> The FFX is an Abit Siluro GeForce 4 Ti4200 OTES. 2 sticks of 256 Corsair
> DDR in dual channel. The kernel compiles i tried were with AGPGART
> integrated (and the nforce/nforce2 also integrated) as well as AGPGART as a
> module. Most of the stuff i tried with AGPGART as a module.
What messages do you get about what is going wrong?  What happens when you so 
a modprobe nvidia?  What does your log file from XFree show?

Paul
