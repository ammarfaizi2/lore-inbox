Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263875AbUG1VQX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263875AbUG1VQX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 17:16:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263943AbUG1VQW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 17:16:22 -0400
Received: from scrye.com ([216.17.180.1]:57754 "EHLO mail.scrye.com")
	by vger.kernel.org with ESMTP id S263875AbUG1VQU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 17:16:20 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date: Wed, 28 Jul 2004 15:16:13 -0600
From: Kevin Fenzi <kevin-kernel@scrye.com>
To: linux-kernel@vger.kernel.org
Subject: pmdisk/swsusp 2.6.8-rc2-mm1 success
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Message-Id: <20040728211616.A6C36894D7@voldemort.scrye.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


ok. Compiling without preempt and no highmem support and using the
echo 'shutdown' > /sys/power/disk
I managed to do some suspend/resume cycles. 

Some impressions: 

The status display is very ugly. It prints cryptic items and lots of
random .... and | that don't mean much to me. ;) 
It would be nice if it could just give a % age complete or a spinning
cursor to indicate its doing something. 

It's a good deal slower than software suspend2. Is there any plans to
add in the LZO compression that software suspend2 uses? 

With software suspend 2 I usually can do an entire suspend/resume
cycle in about 30 seconds. Thats from prompt to prompt. 

With swsup1/pmdisk (should I just call it swsusp1 now?) It looks like
it takes about 2.5 minutes to do a cycle from prompt to prompt. 

On resume there is a inital part where the display just sits there. I
wasn't sure if it was hung or not, but it was just calculating. It
would be nice if it could provide a 'this might take a while' or a
spinning cursor or status bar to let you know it's not dead. 

There aren't any bootup messages to indicate that it's
available. Would it be possible to add something like: 
swsusp1: will use /dev/hda2 to resume. 
swsusp1: /dev/hda2 is regular swap space. Continuing to boot. 

kevin
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Processed by Mailcrypt 3.5.8 <http://mailcrypt.sourceforge.net/>

iD8DBQFBCBeg3imCezTjY0ERAm5oAJ9xzR1Pd6z8xH/VlS4LU9QNKLy7fgCfY7SR
27v7FeEaFch662gB73jEZuk=
=E4nz
-----END PGP SIGNATURE-----
