Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261184AbVAAWSZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261184AbVAAWSZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jan 2005 17:18:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261192AbVAAWSZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jan 2005 17:18:25 -0500
Received: from scrye.com ([216.17.180.1]:29829 "EHLO mail.scrye.com")
	by vger.kernel.org with ESMTP id S261184AbVAAWSU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jan 2005 17:18:20 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date: Sat, 1 Jan 2005 15:18:12 -0700
From: Kevin Fenzi <kevin@tummy.com>
To: linux-kernel@vger.kernel.org
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Subject: Re: PATCH: scripts/package/mkspec
X-Draft-From: ("scrye.linux.kernel" 97489)
References: <20041231033323.1CBB4CB130@voldemort.scrye.com>
	<20041231104859.GI24603@wiggy.net>
Message-Id: <20050101221815.6D22172449@voldemort.scrye.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

>>>>> "Wichert" == Wichert Akkerman <wichert@wiggy.net> writes:

Wichert> Previously Kevin Fenzi wrote:
>> So, after installing the kernel rpm it checks for /sbin/mkinitrd
>> and makes an initrd file for the newly installed kernel rpm. It
>> also checks for a /sbin/new-kernel-package command and runs it on
>> the new kernel if it exists to add the new kernel/initrd to
>> grub/lilo.

Wichert> Why not use the same system as the Debian package uses? That
Wichert> runs everything in /etc/kernel/postinst.d/ after installing
Wichert> and everything in /etc/kernel/prerm.d/ before removing a
Wichert> package.

Wichert> That is much more flexible than hardcoding something like
Wichert> mkinitrd or new-kernel-package: it works on all architectures
Wichert> and gives the administratie full freedom to hook into things.

Humm... yeah, there would be some advantages to that kind of setup. 
Flexable, easier to add/remove things you want done on
install/uninstall. 

However, it seems like it would also be most vulnerable to security
issues. All an attacker needs to do is get a link/file into one of
those dirs and they could execute any commands they like. 

Also, seems like it would be harder to audit and see whats going to
happen on install/removal. 

Are a base set of commands/scripts provided by the kernel package? Or
do they come in some other package? 

Wichert> Wichert.

kevin
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Processed by Mailcrypt 3.5.8 <http://mailcrypt.sourceforge.net/>

iD8DBQFB1yGn3imCezTjY0ERAhJZAJ9J306nUzO03wXRrIjg5RCKptJbagCffKqV
3HIHMSWenBkhVSLlqictlUc=
=ccl2
-----END PGP SIGNATURE-----
