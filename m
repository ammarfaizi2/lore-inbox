Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264854AbSKELTQ>; Tue, 5 Nov 2002 06:19:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264855AbSKELTP>; Tue, 5 Nov 2002 06:19:15 -0500
Received: from mta04ps.bigpond.com ([144.135.25.136]:12796 "EHLO
	mta04ps.bigpond.com") by vger.kernel.org with ESMTP
	id <S264854AbSKELTO>; Tue, 5 Nov 2002 06:19:14 -0500
Message-ID: <3DC7AACD.2060909@bigpond.com>
Date: Tue, 05 Nov 2002 22:26:05 +1100
From: Allan Duncan <allan.d@bigpond.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20021018
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.5.46 - missing symbol from binfmt_aout built as a module
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A new glitch since 2.5.45.

 From the "make modules_install":

if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.5.46; fi
depmod: *** Unresolved symbols in /lib/modules/2.5.46/kernel/fs/binfmt_aout.o
depmod: 	ptrace_notify
make: *** [_modinst_post] Error 1

And the relevant bit of .config:

#
# Executable file formats
#
CONFIG_KCORE_ELF=y
# CONFIG_KCORE_AOUT is not set
CONFIG_BINFMT_AOUT=m
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=m


