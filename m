Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317293AbSGDAaH>; Wed, 3 Jul 2002 20:30:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317298AbSGDAaG>; Wed, 3 Jul 2002 20:30:06 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:57788 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S317293AbSGDAaF>; Wed, 3 Jul 2002 20:30:05 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Helge Hafting <helgehaf@aitel.hist.no>
Date: Thu, 4 Jul 2002 10:34:29 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15651.38933.361225.748326@notabene.cse.unsw.edu.au>
cc: linux-kernel@vger.kernel.org, davej@suse.de
Subject: Re: 2.5.24-dj1,smp,ext2,raid0: I got random zero blocks in my files.
In-Reply-To: message from Helge Hafting on Monday July 1
References: <3D200BF6.3A6D9B59@aitel.hist.no>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday July 1, helgehaf@aitel.hist.no wrote:
> 2.5.24-dj1 gave me files with zeroed blocks inside.
> What I did:  I untarred the source for lyx 1.2.0
> and tried to compile it, several times.
> 
> gcc and make choked on occational blocks of zeroes
> inside files, different places each time.
> Going back to 2.5.18 fixed it.
> 
> This isn't all that surprising considering that
> the raid driver logs complaints about requests
> bigger than 32k, which is the stripe size.
> I believed this worked by retrying with much smaller
> requests, perhaps I am wrong?

You are wrong. It doesn't re-try.  It just fails.
raid0 does not work in 2.5 yet.  Don't even both trying.

NeilBrown
