Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270019AbUJNKMO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270019AbUJNKMO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 06:12:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270021AbUJNKMO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 06:12:14 -0400
Received: from cimice4.lam.cz ([212.71.168.94]:15249 "EHLO beton.cybernet.src")
	by vger.kernel.org with ESMTP id S270019AbUJNKML (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 06:12:11 -0400
Date: Thu, 14 Oct 2004 10:12:11 +0000
From: Karel Kulhavy <clock@twibright.com>
To: linux-kernel@vger.kernel.org
Subject: i2c-parport, ELV documentation
Message-ID: <20041014101211.GB8837@beton.cybernet.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-Orientation: Gay
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

Documentation/i2c/i2c-parport reads:
"These devices use different pinout configurations, so you have to tell
the driver what you have, using the type module parameter."

I would like to tell that my adapter is of type ELV.

The i2c-parport doesn't say anything how to tell the kernel "ELV" during the
startup, without using any modules. I would strongly prefer compiling in the
driver directly. I would like to be sure the adaptor works from the very boot
of the system and not only after some startup scripts of unknown quality
(I already have experienced a problem with startup scripts that were wrong,
I am using gentoo) load up the module.

How to tell the kernel that my adapter is "ELV" using the
append="ether=0,0,0x3,0,eth0"-style way?

Another question is: if I had to resort to using the
modules (say it would show up that the driver doesn't support non-module
configuration at all, as was with 3COM 3c900 card which was fixed later by Jeff
Garzik), how do I tell the kernel the module parameters exactly? I have been
looking at various places where I would expect this information, however did't
find any syntax description:

* i2c-parport doc file doesn't tell this
* Documentation directory of Linux source tree doesn't contain modules,
* modules.txt, Modules,
  Modules.txt, module, module.txt, Module, Module.txt file, module, modules,
  Module, Modules directory
* make menuconfig, Loadable modules support, Enable loadable modules support,
  Help doesn't contain the information. However points to man modprobe, lsmod,
  modinfo, insmod and rmmod.
* man modprobe says "If any arguments are given after the modulename, they are
  passed to the kernel (in addition to any options listed in the configuration
  file)."
  However, the syntax is not described. Is it type=elv, type elv, type=ELV,
  type ELV, type:elv, type:ELV, type: elv, type: ELV or whatever?
* man lsmod, modinfo, insmod, rmmod don't comment on this topic at all too.

linux kernel version 2.6.8.1

Cl<


