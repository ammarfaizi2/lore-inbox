Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262497AbVF2VKO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262497AbVF2VKO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 17:10:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262639AbVF2VKO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 17:10:14 -0400
Received: from postfix3-2.free.fr ([213.228.0.169]:54471 "EHLO
	postfix3-2.free.fr") by vger.kernel.org with ESMTP id S262497AbVF2VEB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 17:04:01 -0400
Message-ID: <42C30CBC.5030704@free.fr>
Date: Wed, 29 Jun 2005 23:03:56 +0200
From: Eric Valette <eric.valette@free.fr>
Reply-To: eric.valette@free.fr
Organization: HOME
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: linux-kernel@vger.kernel.org, greg@kroah.com
Subject: updating kernel to 2.6.13-rc1 from 2.6.12 + CONFIG_DEVFS_FS + empty
 /dev
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For years now my /dev has been empty. When upgrading to 2.6.13-rc1 from
2.6.12, and updating my kernel config file via "make oldconfig" I got no
visible warning about CONFIG_DEVFS_FS options being set (or at least did
no see it).

The result, however, was *for sure* a non functionnal system and adding
udev as a defvs replacement will of course not help as I understand this
kernel needs *anyway* a minimal filesystem to boot.

While I do not want to re-enter the endless devfs versus udev merit
(allthough I personnaly strongly believe udev is just too slow for
embedded system boot compared to devfs without devfsd) I think that this
potential problem should be clearly mentionned  in the release note for
2.6.13 or at least something like "a minimal devfs able to boot emty
/dev installation" be integrated as a replacement.

For the rest of the problem, I will just waste some inodes to have a
minimal /dev back (which I think is a clear regression).

This mail intend to point out that removing a feature in the stable
series can break existing "real life" installations which, by the way,
did not break as badly as that for years. It sometimes broke using -mm
stuffs but was just a matter of waiting for a patch. I will not get a
patch for my problem.

No flame intended just feed back from end-user experience.

-- eric

