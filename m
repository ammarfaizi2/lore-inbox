Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132815AbRDDNJZ>; Wed, 4 Apr 2001 09:09:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132816AbRDDNJP>; Wed, 4 Apr 2001 09:09:15 -0400
Received: from adsl-213-254-163-44.mistral-uk.net ([213.254.163.44]:22544 "EHLO
	crucigera.fysh.org") by vger.kernel.org with ESMTP
	id <S132815AbRDDNJA>; Wed, 4 Apr 2001 09:09:00 -0400
Date: Wed, 4 Apr 2001 14:08:16 +0100
From: Athanasius <Athanasius@miggy.org>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.3 freeze under heavy writing + open rxvt
Message-ID: <20010404140816.I18503@miggy.org>
Mail-Followup-To: Athanasius <Athanasius@miggy.org>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010403223222.A669@netnation.com> <Pine.SGI.4.31L.02.0104032300370.2523169-100000@irix2.gl.umbc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.SGI.4.31L.02.0104032300370.2523169-100000@irix2.gl.umbc.edu>; from jjasen1@umbc.edu on Tue, Apr 03, 2001 at 11:02:51PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 03, 2001 at 11:02:51PM -0400, John Jasen wrote:
> On Tue, 3 Apr 2001, Simon Kirby wrote:
> 
> > Three times now I've had 2.4.3 freeze on my dual CPU box while doing a
> > "dd if=/dev/zero of=/dev/hdc bs=1024k" (a drive to be RMA'd :)).  I got
> > bored and opened an rxvt, and as the machine was swapping in (I assume),
> > everything froze.  The mouse still moved for about 5 seconds before the
> > freeze, and the window was visible as it was attempting to start tcsh.
> 
> I've noticed the same thing. I was doing a rather sadistic test, checking
> a memory chip.
> 
> one window: make -j in 2.4.2 src; and in another, dd if=/dev/hda
> of=/dev/null bs=4096k.

   Playing around with the Mesa3D demos last night I had 3 similar
lockups.  The system is a PII-400 128MB RAM, 256MB swap on vanilla 2.4.3
(also did this on 2.4.2-ac18 as it happens).  There's:

	a) A similar lockup to described above, I caught my 'resetv2'
	(small util to just initialise a voodoo2 then exit cleanly, or
	so I thought) chewing up VM like it was going out of fashion.
	Shortly thereafter solid lockup, LEDs not working etc, although
	I think I forgot to try Alt-SysRq+R that time to see if the
	keyboard would come back to life.
	
	b) Running a Mesa3D demo that uses threads was fine with 3 or 5,
	try it with 10, instant lockup, no magic sysrq, had to hit the
	reset button.  So I'd assume some other issue with threads in
	2.4.3/2.4.2-ac18

-Ath
-- 
- Athanasius = Athanasius(at)miggy.org / http://www.miggy.org/
                  Finger athan(at)fysh.org for PGP key
	   "And it's me who is my enemy. Me who beats me up.
Me who makes the monsters. Me who strips my confidence." Paula Cole - ME
