Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262810AbTEMDmL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 23:42:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262718AbTEMDmL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 23:42:11 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:42886 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S262323AbTEMDmK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 23:42:10 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Chuck Ebbert <76306.1226@compuserve.com>
Date: Tue, 13 May 2003 13:53:45 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16064.27721.125256.295803@notabene.cse.unsw.edu.au>
Cc: linux-raid <linux-raid@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] Fix "two RAID1 mirrors are faster than three"
In-Reply-To: message from Chuck Ebbert on Monday May 12
References: <200305121322_MC3-1-3884-D0AC@compuserve.com>
X-Mailer: VM 7.15 under Emacs 21.3.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday May 12, 76306.1226@compuserve.com wrote:
> 
>   This patch is only lightly tested on 2.4.21-rc2-ac1.
> 
>   It attempts to speed up single sequential streaming reads as well as
> fixing the problem with multiple streams not working on 3+ disk
> mirrors.  With this patch applied I get full speed form all three
> disks when reading three streams at once.
> 
>   A version of this on 2.4.20aa1 gives about 60% performance gains on single
> sequential streams but it yields effectively no gain on stock kernels (?)
> I've given up trying to figure out why...
> 
>   How much of this is worth merging?  (One line has already been
>   rejected.)

Hard to say.  As you mentioned in another email, it changes too much
stuff.

Either split it into logic bits, or explain in detail what it is
trying to achieve, or both, and I will tell you what I think.

NeilBrown
