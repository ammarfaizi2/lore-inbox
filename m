Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261899AbUCDNlI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 08:41:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261906AbUCDNlI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 08:41:08 -0500
Received: from mail.math.uni-mannheim.de ([134.155.89.179]:13262 "EHLO
	mail.math.uni-mannheim.de") by vger.kernel.org with ESMTP
	id S261899AbUCDNkz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 08:40:55 -0500
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: linux-kernel@vger.kernel.org
Subject: GPLv2 or not GPLv2? (no license bashing)
Date: Thu, 4 Mar 2004 08:38:29 +0100
User-Agent: KMail/1.6
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200403040838.31412.eike-kernel@sf-tec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

just digging a bit in the kernel and found some funny things:

-there is a tag only for "GPL v2" but there are some drivers claiming to be 
v2 and not using this (patch will follow)
-there are some drivers with the comment ", either version 2 of the License." 
in the header. s/either // ? If so, there are some more files where someone 
should change MODULE_LICENSE("GPL") to "GPL v2".
-there are some files that have the long warranty warning in the header. This 
brings up the question if we should see the mainline kernel as one piece of 
software. If we do so we need this warning only once and this copy should be 
in the main kernel directory and we should kill the others. The other 
question is: when I only write down the names of the authors in the header 
and then add MODULE_LICENSE("GPL") or "GPL v2" is this enough licensing 
information or is always the long comment needed (would be another nice 
trick to shrink tons of files)?
-the LINUX_VERSION_CODE line in drivers/message/fusion/isense.c looks bogus, 
the comment says it is for <2.5.0, but the line itself is for <2.3.0. Is 
this wanted (fix the comment), bogus (fix the line) or crap (kill it 
alltogether).

This are the files where I found "either version 2 of the License.":

arch/arm/mach-integrator/integrator_cp.c
drivers/serial/8250_pnp.c
drivers/serial/8250_pci.c
drivers/input/serio/pcips2.c
drivers/input/serio/sa1111ps2.c

These are some files (there are surely tons of others) with the long warning:

drivers/scsi/3w-xxxx.[ch]
drivers/message/fusion/mptctl.c
drivers/message/fusion/mptbase.[ch]
drivers/message/fusion/mptscsih.c
drivers/message/fusion/isense.c (*)
drivers/message/fusion/mptlan.[ch]
drivers/message/fusion/mptctl.[ch]
drivers/message/fusion/mptscsih.[ch]

Eike
