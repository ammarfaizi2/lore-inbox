Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274027AbRISJ0o>; Wed, 19 Sep 2001 05:26:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274028AbRISJ0e>; Wed, 19 Sep 2001 05:26:34 -0400
Received: from unthought.net ([212.97.129.24]:29409 "HELO mail.unthought.net")
	by vger.kernel.org with SMTP id <S274027AbRISJ0Z>;
	Wed, 19 Sep 2001 05:26:25 -0400
Date: Wed, 19 Sep 2001 11:26:49 +0200
From: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>
To: David Rees <dbr@greenhydrant.com>, linux-kernel@vger.kernel.org
Subject: Re: bdflush and postgres stuck in D state
Message-ID: <20010919112649.B7537@unthought.net>
Mail-Followup-To: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>,
	David Rees <dbr@greenhydrant.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20010918125605.F29908@unthought.net>, <20010918125605.F29908@unthought.net>; <20010918193023.P29908@unthought.net> <3BA78916.2984B011@zip.com.au> <20010918140820.A17263@greenhydrant.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2i
In-Reply-To: <20010918140820.A17263@greenhydrant.com>; from dbr@greenhydrant.com on Tue, Sep 18, 2001 at 02:08:20PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2001 at 02:08:20PM -0700, David Rees wrote:
> On Tue, Sep 18, 2001 at 10:49:10AM -0700, Andrew Morton wrote:
> > Jakob Østergaard wrote:
> > > 
> > > Sorry for following up on my own post, I have a little extra
> > > information.
> > > 
> > > I started a g++ job to try to force the machine to write out some dirty
> > > buffers before I reboot.   g++ now hangs along with two sync's, bdflush
> > > and the postgres process.
> > > 
> > 
> > Since 2.4.7 several bugs have been fixed in RAID1 which would
> > cause this, including a missing blockdevice unplug and failure
> > to hang onto the supposedly-reserved RAID1 buffer-heads.
> 
> Even kernels as recent as 2.4.9 have this bug.  See this thread for more
> info and a patch which fixes this bug.
> 
> The thread:
> http://marc.theaimsgroup.com/?t=99911655500004&w=2&r=1
> 
> The patch:
> http://marc.theaimsgroup.com/?l=linux-kernel&m=99913223508789&w=2


Thanks a lot !

Somehow I seem not have lost "most" linux-raid mails, dunno why...  I hadn't
seen that thread before, but it was indeed the problem I saw here too.

I didn't lose any data on the 2.4.7 that did this, but it seems the situation
is more severe in 2.4.9, leading potentially to significant data loss.

/me prepares another boot (and a spare 32MB stick) for the raid-1 box

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
