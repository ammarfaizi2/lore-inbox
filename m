Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263449AbTC2SGN>; Sat, 29 Mar 2003 13:06:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263451AbTC2SGN>; Sat, 29 Mar 2003 13:06:13 -0500
Received: from pimout2-ext.prodigy.net ([207.115.63.101]:53692 "EHLO
	pimout2-ext.prodigy.net") by vger.kernel.org with ESMTP
	id <S263449AbTC2SGM>; Sat, 29 Mar 2003 13:06:12 -0500
Message-ID: <3E85E35C.3090107@myrealbox.com>
Date: Sat, 29 Mar 2003 10:18:04 -0800
From: walt <wa1ter@myrealbox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; FreeBSD i386; en-US; rv:1.3b) Gecko/20030213
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.5.66-ac1  SCSI question for Alan
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

First, the Makefile in your patch still says 2.5.65-ac4.

Second, I'm still trying to untangle the ppa driver problem, and the
'ac' patches may be a clue.  What I see is that there is a significant
difference between the 'ac' kernels and Linus's kernels:

With Linus's kernels the ppa driver actually does work, although I get
a kernel oops and modprobe segfaults after loading ppa.

However, the 'ac' kernels don't work with the ppa module because the
sda4 device never appears in /dev, so naturally the Zip drive won't
mount properly (although the ppa module does load with the same oops).

The /dev/scsi/host0/bus0/target6/lun0 directory should contain entries
for 'disc' and 'part4' but with the 'ac' patches they don't appear.

Can you think of any reason that the 'ac' patches would have this
effect?

Thanks.



