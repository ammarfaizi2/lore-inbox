Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272484AbRH3VS4>; Thu, 30 Aug 2001 17:18:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271147AbRH3VSo>; Thu, 30 Aug 2001 17:18:44 -0400
Received: from ns.roland.net ([65.112.177.35]:30219 "EHLO earth.roland.net")
	by vger.kernel.org with ESMTP id <S272474AbRH3VRz>;
	Thu, 30 Aug 2001 17:17:55 -0400
Message-ID: <3B8EADF1.4030100@roland.net>
Date: Thu, 30 Aug 2001 16:19:45 -0500
From: Jim Roland <jroland@roland.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010808
X-Accept-Language: en-us
MIME-Version: 1.0
To: Venkatesh Ramachandran <rvenky@cisco.com>
CC: linux-users@cisco.com, linux-kernel@vger.kernel.org,
        linux-alpha@vger.kernel.org, brussels-linux@cisco.com,
        Mathangi Kuppusamy <mathangi@cisco.com>
Subject: Re: Linux Mounting problem
In-Reply-To: <3B8E5791.5BBE92A2@cisco.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It will enter maintenance mode if fsck was unable to fix errors as a 
previous boot-up.  Boot with your RH71 cd, enter "linux rescue" at the 
"boot:" prompt, and your system will be mounted under /mnt/sysimage.  It 
may delay for a little while while coming up if it's re-running fsck. 
 After you have a prompt (navigate throught the text dialog boxes 
first), run fsck and you can fix the partition or inode errors.

Regards,
Jim Roland, RHCE


Venkatesh Ramachandran wrote:

>Hello,
>   I am using Redhat Linux 7.1
>   During reboot, i get the message " Mounting / as readonly"
>   And, it enters into maintenance mode...( & all other steps fail -
>/proc not mounted, swap not mounted, fsck fails)
>   I did the following :
>   mount -t proc proc /proc
>   fsck /dev/hda1
>   The following error messages : ERROR : Couldn't open /dev/null
>(Read-only file system)
>
>   It goes into a never-ending loop, and never i am able to recover from
>this problem.
>
>   Has anyone come across such a problem? How to tackle it?
>   Do we need to use a bootdisk, to get into the read-write mode of root
>filesystem ?
>   How to change root filesystem from read-only to read-write?
>
>   This will be of very great help to me and my team.
>
>Thanks in advance,
>Venkatesh.
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>


