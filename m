Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262035AbUDXHho@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262035AbUDXHho (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Apr 2004 03:37:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262043AbUDXHho
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Apr 2004 03:37:44 -0400
Received: from zasran.com ([198.144.206.234]:19328 "EHLO zasran.com")
	by vger.kernel.org with ESMTP id S262035AbUDXHhm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Apr 2004 03:37:42 -0400
Message-ID: <408A1945.1030506@bigfoot.com>
Date: Sat, 24 Apr 2004 00:37:41 -0700
From: Erik Steffl <steffl@bigfoot.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040413 Debian/1.6-5
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: udev and /dev/sda1 not found during boot (it's there right after
 boot)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   just moved to udev and everything seems to be working OK except of 
SATA drive (visible as /dev/sda1) when fsck checks it during boot (it 
works fine right after that).

   all the required modules (as far as I can tell) are in /etc/modules. 
I  see the modules loading and right after the modules are loaded fsck 
starts. It checks /dev/hdb6 (root) and it goes on to check /dev/sda1 and 
complains that there is no such file. At that point I get a choice to 
enter root password for maintenance or ctrl-d to continue booting.

   enter root password: I get command prompt, check the /dev/sda1, it's 
there, I can do fsck or mount it

   ctrl-d: boot continues as usual, /dev/sda1 is mounted

   any ideas how to fix this? is it a timing issue (udev didn't create 
device yet but fsck is already trying to use it)?

   system:

   debian unstable
   kernel 2.6.5
   udev 0.024

/etc/modules:
ip_tables
# -------------- scsi
sd_mod
sr_mod
ide-scsi
sg
scsi_transport_spi
# -------------- cdrom
ide-cd
# -------------- alsa
snd_emu10k1

   TIA

	erik
