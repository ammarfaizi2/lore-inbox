Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131723AbRCTFdn>; Tue, 20 Mar 2001 00:33:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131725AbRCTFdd>; Tue, 20 Mar 2001 00:33:33 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:44036 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S131723AbRCTFdX>; Tue, 20 Mar 2001 00:33:23 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: acc@CS.Stanford.EDU
Date: Tue, 20 Mar 2001 16:33:17 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15030.60317.715787.369652@dulcimer.orchestra.cse.unsw.EDU.AU>
Cc: linux-kernel@vger.kernel.org, mc@CS.Stanford.EDU
Subject: Re: [CHECKER] 16 potential locking bugs in 2.4.1
In-Reply-To: message from Andy Chou on Friday March 16
In-Reply-To: <20010316213444.A3592@Xenon.Stanford.EDU>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday March 16, acc@CS.Stanford.EDU wrote:
> Here are some more results from the MC project.  These are 16 errors found
> in 2.4.1 related to inconsistent use of locks.  As usual, if you can
> verify any of these or show that they are false positives, please let us
> know by CC'ing mc@cs.stanford.edu.
> 
> -Andy Chou
> 
> | fs/nfsd/vfs.c                   | nfsd_link                  |
> | fs/nfsd/vfs.c                   | nfsd_symlink               |

These are not actually bugs.  The usage of fh_lock is fairly obscure.
The unlock gets done by an fh_put which the caller does after calling
nfsd_link or nfs_symlink.

NeilBrown
