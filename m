Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286816AbRL1KV4>; Fri, 28 Dec 2001 05:21:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286821AbRL1KVr>; Fri, 28 Dec 2001 05:21:47 -0500
Received: from nta-monitor.demon.co.uk ([212.229.78.70]:17935 "EHLO
	mercury.nta-monitor.com") by vger.kernel.org with ESMTP
	id <S286816AbRL1KVe>; Fri, 28 Dec 2001 05:21:34 -0500
Message-Id: <4.3.2.7.2.20011228101818.00aaa2c0@192.168.124.1>
Date: Fri, 28 Dec 2001 10:18:20 +0000
To: linux-kernel@vger.kernel.org
From: Roy Hills <linux-kernel-l@nta-monitor.com>
Subject: zImage not supported for 2.2.20?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm using linux kernel 2.2.20 on my systems.  This works fine as a
bzImage which most of my systems use, however one of my systems
(a Toshiba Tecra laptop) needs to use zImage, and I find that 2.2.20
does not work in this case, although previous versions e.g. 2.2.17 do.

When I look at the kernels with "file", I notice that the 2.2.20 kernel doesn't
report zImage/bzImage like the older kernels did.  2.2.20 also omits the
system that it was built on and the build date. E.g:

$ file /boot/vmlinuz-2.2.*
/boot/vmlinuz-2.2.19:     Linux kernel x86 boot executable bzImage, version 
2.2.19
  (root@mercury) #7 Fri No, RO-rootFS, root_dev=0x301, Normal VGA
/boot/vmlinuz-2.2.20:     Linux kernel x86 boot executable RO-rootFS, 
root_dev=0x3
01, Normal VGA

$ file --version
file-3.27
magic data from /etc/magic:/usr/share/misc/magic

I'm running Debian GNU/Linux 2.2r4 (potato) using monolithic kernels compiled
from source.

Is this the end of zImage support, or is there something else different 
about the
2.2.20 boot loading process that might be tickling the buggy hardware in my 
Tecra?

Regards,

Roy Hills
--
Roy Hills                                    Tel:   +44 1634 721855
NTA Monitor Ltd                              FAX:   +44 1634 721844
14 Ashford House, Beaufort Court,
Medway City Estate,                          Email: Roy.Hills@nta-monitor.com
Rochester, Kent ME2 4FA, UK                  WWW:   http://www.nta-monitor.com/

