Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277738AbRKVMRu>; Thu, 22 Nov 2001 07:17:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277861AbRKVMRk>; Thu, 22 Nov 2001 07:17:40 -0500
Received: from pat.uio.no ([129.240.130.16]:37302 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S277738AbRKVMRc>;
	Thu, 22 Nov 2001 07:17:32 -0500
To: Stephane Brossier <stephane.brossier@sun.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problem when using a nfs mounted filesystem.
In-Reply-To: <3BFC3CD8.3B955DA8@sun.com>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 22 Nov 2001 13:17:26 +0100
In-Reply-To: <3BFC3CD8.3B955DA8@sun.com>
Message-ID: <shslmgzgfu1.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Stephane Brossier <stephane.brossier@sun.com> writes:

     > [root@localhost mnt]# mount -t nfs -o "hard,intr,nodev,nosuid"
     > hats105:/export1 /mnt/export1

<snip>

     > Everything seems OK for a while since I can access any
     > directory/file under /mnt/export1. Suddenly, after a few
     > minutes, I cannot access anymore this file system. All my
     > programs which where using these filesystems are frozen and I
     > they dont even receive any signals. I cannot umount this
     > filesystem neither. I checked the nfs server is still up and
     > running so the problem seems to come from the client side.

Usually, when this happens, it is due to some problem in the
networking driver. A tcpdump should show what is happening when the
filesystem hangs.

Please also
   - check the connection between the client and server. In particular
     switch settings.
   - Check if reducing r/wsize helps.


Cheers,
   Trond
