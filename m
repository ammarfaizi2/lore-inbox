Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136693AbREHEQZ>; Tue, 8 May 2001 00:16:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136740AbREHEQQ>; Tue, 8 May 2001 00:16:16 -0400
Received: from 200191137058-dial-user-UOL.acessonet.com.br ([200.191.137.58]:62626
	"EHLO pervalidus.dyndns.org") by vger.kernel.org with ESMTP
	id <S136693AbREHEP6>; Tue, 8 May 2001 00:15:58 -0400
Date: Tue, 8 May 2001 01:16:10 -0300
From: =?iso-8859-1?B?RnLpZOlyaWMgTC4gVy4=?= Meunier <0@pervalidus.net>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: EXT2-fs error with 2.4.4 (using CVS)
Message-ID: <20010508011610.P15636@pervalidus>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.18i
X-Mailer: Mutt/1.3.18i - Linux 2.4.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi. I received the following error while updating my Mozilla
sources from MOZILLA_0_8_1_20010326_RELEASE to
MOZILLA_0_9_RELEASE via CVS:

==> /var/log/syslog <==
May  8 00:25:52 pervalidus kernel: EXT2-fs error (device ide0(3,3)): ext2_readdir: bad entry in
directory #162813: directory entry across blocks - offset=92, inode=451111, rec_len=16404,
name_len=9
May  8 00:25:52 pervalidus kernel: EXT2-fs error (device ide0(3,3)): ext2_readdir: bad entry in
directory #162813: directory entry across blocks - offset=92, inode=451111, rec_len=16404,
name_len=9

When CVS finished, I received the following error:

May  8 01:11:29 pervalidus kernel: EXT2-fs error (device ide0(3,3)): ext2_readdir: bad entry in
directory #162813: directory entry across blocks - offset=92, inode=451111, rec_len=16404,
name_len=9
May  8 01:11:29 pervalidus kernel: EXT2-fs error (device ide0(3,3)): ext2_readdir: bad entry in
directory #162813: directory entry across blocks - offset=92, inode=451111, rec_len=16404,
name_len=9

And the following CVS message:

cvs checkout: cannot remove
mozilla/xpinstall/wizard/windows/nszip: No such file or
directory

When I tried to access
/usr/local/src/CVS/X/mozilla/xpinstall/wizard/windows/ I got
the same EXT2-fs error messages.

The partition is /usr/local/src
(/dev/ide/host0/bus0/target0/lun0/part3)

Is this some sort of ext2 fs corruption or what ? I booted with
2.4.4 9 days ago, and there were no problems with fsck.

checkout start: Tue May 8 00:22:40 BRT 2001
checkout finish: Tue May 8 01:11:31 BRT 2001

My .config is at http://www.pervalidus.net/.config-2.4.4.txt
dmesg at http://www.pervalidus.net/dmesg-2.4.4.txt

-- 
0@pervalidus.{net, {dyndns.}org} Tel: 55-21-717-2399 (Niterói-RJ BR)
