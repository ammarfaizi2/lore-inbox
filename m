Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288955AbSBMVeX>; Wed, 13 Feb 2002 16:34:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288959AbSBMVeE>; Wed, 13 Feb 2002 16:34:04 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:58694 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S288955AbSBMVdv>; Wed, 13 Feb 2002 16:33:51 -0500
Date: Wed, 13 Feb 2002 23:33:41 +0200
From: Ville Herva <vherva@niksula.hut.fi>
To: Mark Cooke <mpc@star.sr.bham.ac.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Quick question on Software RAID support.
Message-ID: <20020213213341.GI1105@niksula.cs.hut.fi>
Mail-Followup-To: Ville Herva <vherva@niksula.cs.hut.fi>,
	Mark Cooke <mpc@star.sr.bham.ac.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <E16axOE-0004zX-00@the-village.bc.nu> <Pine.LNX.4.44.0202131824530.29582-100000@pc24.sr.bham.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0202131824530.29582-100000@pc24.sr.bham.ac.uk>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2002 at 06:30:01PM +0000, you [Mark Cooke] wrote:
> Hi Alan,
> 
> Just a note that I have almost exactly the setup you outlined on a 
> KT7A-RAID, HPT370 onboard.
> 
> I have a single disk on each highpoint chain, and a 3rd (parity) on 
> one of the onboard 686B channels.
> 
> I have been seeing odd corruptions since I setup the system as RAID-5 
> though.  Have you seen any reports of 686B ide corruption recently (or 
> RAID-5 for that matter) ?
> 
> kernel 2.4.18pre6... just compiling pre9-ac3...
> Athlon MP 1500+, mem=nopentium apm=off, NvAGP=0 in X-setup.

After months of testing, we found that KT7-RAID (we tested KT7A-RAID as
well) is basicly impossible to get working reliably. It *always* corrupted
data from HPT370, no matter what we tried. It seemed VIA PCI problem as
things like the pci slot of the nic, network load, nic model etc greatly
affected corruption rate. (Via 686b ide never corrupted data, but then again
it's integrated in the south bridge and perhaps avoids full PCI path). Our
combination was software RAID0 (one disk on ide2 and ide3 (HPT370
channels)).

We ditched the board deep, took an Abit ST6-RAID (i815+HPT370) and have had
no problems since. 

My position is that for heavy PCI load (additional IDE adapters etc), stay
away from Via.

BTW: I have a little program to stress the raid volume (or any disk device
for that matter) that I used to trigger the corruption. It is destructive
for the data, though. I can mail it to you, if you like.

 
-- v --

v@iki.fi
