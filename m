Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261836AbTKBUta (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Nov 2003 15:49:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261837AbTKBUt3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Nov 2003 15:49:29 -0500
Received: from madrid10.amenworld.com ([62.193.203.32]:7693 "EHLO
	madrid10.amenworld.com") by vger.kernel.org with ESMTP
	id S261836AbTKBUt2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Nov 2003 15:49:28 -0500
Date: Sun, 2 Nov 2003 21:49:34 +0100
From: DervishD <raul@pleyades.net>
To: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Using proc in chroot environments
Message-ID: <20031102204934.GB54@DervishD>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4i
Organization: Pleyades
User-Agent: Mutt/1.4i <http://www.mutt.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi all :)

    I'm using a chroot environment on my main disk as a 'crash test
dummy', and I need to access the proc filesystem inside it. Since
hard links are not allowed for directories, the only solution I can
think of is to mount proc inside the chroot environment just after
chrooting. This works, I've tested, but I have two problems:

    - Any change in the chroot proc happens too in the main one (like
using /proc/sys/kernel variables). Not a big deal, since I want the
chroot environment to mimic the main filesystem where the original
proc is mounted, but is annoying.

    - I must mount copies of devpts, usbfs, etc... under the 'second'
proc, too, and this is even more annoying.

    The perfect solution for me is to hardlink the proc directory of
the chrooted environment to the proc directory on the true root dir,
but since this is not possible, whan can I do instead of remounting a
second copy of proc (which, by the way, makes /proc/mounts a little
bit weird...)?

    Thanks a lot in advance :))

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736
http://www.pleyades.net & http://raul.pleyades.net/
