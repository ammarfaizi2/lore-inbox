Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270875AbTGVOkx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 10:40:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270876AbTGVOkw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 10:40:52 -0400
Received: from cable98.usuarios.retecal.es ([212.22.32.98]:37515 "EHLO
	hell.lnx.es") by vger.kernel.org with ESMTP id S270875AbTGVOkv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 10:40:51 -0400
Date: Tue, 22 Jul 2003 16:55:47 +0200
From: Manuel Estrada Sainz <ranty@debian.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Firmware loading problem
Message-ID: <20030722145546.GC23593@ranty.pantax.net>
Reply-To: ranty@debian.org
References: <1058885139.2757.27.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1058885139.2757.27.camel@pegasus>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 22, 2003 at 04:45:28PM +0200, Marcel Holtmann wrote:
> Hi,
> 
> I installed linux-2.6.0-test1-ac2 and tried to port my driver for the
> BlueFRITZ! USB Bluetooth dongle to 2.6. This device needs a firmware
> download and I want to use the new firmware class for getting the
> firmware file from userspace. After reading the documentation and
> testing the driver samples I got the results that I expected.
> 
> My problem is now that the firmware loader is not working with my
> firmware file and it seems that this is a problem of the file size,
> because copying small files through the same interface is working fine.
> This is the file I want to load:
> 
> -rw-r--r--  1 holtmann staff  418352 Jul 11 12:38 bfubase.frm
> 
> I have written my own firmware.agent hotplug script, which looks in
> general something like this:
> 
> 	echo 1 > $LOADING
> 	cp bfubase.frm $DATA
> 	echo 0 > $LOADING
> 
> Loading the above firmware file through this interface results in
> different behaviours. The results are complete freezes, instant reboots,
> X server crashes with black screens and sometimes I see an oops about
> virtual memory, but it goes bye bye too fast to let me do anything
> useful with it.

 Could you send me a tarball with a sample showing the problem. If
 possible I would like to do "make test" and have it compile and crash
 the system appropriately :)
 
> Are their any limitations with the sysfs binary file interface?

 Not that I know of. But I am willing to learn :)
 

 Thanks

 	Manuel

-- 
--- Manuel Estrada Sainz <ranty@debian.org>
                         <ranty@bigfoot.com>
			 <ranty@users.sourceforge.net>
------------------------ <manuel.estrada@hispalinux.es> -------------------
Let us have the serenity to accept the things we cannot change, courage to
change the things we can, and wisdom to know the difference.
