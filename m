Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268693AbUIHQ3O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268693AbUIHQ3O (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 12:29:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268698AbUIHQ3O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 12:29:14 -0400
Received: from mail.gmx.de ([213.165.64.20]:12766 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S268693AbUIHQ3K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 12:29:10 -0400
X-Authenticated: #7369570
From: Alexej Davidov <alexej.davidov@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: smbfs errors
Date: Wed, 8 Sep 2004 18:29:04 +0200
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200409081829.04807.alexej.davidov@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I can't mount shares of some servers since I use kernel 2.6.x. As it works 
with smbclient and also with smbmount on kernel 2.4.x, I assume the problem 
lies within smbfs.

Kernel version: 2.6.8.1
Samba version: 3.0.4
Dist: Debian unstable

I get errors when I try to mount a share from OS/2 4.0:

1) smbmount
everything's fine

2) cd into the mounted dir
smbfs output:
  smb_setup_bcc: Packet too large 4257>4096
  smb_add_request: request [f7298e80, mid=0] timed out! 

3) ls in the mounted dir
smbfs output:
  smb_receive_header: short packet: 0
  smb_add_request: request [f7353e80, mid=1] timed out!
Then ls says: ls: .: Input/output error

4) cd ..
smbfs output:
  smb_get_length: Invalid NBT packet, code 39
  smb_add_request: request [f736be80, mid=2] timed out!

5) umount
everything's fine


Also, it's not possible to mount a share from a server running Samba 3.0.6 on 
Suse with kernel 2.4.21. I get ``smb_add_request: request[xxxxxxx, mid=x] 
timed out!'' all the time, and this time also already when when I try to 
mount.

I can mount shares, however, from other systems, namely all Windows versions 
and OS/2 3.0

If it is of any help, I could also supply samba logs and tcpdump dumps.

Btw: I tried to enable SMBFS_DEBUG and SMBFS_DEBUG_VERBOSE in smbfs' Makefile, 
but that didn't change anything.

Thanks in advance
Alexej

Please cc to my address, as I'm not subscribed to this list.
