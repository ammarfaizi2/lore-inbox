Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132450AbQL2WCs>; Fri, 29 Dec 2000 17:02:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132480AbQL2WCi>; Fri, 29 Dec 2000 17:02:38 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:30984 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S132450AbQL2WCS>; Fri, 29 Dec 2000 17:02:18 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Frank.Olsen@stonesoft.com
Date: Sat, 30 Dec 2000 08:30:48 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14925.648.59562.676754@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Bugs in knfsd -- Problem re-exporting an NFS share
In-Reply-To: message from Frank.Olsen@stonesoft.com on Friday December 29
In-Reply-To: <OFC9E1D243.E23DCAED-ONC12569C4.005FB1E8@stonesoft.com>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday December 29, Frank.Olsen@stonesoft.com wrote:
> Hi -- could you please CC me if you reply to this mail.
> 
> My problem is that I get an error when setting up the following
> configuration:
> 
> A:     /exports/A                                 - Redhat 7.0
> B1/B2: mount /exports/A on /export/A from A       - Redhat 6.2
> C:     mount /exports/A on /mnt/A from B1 or B2   - Redhat 6.2
> 
> I use knfsd/nfs-utils on each machine.
> 
> bash# ls /mnt/A
> /mnt/A/A.txt: No such file or directory
> 

This is not a supported configuration.  You cannot export NFS mounted
filesystems with NFS. The protocol does not cope, and it
implementation doesn't even try.
NFS is for export local filesystems only.

> 
> I searched for a while on deja.com, and there seemed to be some indications
> that knfsd was bugged and that using the user-mode code would work.
> However, no one replied specifically to my message, so I'm still not sure.
> 
> BTW, what I tried to do was to set up a HA configuration of machines B1/B2
> using A as a "shared disk".
> This is just to try out the HA software without buying more
> hardware.

Try "nbd" the network block device.  That should be able to give a
more realistic imitation of a share disk.

NeilBrown


> 
> Thanks in advance for any help!
> 
> Best regards,
> Frank Olsen
> 
> PS Happy new year!
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
