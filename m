Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271200AbRH3CFX>; Wed, 29 Aug 2001 22:05:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271207AbRH3CFO>; Wed, 29 Aug 2001 22:05:14 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:25608 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S271200AbRH3CFK>; Wed, 29 Aug 2001 22:05:10 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: David Rees <dbr@greenhydrant.com>
Date: Thu, 30 Aug 2001 12:05:14 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15245.40794.888447.345100@notabene.cse.unsw.edu.au>
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: kupdated, bdflush and kjournald stuck in D state on RAID1 device (deadlock?)
In-Reply-To: message from David Rees on Wednesday August 29
In-Reply-To: <20010829141451.A20968@greenhydrant.com>
	<3B8D60CF.A1400171@zip.com.au>
	<20010829144016.C20968@greenhydrant.com>
	<3B8D6BF9.BFFC4505@zip.com.au>
	<20010829153818.B21590@greenhydrant.com>
	<3B8D712C.1441BC5A@zip.com.au>
	<20010829155633.D21590@greenhydrant.com>
	<15245.35636.82680.966567@notabene.cse.unsw.edu.au>
	<20010829175541.E21590@greenhydrant.com>
	<15245.37937.625032.867615@notabene.cse.unsw.edu.au>
	<20010829182406.A23371@greenhydrant.com>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday August 29, dbr@greenhydrant.com wrote:
> 
> Now, when you say out-of-memory, do you mean out of memory plus swap?  Or
> just out of memory?

kmalloc(,GFP_NOIO) failure.  i.e. transient out-of-phyical-memory
condition. 
I suspect that kmalloc tends to fail only occasionally as the failure
will then to slow allocation requests down, and give the VM system a
bit of time to write more stuff out to disc and so free up memory.  
I am fairly sure that without the patch it will happen again, but
maybe not straight away.


NeilBrown

> 
> Running out of memory is quite common with the kernel always filling up
> buffers and cache, but running out of memory+swap is not common (and I know
> I didn't hit that in my setup!)
> 
> Thanks for your help,
> 
> -Dave
