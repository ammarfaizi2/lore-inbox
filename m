Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289243AbSBNAns>; Wed, 13 Feb 2002 19:43:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289270AbSBNAni>; Wed, 13 Feb 2002 19:43:38 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:34178 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S289243AbSBNAnd>; Wed, 13 Feb 2002 19:43:33 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Craig Christophel <merlin@transgeek.com>
Date: Thu, 14 Feb 2002 11:42:26 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15467.2034.663448.825288@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, Keith Owens <kaos@ocs.com.au>
Subject: Re: [PATCH] -- filesystems.c::sys_nfsservctl 
In-Reply-To: message from Craig Christophel on Wednesday February 13
In-Reply-To: <20020213205144Z282414-24962+32@thor.valueweb.net>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday February 13, merlin@transgeek.com wrote:
> Ok guys get ready to flame me....  
> 
> 	The attached patch removes the lock/unlock in this function.   Now I am 80% 
> sure of this one, but would like a word from the kmod maintainer about 
> whether request_module needs the BKL or not.   do_nfsservctl already takes 
> the BKL inside the function so as long as request_module is safe this pair 
> can be removed -- effectively making do_nfsservctl responsible for it's own 
> locking scheme.
> 
> 	So whoever knows for SURE about request_module, please reply.

Please see
  http://www.cse.unsw.edu.au/~neilb/patches/linux-devel/2.5.4-pre5/
for current nfsd patches.
  patch-E-NfsdSyscallCleanup  
might be of particular interest.

When I have finished testing these (sometime next week I hope) I will
be submitting them to Linux for 2.5, and then backporting them to 2.4,
and hopefully submitting the least intrusive ones to Marcello shortly
after 2.4.18 comes out.

These patches:
  remove most of the BKL
  enable TCP support
  plus assorted other things.

Comments, and testing, most welcome.

NeilBrown
