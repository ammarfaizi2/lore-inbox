Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129072AbRBFMfv>; Tue, 6 Feb 2001 07:35:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129118AbRBFMfl>; Tue, 6 Feb 2001 07:35:41 -0500
Received: from thebsh.namesys.com ([212.16.0.238]:3602 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S129072AbRBFMfh>; Tue, 6 Feb 2001 07:35:37 -0500
Message-ID: <3A7FE803.98740090@namesys.com>
Date: Tue, 06 Feb 2001 15:03:15 +0300
From: Hans Reiser <reiser@namesys.com>
Organization: Namesys
X-Mailer: Mozilla 4.74 [en] (X11; U; Linux 2.2.14 i686)
X-Accept-Language: en, ru
MIME-Version: 1.0
To: Wenzhuo Zhang <wenzhuo@zhmail.com>
CC: reiserfs-list@namesys.com, linux-kernel@vger.kernel.org
Subject: Re: [reiserfs-list] mongo.sh 2.2.18: do_try_to_free_pages failed ...
In-Reply-To: <20010206102048.A816@zhmail.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wenzhuo Zhang wrote:
> 
> Hi,
> 
> I got the VM error "VM: do_try_to_free_pages failed for mongo_read..."
> and then I couldn't log into the system, when stress testing
> reiserfs+raid0 setup on a 2.2.18 box using the reiserfs benchmark
> mongo.sh. The problem was reporduceable on each run of mongo.sh.
> 
> ./mongo.sh reiserfs /dev/md0 /mnt/testfs raid0-rfs 3
> 
> Thinking the raid code might cause the problem, I tested on reiserfs
> only, but I got the same error message. Later, I found the same
> problem running mongo.sh on an ext2 partition (stock kernel without
> any patches).
> 
> I guess this problem is not reiserfs specific. What can I do now to
> solve the problem?
> 
> Here is the hardware configuration of my test box:
> PIII 600, 256M, Adaptec AIC-7896 SCSI controller, two Quantum SCSI
> disks.
> 
> Regards,
> --
> Wenzhuo

Honestly, the best thing to do is to upgrade to 2.4.1.  VM on 2.2.recent is
not in good condition, and reiserfs exacerbates it.  

Hans
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
