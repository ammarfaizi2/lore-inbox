Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314707AbSE3MBu>; Thu, 30 May 2002 08:01:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316194AbSE3MBt>; Thu, 30 May 2002 08:01:49 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:34493 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S314707AbSE3MBs>; Thu, 30 May 2002 08:01:48 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: me@vger.org
Date: Thu, 30 May 2002 22:01:24 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15606.5268.471724.793301@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, Andre Hedrick <andre@linux-ide.org>
Subject: Re: Strange RAID2 behavier...
In-Reply-To: message from me@vger.org on Thursday May 30
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday May 30, me@vger.org wrote:
> 
> # raidstop --all /dev/md3
> /dev/md3: Device or resource busy

This just means that /dev/md3 is busy.
Is it mounted?  Does any process have it open?

There is a bug in one version of raidtools that causes raidstop to
incorrectly report this error, but I think that bug only affects
/dev/md0..
What does
   strace raidstop /dev/md3
show?

NeilBrown
