Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271149AbRH3BTF>; Wed, 29 Aug 2001 21:19:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271135AbRH3BS4>; Wed, 29 Aug 2001 21:18:56 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:42758 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S271130AbRH3BSn>; Wed, 29 Aug 2001 21:18:43 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: David Rees <dbr@greenhydrant.com>
Date: Thu, 30 Aug 2001 11:17:37 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15245.37937.625032.867615@notabene.cse.unsw.edu.au>
Cc: Andrew Morton <akpm@zip.com.au>, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org, ext3-users@redhat.com
Subject: Re: kupdated, bdflush and kjournald stuck in D state on RAID1 device (deadlock?)
In-Reply-To: message from David Rees on Wednesday August 29
In-Reply-To: <3B8D54F3.46DC2ABB@zip.com.au>
	<20010829141451.A20968@greenhydrant.com>
	<3B8D60CF.A1400171@zip.com.au>
	<20010829144016.C20968@greenhydrant.com>
	<3B8D6BF9.BFFC4505@zip.com.au>
	<20010829153818.B21590@greenhydrant.com>
	<3B8D712C.1441BC5A@zip.com.au>
	<20010829155633.D21590@greenhydrant.com>
	<15245.35636.82680.966567@notabene.cse.unsw.edu.au>
	<20010829175541.E21590@greenhydrant.com>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday August 29, dbr@greenhydrant.com wrote:
> 
> I'm curious, why hasn't this bug shown up before?  Did I just get unlucky? 
> Or is everyone else using software raid1 without problems lucky?  8)

You just got lucky.....
This could affect anyone who ran out of free memory while doing IO to
a RAID1 array.
A recent change, which was intended to make this stuff more robust,
probably had the side effect of making the bug more fatal.  So it
probably only affects people running 2.4.9.
It could affect earlier kernels, but they would have to sustain an
out-of-memory condition for longer.

NeilBrown
