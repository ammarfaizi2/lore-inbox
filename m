Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271186AbRH3BYQ>; Wed, 29 Aug 2001 21:24:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271187AbRH3BYG>; Wed, 29 Aug 2001 21:24:06 -0400
Received: from [208.48.139.185] ([208.48.139.185]:11141 "HELO
	forty.greenhydrant.com") by vger.kernel.org with SMTP
	id <S271186AbRH3BXy>; Wed, 29 Aug 2001 21:23:54 -0400
Date: Wed, 29 Aug 2001 18:24:06 -0700
From: David Rees <dbr@greenhydrant.com>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: kupdated, bdflush and kjournald stuck in D state on RAID1 device (deadlock?)
Message-ID: <20010829182406.A23371@greenhydrant.com>
Mail-Followup-To: David Rees <dbr@greenhydrant.com>,
	Neil Brown <neilb@cse.unsw.edu.au>, linux-raid@vger.kernel.org,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010829141451.A20968@greenhydrant.com> <3B8D60CF.A1400171@zip.com.au> <20010829144016.C20968@greenhydrant.com> <3B8D6BF9.BFFC4505@zip.com.au> <20010829153818.B21590@greenhydrant.com> <3B8D712C.1441BC5A@zip.com.au> <20010829155633.D21590@greenhydrant.com> <15245.35636.82680.966567@notabene.cse.unsw.edu.au> <20010829175541.E21590@greenhydrant.com> <15245.37937.625032.867615@notabene.cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <15245.37937.625032.867615@notabene.cse.unsw.edu.au>; from neilb@cse.unsw.edu.au on Thu, Aug 30, 2001 at 11:17:37AM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(took ext3-users out of CC, not relevant to them anymore)

On Thu, Aug 30, 2001 at 11:17:37AM +1000, Neil Brown wrote:
> On Wednesday August 29, dbr@greenhydrant.com wrote:
> > 
> > I'm curious, why hasn't this bug shown up before?  Did I just get unlucky? 
> > Or is everyone else using software raid1 without problems lucky?  8)
> 
> You just got lucky.....
> This could affect anyone who ran out of free memory while doing IO to
> a RAID1 array.
> A recent change, which was intended to make this stuff more robust,
> probably had the side effect of making the bug more fatal.  So it
> probably only affects people running 2.4.9.
> It could affect earlier kernels, but they would have to sustain an
> out-of-memory condition for longer.

Now, when you say out-of-memory, do you mean out of memory plus swap?  Or
just out of memory?

Running out of memory is quite common with the kernel always filling up
buffers and cache, but running out of memory+swap is not common (and I know
I didn't hit that in my setup!)

Thanks for your help,

-Dave
