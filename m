Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268274AbUJSBUh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268274AbUJSBUh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 21:20:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268270AbUJSBUf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 21:20:35 -0400
Received: from ns1.g-housing.de ([62.75.136.201]:6885 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S268251AbUJSBTu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 21:19:50 -0400
Message-ID: <41746BB1.3030405@g-house.de>
Date: Tue, 19 Oct 2004 03:19:45 +0200
From: Christian <evil@g-house.de>
User-Agent: Mozilla Thunderbird 0.6+ (Windows/20041008)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: VFS: Busy inodes after unmount. Self-destruct in 5 seconds.  Have
 a nice day... (2.6.9-rc3)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

during the last days i noticed that my box is using a lot of swap 
memory. it does the same things as every time, perhaps some application 
is leaking memory, i don't know / will examine. then i was away a few 
days and back again i found a partition of mine unmounted. in my syslog 
i noticed this message:

VFS: Busy inodes after unmount. Self-destruct in 5 seconds.  Have a nice 
day...

i *think* this is the message just before unmounting the fs, but the OOM 
event was hours before, as the (slightly edited) log says:

http://www.nerdbynature.de/bits/sheep/2.6.9-rc3/messages.log
(the VFS warning is at the end)

maybe someone could have a look at it and explain to me what happened here?

this is all on debian/unstable, vanilla 2.6.9-rc3 compiled with 3.4.2, 
loop-aes modules loaded. the said fs which was (un)mounted is this:

/dev/hda1 on /data/Media type ext3 
(rw,noexec,nosuid,nodev,noatime,loop=/dev/loop5,\
gpgkey=/root/keys/hda1.gpg,encryption=twofish128)

evil@sheep:~$ free -m
              total   used   free     shared    buffers     cached
Mem:           250   210      40          0          2         67
-/+ buffers/cache:   139     110
Swap:          766   662     103


thank you,
Christian.

-- 
BOFH excuse #312:

incompatible bit-registration operators
