Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261215AbVAQPI0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261215AbVAQPI0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 10:08:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261264AbVAQPHk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 10:07:40 -0500
Received: from strutmasters.com ([161.58.166.59]:51464 "EHLO strutmasters.com")
	by vger.kernel.org with ESMTP id S261215AbVAQPHd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 10:07:33 -0500
Message-ID: <41EBD4E8.70905@strutmasters.com>
Date: Mon, 17 Jan 2005 10:08:24 -0500
From: Brian Henning <brian@strutmasters.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: smbfs in 2.6.8 SMP kernel
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

   I've just rebuilt my 2.6.8 kernel to enable SMP for my dual Xeons. 
Everything seems to work great, except now smbfs is broken.  If I boot 
the non-SMP kernel, smbfs works perfectly; however, if I boot the SMP 
kernel, most file creations/modifications in smbfs-mounted directories 
hang for a long time and end with errors such as the following example:

/home/me/smb/mounted/dir: $ touch testfile
touch: setting times of `testfile': Input/output error
/home/me/smb/mounted/dir: $ rm testfile
/home/me/smb/mounted/dir: $ echo "Hello, Dave." | cat > testfile
/home/me/smb/mounted/dir: $ cat testfile
Hello, Dave.
/home/me/smb/mounted/dir: $ echo "I'm scared, Dave." | cat > testfile
bash: testfile: Input/output error
/home/me/smb/mounted/dir: $ cat testfile
/home/me/smb/mounted/dir: $ ls -l testfile
-rwxr--r--  1 me root 0 2005-01-17 09:50 testfile

Now that I am aware of the problem, I know to avoid triggering it, but 
imagine my dismay when, after attempting to save an edited file, I found 
that its size had been reduced to zero!

   I'm a kernel-building newbie, so I'm sure my problem is due to me 
overlooking something.  I tried building smbfs into the kernel, but that 
made no difference.  I'd be ever thankful if someone would point me in 
the right direction, as I would certainly enjoy fully using my 
processors while also being able to use smbfs.

Other potentially pertinent data:
Distro: Debian Sarge
Kernel Version: 2.6.8 custom
Arch: Xeon-HT/EMT (x2)

Thanks in advance!
Regards,
~Brian
