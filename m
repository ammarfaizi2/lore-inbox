Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265219AbTIJPxl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 11:53:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265223AbTIJPxl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 11:53:41 -0400
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:38920 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id S265219AbTIJPxh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 11:53:37 -0400
Message-ID: <24503.80.126.29.72.1063209215.squirrel@webmail.xs4all.nl>
Date: Wed, 10 Sep 2003 17:53:35 +0200 (CEST)
Subject: [Fwd: cat /proc/ide/ide1/hdc/identify hangs]
From: "Jeroen Makkinje" <j.makkinje@xs4all.nl>
To: linux-kernel@vger.kernel.org
Reply-To: j.makkinje@xs4all.nl
User-Agent: SquirrelMail/1.4.2 [CVS]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



---------------------- Original Message -----------------------
Subject: cat /proc/ide/ide1/hdc/identify hangs
From:    "Jeroen Makkinje" <j.makkinje@xs4all.nl>
Date:    Wed, September 10, 2003 3:11 pm
To:      linux-ide@vger.kernel.org
---------------------------------------------------------------


My problem is simple:

cat /proc/ide/ide1/hdc/identify
does hang in version linux.2.6.0-test5
but it does not hang in version
./linux.2.4.20-4GB that comes default
with SuSE 8.2.

cat /proc/ide/ide1/hdc/capacity sometimes
also hangs but not reproducable.

I have executed the script ./gen_err
(given below) to generate some information
while running each of the kernel version.

The output files are put in:
http://www.xs4all.nl/~makkij/error_report/


I did remove "hdc=ide-scsi" from
the grub conf file. This had no effect.

I hope you can assist me. Either to
fix the problem or to  generate more infor-
nation.

The original posting is posted to
linux-ide@vger.kernel.org

I have send a copy to Andi Kleen
He reported a similar problem
with subject "taskfile merge breaking suse hwscan"



==========
./gen_err:
==========

#!/bin/bash
rm -i *
dmesg > dmesg
(strace -v cat /proc/ide/ide1/hdc/identify ) &> strace_identify
(strace -v cat /proc/ide/ide1/hdc/capacity ) &> strace_capacity
cat /proc/ide/ide1/hdc/driver > driver
cat /proc/ide/ide1/hdc/media > media
cat /proc/ide/ide1/hdc/model > model
cat /proc/ide/ide1/hdc/settings > settings
sh
/home/jeroenm/Documents/kernels/linux-2.6.0-test4/scripts/ver_linux
> ver_linux
cat /proc/version > version
cat /proc/cpuinfo > cpuinfo
cat /proc/modules > modules
cat /proc/ioports > ioports
lspci -vvv > lspci
cat /proc/scsi/scsi > scsi
cat /boot/grub/menu.lst > bootloader
cat /proc/ide/sis > sis
cat /proc/ide/drivers > drivers





-- 
Jeroen Makkinje
Pascalsingel 10
1277 EL Huizen
035-5257431
-----------------------------
j.makkinje@xs4all.nl
fam.makkinje@hccnet.nl
j.makkinje@chem.uu.nl
