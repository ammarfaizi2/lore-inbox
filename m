Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279242AbRKIFI0>; Fri, 9 Nov 2001 00:08:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279261AbRKIFIQ>; Fri, 9 Nov 2001 00:08:16 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:17908
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S279242AbRKIFII>; Fri, 9 Nov 2001 00:08:08 -0500
Date: Thu, 8 Nov 2001 20:42:10 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: linux-kernel@vger.kernel.org
Subject: Modutils can't handle long kernel names
Message-ID: <20011108204210.A514@mikef-linux.matchmail.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I've gotten into the habbit of adding the names of the patches I add to my
kernel to the extraversion string in the top level Makefile in my kernels.

Here's my latest example:
VERSION = 2
PATCHLEVEL = 4
SUBLEVEL = 15
EXTRAVERSION=-pre1+freeswan-1.91+xsched+netdev_random+ext3-0.9.15-2414+ext3-mem_acct+elevator

Unfortunately, with this long kernel version number, modutils (I've noticed
depmod and modutils so far...) choke on it.

depmod:
depmod: Can't open /lib/modules/2.4.15-pre1+freeswan-1.91+xsched+netdev_random+ext3-0.9.15-2414+e#1 SMP Thu Nov 8 20:18:04 PST 2001/modules.dep for writing

uname -r:
2.4.15-pre1+freeswan-1.91+xsched+netdev_random+ext3-0.9.15-2414+e#1 SMP Thu Nov 8 20:18:04 PST 2001

uname -a:
Linux mikef-linux.matchmail.com 2.4.15-pre1+freeswan-1.91+xsched+netdev_random+ext3-0.9.15-2414+e#1 SMP Thu Nov 8 20:18:04 PST 2001 #1 SMP Thu Nov 8 20:18:04 PST 2001 i686 unknown

Yep, I know, "don't do that!".  Still, can this be fixed easily, or is it
one of those things that kbuild 2.5 will fix, and make everything rosy and
do my laundry too?

TIA,

Mike
