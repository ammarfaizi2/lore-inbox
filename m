Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312931AbSDEO7v>; Fri, 5 Apr 2002 09:59:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312935AbSDEO7m>; Fri, 5 Apr 2002 09:59:42 -0500
Received: from orange.csi.cam.ac.uk ([131.111.8.77]:44020 "EHLO
	orange.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S312931AbSDEO72>; Fri, 5 Apr 2002 09:59:28 -0500
Message-Id: <5.1.0.14.2.20020405155322.01ff3b40@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Fri, 05 Apr 2002 15:59:33 +0100
To: vda@port.imtp.ilyichevsk.odessa.ua
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: [DEADLOCK] automount, kupdated: D state
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200204051319.g35DJXX25033@Port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 19:22 05/04/02, Denis Vlasenko wrote:
>I was saving my daily work on an IDE disk.
>I use automounter. On an attempt to mount it several processes
>got stuck in D state.
>
>kernel: 2.5.7 + new NTFS driver
>ps and ksymoopsed parts of Alt-Sysrq-T output are attached.
>ksymoops warnings trimmed except automount.dump.ksymoops
>(they were the same).

 From looking at the information supplied, NTFS doesn't seem to be 
involved. The processes seem to be stuck trying to write dirty buffers as 
well as in nfs and pipefs - buffers could never get dirtied by the current 
NTFS as it is entirely read-only.

btw. You had sent a problem report about cyrillic names with NTFS and I 
suggested to try the new NTFS driver but you never got back to me whether 
that fixed it or not... How is the new driver behaving? Are you stil seing 
problems or is everything working fine now?

Best regards,

Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
IRC: #ntfs on irc.openprojects.net / ICQ: 8561279
WWW: http://www-stu.christs.cam.ac.uk/~aia21/

