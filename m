Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278450AbRKDUGd>; Sun, 4 Nov 2001 15:06:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278269AbRKDUGX>; Sun, 4 Nov 2001 15:06:23 -0500
Received: from unthought.net ([212.97.129.24]:61912 "HELO mail.unthought.net")
	by vger.kernel.org with SMTP id <S277435AbRKDUGU>;
	Sun, 4 Nov 2001 15:06:20 -0500
Date: Sun, 4 Nov 2001 21:06:19 +0100
From: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>
To: Alexander Viro <viro@math.psu.edu>
Cc: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>,
        John Levon <moz@compsoc.man.ac.uk>, linux-kernel@vger.kernel.org,
        Daniel Phillips <phillips@bonn-fries.net>, Tim Jansen <tim@tjansen.de>
Subject: Re: PROPOSAL: dot-proc interface [was: /proc stuff]
Message-ID: <20011104210619.S14001@unthought.net>
Mail-Followup-To: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>,
	Alexander Viro <viro@math.psu.edu>,
	Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>,
	John Levon <moz@compsoc.man.ac.uk>, linux-kernel@vger.kernel.org,
	Daniel Phillips <phillips@bonn-fries.net>,
	Tim Jansen <tim@tjansen.de>
In-Reply-To: <20011104204502.O14001@unthought.net> <Pine.GSO.4.21.0111041450410.21449-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.GSO.4.21.0111041450410.21449-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Sun, Nov 04, 2001 at 02:52:56PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 04, 2001 at 02:52:56PM -0500, Alexander Viro wrote:
> 
> 
> On Sun, 4 Nov 2001, [iso-8859-1] Jakob %stergaard wrote:
> 
> > > If you feel it's too hard to write use scanf(), use sh, awk, perl
> > > etc. which all have their own implementations that appear to have
> > > served UNIX quite well for a long while.
> > 
> > Witness ten lines of vmstat output taking 300+ millions of clock cycles.
> 
> Would the esteemed sir care to check where these cycles are spent?
> How about "traversing page tables of every damn process out there"?
> Doesn't sound like a string operation to me...
> 

I'm sure your're right.   It's probably not just string operations. And maybe
then don't even dominate.

And I'm sure that vmstat doesn't use sh, awk, and perl either.

Anyway, the efficiency issues was mainly me getting side-tracked from the main
issue as I see it.

The point I wanted to make was, that we need an interface thats possible to
parse "correctly", not "mostly correctly", and we need to be able to parse it
in a way so that we do not have to rely on a myriad of small tools (that change
over time too).

You need something that's simple and correct.  If it's ASCII, well let it be
ASCII. But /proc as it is today is not possible to parse reliably.  See my "cat
vs. c)(a" example.   You can parse it "mostly reliable", but that's just not
good enough.

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
