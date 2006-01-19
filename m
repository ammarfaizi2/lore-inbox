Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751345AbWASRMa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751345AbWASRMa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 12:12:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751367AbWASRMa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 12:12:30 -0500
Received: from smtpout.mac.com ([17.250.248.44]:13809 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1751345AbWASRM3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 12:12:29 -0500
In-Reply-To: <BAY109-F267E92D32B75385FDB680DD61C0@phx.gbl>
References: <BAY109-F267E92D32B75385FDB680DD61C0@phx.gbl>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <B40C4DF6-C8D1-4B88-AB92-6C13F0500DD8@mac.com>
Cc: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: RAID 5+0 support
Date: Thu, 19 Jan 2006 12:12:15 -0500
To: govind raj <agovinda04@hotmail.com>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 19, 2006, at 11:52, govind raj wrote:
> Hi all,
>
> We are using EVMS 2.5.4 on Linux 2.6.12.6 kernel version.
>
> We find that kernel modules are available for RAID0, 1, 5, 1+0 as  
> part of this kernel. But however, we do not find a similar module  
> available for RAID 5+0. Can someone advise us of how we would be  
> able to get this support added into the kernel? If this is not  
> required as a kernel module, how do we create a RAID 5+0 using MD?

Raid math:
RAID(5+0) == RAID(5) + RAID(0)

Commands:

mdadm --create /dev/md0 --level=5 --raid-devices=3 /dev/sda /dev/sdb / 
dev/sdc
mdadm --create /dev/md1 --level=5 --raid-devices=3 /dev/sdd /dev/sde / 
dev/sdf
mdadm --create /dev/md3 --level=0 --raid-devices=2 /dev/md0 /dev/md1

I believe this is all amply documented on a variety of md websites.

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/E/U d- s++: a18 C++++>$ ULBX*++++(+++)>$ P++++(+++)>$ L++++ 
(+++)>$ !E- W+++(++) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+ PGP 
+ t+(+++) 5 X R? !tv-(--) b++++(++) DI+(++) D+++ G e>++++$ h*(+)>++$ r 
%(--)  !y?-(--)
------END GEEK CODE BLOCK------



