Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129927AbRBSAjh>; Sun, 18 Feb 2001 19:39:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129994AbRBSAj1>; Sun, 18 Feb 2001 19:39:27 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:9490 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S129927AbRBSAjW>; Sun, 18 Feb 2001 19:39:22 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: dek_ml@konerding.com
Date: Mon, 19 Feb 2001 11:37:54 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14992.27362.114723.93990@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: problems with reiserfs + nfs using 2.4.2-pre4
In-Reply-To: message from dek_ml@konerding.com on Sunday February 18
In-Reply-To: <200102190018.f1J0IBo08575@konerding.com>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday February 18, dek_ml@konerding.com wrote:
> 
> Hi,
> 
> I migrated some exported disks over to reiserfs and had no luck when I
> mounted the disk via NFS on another machine.  I've noticed many messages
> about reiser and NFS in the archives, but my understanding was that
> it had been cleared up.  In particular, the Configure.help in 2.4.2-pre4
> says "reiserfs can be used for anything that ext2 can be used for".

pure marketing!  Last I checked, it didn't have quotas either (well, it
is available as an extra patch, but they might make incompatable
changes later I gather).

If you go to

  http://www.cse.unsw.edu.au/~neilb/patches/linux/2.4.2-pre3/

and pick up patch-B-nfsdops and patch-C-reisernfs
you should get reasonable nfs service for reiserfs.
Note that this is not final code though.  The format of the filehandle
will probably change shortly as it doesn't currently contain a
generation number.
A similar patch is available somewhere under www.namesys.com I
believe.

NeilBrown
