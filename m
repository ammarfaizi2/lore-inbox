Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272549AbTGZRAX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 13:00:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272554AbTGZRAW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 13:00:22 -0400
Received: from icemserv.folkwang-hochschule.de ([193.175.156.129]:7439 "EHLO
	icemserv.folkwang-hochschule.de") by vger.kernel.org with ESMTP
	id S272549AbTGZRAS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 13:00:18 -0400
Date: Sat, 26 Jul 2003 19:15:27 +0200
From: Orm Finnendahl <finnendahl@folkwang-hochschule.de>
To: linux-kernel@vger.kernel.org
Subject: make menuconfig and 2.4.22-pre8
Message-ID: <20030726171527.GA1173@finnendahl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
X-Operating-System: Linux
Organization: Folkwang-Hochschule, Essen, Germany
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I can't make menuconfig with a 2.4.22-pre8 Kernel.

This is what I did:

grisey:/usr/src# tar -xjf ~orm/install/linux-2.4.21.tar.bz2 
grisey:/usr/src# rm -f linux
grisey:/usr/src# ln -s linux-2.4.21 linux
grisey:/usr/src# patch -p0 < patch-2.4.22-pre8 2>&1 \
> patch-2.4.22-pre8.log
grisey:/usr/src# cd linux
grisey:/usr/src/linux# make menuconfig
rm -f include/asm
( cd include ; ln -sf asm-i386 asm)
make -C scripts/lxdialog all
make[1]: Entering directory `/usr/src/linux-2.4.21/scripts/lxdialog'
make[1]: Leaving directory `/usr/src/linux-2.4.21/scripts/lxdialog'
/bin/sh scripts/Menuconfig arch/i386/config.in
Using defaults found in .config
Preparing scripts: functions, parsing

<...> 

(about 3 minutes of awk and kswapd constantly swapping, making the
whole system extremely unresponsive)

and then:

Beendet
Awk died with error code 143. Giving up.
make: *** [menuconfig] Fehler 1
grisey:/usr/src/linux#   


With the vanilla kernel 2.4.21 there are no problems at all.

Anybody interested in the patch log?

--
Orm
