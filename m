Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315424AbSEBVOC>; Thu, 2 May 2002 17:14:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315425AbSEBVOB>; Thu, 2 May 2002 17:14:01 -0400
Received: from unthought.net ([212.97.129.24]:42133 "HELO mail.unthought.net")
	by vger.kernel.org with SMTP id <S315424AbSEBVOA>;
	Thu, 2 May 2002 17:14:00 -0400
Date: Thu, 2 May 2002 23:13:59 +0200
From: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Martin Dalecki <dalecki@evision-ventures.com>,
        Pavel Machek <pavel@suse.cz>, Roy Sigurd Karlsbakk <roy@karlsbakk.net>,
        linux-kernel@vger.kernel.org
Subject: Re: IDE hotplug support?
Message-ID: <20020502231359.W31556@unthought.net>
Mail-Followup-To: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Martin Dalecki <dalecki@evision-ventures.com>,
	Pavel Machek <pavel@suse.cz>,
	Roy Sigurd Karlsbakk <roy@karlsbakk.net>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020502215833.V31556@unthought.net> <E173N9y-0004k1-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 02, 2002 at 09:26:38PM +0100, Alan Cox wrote:
> > >=20
> > > 8 x 130MBy/s >>>> PCI bus throughput... I would rather recommend
> > > a classical RAID controller card for this kind of
> > > setup.
> > 
> > Because RAID controllers do not use the PCI bus ???    ;)
> 
> The raid card transfers the data once, software raid once per device for
> Raid 1/5 - thats a killer.

For RAID-1 it's a killer (for writes), I agree.

But I really doubt it would be so horrible for RAID-5 - after all, it's only
one extra block (the parity block) for each N-1 blocks written (for an N disk
RAID-5).  The penalty should be less, the more disks you have in the array.

But seriously, has anyone out there ever seen a hardware RAID controller with
a *sustained* RAID-5 thoughput of more than 60 MB/sec ?   Not that I think it
is impossible, but I've never heard about it.  Enlighten me, please, and not
with marketing numbers...

> 
> > By the way, has anyone tried such larger multi-controller setups, and t=
> > ested
> > the bandwidth in configurations with multiple PCI busses on the board, =
> > versus a
> > single PCI bus ?
> 
> With 2.4 yes. With all the 2.5 changes no.

Did you get any speedup ?  Were you close to PCI bus saturation in the one-bus
scenario ?

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
