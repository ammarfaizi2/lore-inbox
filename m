Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129027AbRBGWN2>; Wed, 7 Feb 2001 17:13:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129053AbRBGWNS>; Wed, 7 Feb 2001 17:13:18 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:22534 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S129027AbRBGWNP>; Wed, 7 Feb 2001 17:13:15 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Jean-Eric Cuendet <Jean-Eric.Cuendet@linkvest.com>
Date: Thu, 8 Feb 2001 09:12:45 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14977.51293.147436.164522@notabene.cse.unsw.edu.au>
Cc: "'acl-devel@bestbits.at'" <acl-devel@bestbits.at>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Lock in with 2.4.1 and NFS
In-Reply-To: message from Jean-Eric Cuendet on Wednesday February 7
In-Reply-To: <B45465FD9C23D21193E90000F8D0F3DF68391C@mailsrv.linkvest.ch>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday February 7, Jean-Eric.Cuendet@linkvest.com wrote:
> 
> Hi,
> I have a strange problem on one of our server.
> I have 2.4.1 patched with ACLs 0.7.5 (from acl.bestbits.at) and some RAID +
> LVM volumes.
> At regular interval, NFS stops working (nfsd stops) and a stop/start of the
> NFS service doesn't work. 
> The NFS service stop blocks in "exportfs -auv" when trying to unmount a
> client working apparently well. One time
> it was a solaris 2.6 client, another time it was a linux 2.4 machine.
> Any help appreciated.
> Thanks
> -jec
> 
> PS: I'm not in the kernel list. Please CC
> 

This scenario sounds a lot like one of the nfsd threads has oopsed
while holding a readlock on the export table, and so exportfs cannot
get a write lock.

Could you check your kernel logs for an Oops message?

NeilBrown


> 
> _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 
> Jean-Eric Cuendet
> Linkvest SA
> Av des Baumettes 19, 1020 Renens Switzerland
> Tel +41 21 632 9043  Fax +41 21 632 9090
> http://www.linkvest.com  E-mail: jean-eric.cuendet@linkvest.com
> _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 
> 
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
