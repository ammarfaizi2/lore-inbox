Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275718AbRI0BeK>; Wed, 26 Sep 2001 21:34:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275729AbRI0BeB>; Wed, 26 Sep 2001 21:34:01 -0400
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:26379 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S275718AbRI0Bd6>; Wed, 26 Sep 2001 21:33:58 -0400
Date: Thu, 27 Sep 2001 03:34:22 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Trond Eivind Glomsr?d <teg@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Locking comment on shrink_caches()
Message-ID: <20010927033422.A2894@suse.cz>
In-Reply-To: <fa.cbgmt3v.192gc8r@ifi.uio.no> <fa.cd0mtbv.1aigc0v@ifi.uio.no> <i1m66a5o1zc.fsf@verden.pvv.ntnu.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <i1m66a5o1zc.fsf@verden.pvv.ntnu.no>; from teg@redhat.com on Thu, Sep 27, 2001 at 03:29:27AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2001 at 03:29:27AM +0200, Trond Eivind Glomsr?d wrote:

> Vojtech Pavlik <vojtech@suse.cz> writes:
> 
> > On Wed, Sep 26, 2001 at 10:20:21PM +0200, Vojtech Pavlik wrote:
> > 
> > > > generic Athlon is
> > > > 
> > > > nothing: 11 cycles
> > > > locked add: 11 cycles
> > > > cpuid: 64 cycles
> > > 
> > > Interestingly enough, my TBird 1.1G insist on cpuid being somewhat
> > > slower:
> > > 
> > > nothing: 11 cycles
> > > locked add: 11 cycles
> > > cpuid: 87 cycles
> > 
> > Oops, this is indeed just a difference in compiler options.
> 
> No, it's not:
> 
> [teg@xyzzy teg]$ ./t
> nothing: 11 cycles
> locked add: 11 cycles
> cpuid: 64 cycles
> [teg@xyzzy teg]$ ./t
> nothing: 11 cycles
> locked add: 11 cycles
> cpuid: 64 cycles
> [teg@xyzzy teg]$ 
> [teg@xyzzy teg]$ ./t
> nothing: 11 cycles
> locked add: 11 cycles
> cpuid: 87 cycles
> [teg@xyzzy teg]$ ./t
> nothing: 11 cycles
> locked add: 11 cycles
> cpuid: 87 cycles
> [teg@xyzzy teg]$ ./t
> nothing: 11 cycles
> locked add: 11 cycles
> cpuid: 64 cycles

Interesting: Try while true; do t; done and watch it change between 64
and 87 every 2.5 seconds ... :)

-- 
Vojtech Pavlik
SuSE Labs
