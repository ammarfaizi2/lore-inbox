Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290644AbSA3WBx>; Wed, 30 Jan 2002 17:01:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290641AbSA3WAZ>; Wed, 30 Jan 2002 17:00:25 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:11206 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S290643AbSA3WAD>; Wed, 30 Jan 2002 17:00:03 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Telford002@aol.com
Date: Thu, 31 Jan 2002 09:01:58 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15448.27990.234679.335765@notabene.cse.unsw.edu.au>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [NFS] Incompatibility with Solaris?
In-Reply-To: message from Telford002@aol.com on Wednesday January 30
In-Reply-To: <193.1d5ab9f.2989c093@aol.com>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday January 30, Telford002@aol.com wrote:
> I installed Suse 7.3 on my workstation and then exported the file
> system to a Solaris 2.6 x86 development station.
> 
> I executed a build/make script on the Solaris workstation in
> a directory tree on the NFS exported file system.
> 
> The build/make script creates some symbolic links during
> the build process.  I notice that the paths to the real
> file are sometimes trash.  I suspect some sort of RPC
> problem with symbolic links.  Build/make procedures
> that create no symbolic links have no problems.
> 
> The Suse 7.3 distribution uses a 2.4.10 kernel.
> I tried a 2.4.17 kernel.  I received a message
> on the Solaris console that the RPC version in
> 2.4.17 was incompatible.

I'm sorry, but the NFS server in 2.4.10 (and hence Suse 7.3) has a bug
w.r.t. NFSv3 and symlinks.
Go for NFSv2 or a different kernel.

> 
> I have a work around, but it might be worthwhile 
> to check out.

Fixed in 2.4.11-dontuse and later

> 
> Note that not every symbolic link created on the
> NFS file system during the build procedure is bad,
> just a few of them.

The ones where the length of the content is a multiple of 4 bytes in
fact.

NeilBrown

> 
> Joachim Martillo
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
