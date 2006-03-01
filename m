Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030191AbWCALeH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030191AbWCALeH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 06:34:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030187AbWCALeG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 06:34:06 -0500
Received: from web33307.mail.mud.yahoo.com ([68.142.206.122]:15501 "HELO
	web33307.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030191AbWCALeF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 06:34:05 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=EMIxP4eTecR0xYbfMeUK++5tOb8Z3/kjFGHyOoGwjGOPOGL+oK55421tsa3hMUNvBV8JiJHdVqrSiYTM3tX/T9vhsrq3KeBj6hwjgTahXIdkwYQM1QsGHRjnasNaSxD5basNmtje0reXUaJqraerHErYb6lUn/GDPk/frgLoRIs=  ;
Message-ID: <20060301113404.83641.qmail@web33307.mail.mud.yahoo.com>
Date: Wed, 1 Mar 2006 03:34:04 -0800 (PST)
From: li nux <lnxluv@yahoo.com>
Subject: kexec x86_64: VFS: Cannot open root device, kernel panic
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On x86_64 I am trying out kexec/kdump
The root fs is reiserfs
 
1. Boot the current kernel with crashkernel=64M@16M 
 
2. # cat /proc/cmdline
root=/dev/cciss/c0d0p5 selinux=0
resume=/dev/cciss/c0d0p3  splash=silent numa
=off crashkernel=64M@16M
3. Preload the capture kernel using
kexec --load-panic /boot/vmlinux-2.6.16-rc4-3-kdump
--args-linux --append="root=
/dev/cciss/c0d0p5 selinux=0 resume=/dev/cciss/c0d0p3
splash=silent numa=off"
 
4. force  a panic echo c > /proc/sysrq-trigger
 
While booting the capture kernel, it panics with the
following message:
 
VFS: Cannot open root device "cciss/c0d0p5" or
unknown-block(0,0)
Please append a correct "root=" boot option
Kernel panic - not syncing: VFS: Unable to mount root
fs on unknown-block(0,0)
 
1. When the capture kernel boots what happens to the
io/nw drivers and any other modules which were
inserted into the first kernel
2. Is there anything wrong with the steps I followed
 
-lnxluv

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
