Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262457AbTEVCpt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 22:45:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262458AbTEVCpt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 22:45:49 -0400
Received: from bunyip.cc.uq.edu.au ([130.102.2.1]:11278 "EHLO
	bunyip.cc.uq.edu.au") by vger.kernel.org with ESMTP id S262457AbTEVCps
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 22:45:48 -0400
Message-ID: <3ECC3D18.201@torque.net>
Date: Thu, 22 May 2003 12:59:36 +1000
From: Douglas Gilbert <dougg@torque.net>
Reply-To: dougg@torque.net
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: artemio@artemio.net, linux-kernel@vger.kernel.org
CC: gibbs@btc.adaptec.com
Subject: Re: HELP: kernel won't boot from /dev/sdb1
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Artemio wrote:

 > I've just installed RH 7.3 on a machine with all-SCSI
 > discs. I had to load  "linux dd" with Adaptec AIC 79xx
 > driver floppy installed, but that's ok.
 > The / is mounted from /dev/sdb1.
 >
 > So, I got a clean 2.4.20 kernel, added AIC 79xx driver
 > sources to the kernel source tree, configured and
 > compiled and installed it (of course, I didn't
 > forget about the modules).
 >
 > In lilo, I said "root=/dev/sdb1" just as for the original
 > 2.4.18-3 RedHatkernel which boots ok.
 >
 > When I boot the new kernel, I get:
 > VFS: Cannot open root device at "811" or "08:11"
 >
 > From SCSI-howto I got that 08:11 stands for /dev/sda11.
 > Why would /dev/sdb1 be converted to 08:11 instead of 08:17
 > (again, corresponding to SCSI-howto)?

Those number are in hex, so "811" is major 8, minor 17 which
is (or should be) /dev/sdb1. Look earlier in the boot up
sequence, where the aic79xx driver is loaded and scans
for devices. It should say that it has attached /dev/sdb .
You may need a later version of that driver. Visit:
     http://people.FreeBSD.org/~gibbs/linux

Doug Gilbert

