Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130829AbQJaXWF>; Tue, 31 Oct 2000 18:22:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130859AbQJaXVz>; Tue, 31 Oct 2000 18:21:55 -0500
Received: from mail.zmailer.org ([194.252.70.162]:22532 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S130829AbQJaXVW>;
	Tue, 31 Oct 2000 18:21:22 -0500
Date: Wed, 1 Nov 2000 01:21:03 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Paul Menage <pmenage@ensim.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.2.18Pre Lan Performance Rocks!
Message-ID: <20001101012103.J833@mea-ext.zmailer.org>
In-Reply-To: <E13qj56-0003h9-00@pmenage-dt.ensim.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E13qj56-0003h9-00@pmenage-dt.ensim.com>; from pmenage@ensim.com on Tue, Oct 31, 2000 at 01:36:32PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2000 at 01:36:32PM -0800, Paul Menage wrote:
> On Tue, 31 Oct 2000, Rik van Riel wrote:
> >Ummm, last I looked Linux held the Specweb99 record;
> >by a wide margin...
> 
> ... but since then IBM/Zeus appear to have taken the lead:
> 
> http://www.spec.org/osg/web99/results/res2000q3/
> 
> But they were using a somewhat beefier machine - has anyone got Tux
> SpecWeb99 figures for a 12 CPU, 64 GB, 12 NIC system?

  Good grief, what monster hardware...

  Those are (of course) system results which give some impression of
  how much users can pull out of the box.

  Trying to make them a bit more comparable, scaling the number with
  the number of processors:

  Zeus     12x600MHz IBM RS64-III     7288 SpecWEB99  ~ 607 SpecWEB99/CPU
  Zeus     4x375MHz IBM Power3-II     2175 SpecWEB99  ~ 544 SpecWEB99/CPU
  TUX 1.0  8x700MHz Pentium-III-Xeon  6387 SpecWEB99  ~ 798 SpecWeb99/CPU
  IIS      2x800MHz Pentium-III-Xeon  1060 SpecWEB99  ~ 530 SpecWEB99/CPU
  IIS      1x700MHz Pentium-III-Xeon   971 SpecWEB99  = 971 SpecWEB99/CPU

  Ok, more workers to do the thing, but each can achieve a bit less in
  the IBM/Zeus case than TUX 1.0.   The smaller IBM/Zeus test case with
  older and slower processors yields almost as good results per CPU as
  the big one.   CPU clock speed increase has been lost into inter-CPU
  collisions ?  (that is, bad scaling)

  The IIS results are also interesting in their own.  Single-CPU IIS
  yields impressive PER CPU result, but adding second CPU is apparently
  quite useless excercise.   Hmm... Can't be..  As if that DUAL CPU
  result is actually run in single-CPU mode.  The difference can
  directly be explained by the clock rate difference..
  (Surely the runners of that test *can't* make such an elementary
   mistake!)


  To be able to compare apples and apples, I would like to see single,
  and dual CPU SpecWEB99 results with TUX.  Then that apparent 20%
  better "per CPU result" of the single-CPU IIS could not be explained
  away with SMP inter-CPU communication overhead/collisions.

> Paul

/Matti Aarnio
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
