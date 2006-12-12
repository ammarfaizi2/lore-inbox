Return-Path: <linux-kernel-owner+w=401wt.eu-S932235AbWLLRUh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932235AbWLLRUh (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 12:20:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932242AbWLLRUh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 12:20:37 -0500
Received: from an-out-0708.google.com ([209.85.132.248]:36132 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932235AbWLLRUg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 12:20:36 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Zumjxqwf6W55oLcCXcTlUZW8Shl4W7w0EFKZASetfnxzIyBPd+Sn5TJaKiDMVmMyJFYxkJHeC5RLhD3LqG/vIiJzIZXggYoQCN4A5pgvflnRkWibZD+QZLGQZneJgiEzAKIXRU4AY3tTUW+TarbaWJ2mKwFBL0WNLOzZHjf3o1Q=
Message-ID: <bc36a6210612120920h283c2d81q137bb9698a0cefb5@mail.gmail.com>
Date: Tue, 12 Dec 2006 10:20:35 -0700
From: "Andrew Robinson" <andrew.rw.robinson@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: 2.6.19 is not stable with SATA and should not be used by any means
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, Linux has finally completely let me down. 2.6.19 completely and
irrevocably corrupted my file system. The inclusion of the
experimental E-ATA drivers as a replacement for the SATA drivers was a
horrible idea and I find myself wanting to curse the decision maker.
Why this was done in 2.6.x and not in 2.7, I don't know.

Here is the background on the corruption:
EPoX 9npa + Ultra mother board (NVIDIA nForce4 + Ultra chipset)
SATA 2 Samsung drive

Kernel 2.6.19
Hibernate 1.94-2
ReiserFS
Debian Etch

I was running fine for a while on 2.6.17.11, but there was a small bug
with the wakeonlan with the NVIDIA chipset. So I got the latest stable
kernel from kernel.org, used my config, rebuilt it and failed to boot
-- no hard drive.

So I went back into config, and saw that the SATA drivers were gone,
replaced by experimental EATA drivers. Not seeing any way to continue
to use the sata_nv without these EATA drivers, I went ahead and used
those settings.

After rebooting fine, I went into disk hibernation. When I restored
from hibernate my file system was corrupt. After running fsck.reiserfs
it wanted me to do the dreaded "--rebuild-tree". So after a limited
backup of the files I could get to, I ran this, and now the file
system is complete destroyed (there are no init levels left).

I will be rebuilding my computer as a result thanks to this. Of course
I will not be using 2.6.19 again.

Could someone enlighten me why hard drive drivers that are
experimental were put into a "stable" kernel version? Also, did I miss
something, is there a way to run the SATA and not EATA drivers in
2.6.19 or were the ones that work removed completely? Unfortunately,
it seems like linux developers don't use the NVIDIA chipset much as
this link shows:
http://linux-ata.org/driver-status.html#nvidia

Looks like Linux developers prefer the overpriced and under powered
Intel chips instead unfortunately.

Thanks for any help that you can provide.




PS - sorry if there are two copies of this email, I incorrectly send
one to the digest email address, I am not sure if that is sent to the
list
