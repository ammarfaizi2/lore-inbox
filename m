Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262476AbUKDXeE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262476AbUKDXeE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 18:34:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262493AbUKDXeE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 18:34:04 -0500
Received: from ayaks.net2.nerim.net ([213.41.131.245]:46492 "EHLO
	nemesis.nata.nx") by vger.kernel.org with ESMTP id S262476AbUKDXdz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 18:33:55 -0500
Message-ID: <418ABC5F.6060200@enix.org>
Date: Fri, 05 Nov 2004 00:33:51 +0100
From: =?ISO-8859-1?Q?J=E9r=F4me_Petazzoni?= <jp@enix.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031221 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Possible GPL infringement in Broadcom-based routers
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following routers (and they might be other models, too) :
- Us Robotics 9105 (without wireless) and 9106 (with wireless)
- Siemens SE515
- Dynalink RTA230
- Buffalo WMR-G54
- Inventel DBW-200

... are all based on the same Broadcom chipset (96345 board). They 
integrate a 4-ports Ethernet switch, a 802.11g wireless access point, 
and a DSL modem (and doing routing and/or bridging between those 
interfaces). The CPU runs the MIPS32 instruction set. It runs a 2.4.17 
linux-mips kernel with additional patches, and is loaded with a lot of 
free software (busybox, uclibc, zebra...)

The vendors (probably Broadcom, in fact) had to patch the kernel to 
support the DSL modem, the wireless interface (which is a PCMCIA-hosted 
BCM4306 ; which already was subject of heated debates earlier), and also 
some generic stuff like the flash memory and the front leds. 
Miscellaneous vendors provide so-called "GPL sources", which are 
generally mutilated kernels, lacking all the "interesting" parts 
(wireless and DSL drivers for instance).

Can Broadcom and the vendors "escape" the obligations of the GPL by 
shipping those proprietary drivers as modules, or are they violating the 
GPL plain and simple by removing the related source code (and showing 
irrelevant code to show "proof of good will") ?

Broadcom has been contacted about this matter but hasn't answered so 
far, nor did US Robotics (I tried to contact USR since I own a USR router).

Any suggestions about the legal (or if it's a lost cause, technical!) 
ways to get support for this platform will be very welcome.

More information can be found here :
http://skaya.enix.org/wiki/GplInfringement (some extra details)
http://skaya.enix.org/wiki/BroadCom96345 (technical info that I gathered 
about the router, firmware and kernel formats, etc.)
http://sourceforge.net/projects/brcm6345-linux/ (sourceforge project)

Best regards,
Jérôme Petazzoni <jp at enix dot org>
PS: please be kind and cc me, as my lkml awareness is limited to KT ...
