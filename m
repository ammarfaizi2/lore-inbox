Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271254AbRH3CuP>; Wed, 29 Aug 2001 22:50:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271267AbRH3CuG>; Wed, 29 Aug 2001 22:50:06 -0400
Received: from [208.48.139.185] ([208.48.139.185]:41606 "HELO
	forty.greenhydrant.com") by vger.kernel.org with SMTP
	id <S271254AbRH3Cty>; Wed, 29 Aug 2001 22:49:54 -0400
Date: Wed, 29 Aug 2001 19:50:06 -0700
From: David Rees <dbr@greenhydrant.com>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: kupdated, bdflush and kjournald stuck in D state on RAID1 device (deadlock?)
Message-ID: <20010829195006.B23371@greenhydrant.com>
Mail-Followup-To: David Rees <dbr@greenhydrant.com>,
	Neil Brown <neilb@cse.unsw.edu.au>, linux-raid@vger.kernel.org,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010829144016.C20968@greenhydrant.com> <3B8D6BF9.BFFC4505@zip.com.au> <20010829153818.B21590@greenhydrant.com> <3B8D712C.1441BC5A@zip.com.au> <20010829155633.D21590@greenhydrant.com> <15245.35636.82680.966567@notabene.cse.unsw.edu.au> <20010829175541.E21590@greenhydrant.com> <15245.37937.625032.867615@notabene.cse.unsw.edu.au> <20010829182406.A23371@greenhydrant.com> <15245.40794.888447.345100@notabene.cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <15245.40794.888447.345100@notabene.cse.unsw.edu.au>; from neilb@cse.unsw.edu.au on Thu, Aug 30, 2001 at 12:05:14PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2001 at 12:05:14PM +1000, Neil Brown wrote:
> On Wednesday August 29, dbr@greenhydrant.com wrote:
> > 
> > Now, when you say out-of-memory, do you mean out of memory plus swap?  Or
> > just out of memory?
> 
> kmalloc(,GFP_NOIO) failure.  i.e. transient out-of-phyical-memory
> condition. 
> I suspect that kmalloc tends to fail only occasionally as the failure
> will then to slow allocation requests down, and give the VM system a
> bit of time to write more stuff out to disc and so free up memory.  
> I am fairly sure that without the patch it will happen again, but
> maybe not straight away.

OK, that explains how it happened, then.  Memory had filled up while
copying a good deal of data to the raid partition from another partition. 
That must have been when it ran out of memory and hung up.

I'll post again if anything else strange/bad happens.

Thanks,
Dave
