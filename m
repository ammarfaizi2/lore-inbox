Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946005AbWBOQWl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946005AbWBOQWl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 11:22:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946007AbWBOQWl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 11:22:41 -0500
Received: from nproxy.gmail.com ([64.233.182.199]:35600 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1946005AbWBOQWk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 11:22:40 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=h/NDkOCqJcsnVNV4oPmaugT+IH7OIIO8mGOHCj5PVFc3B6W6+VqEhPGeY5WfzYoFPVs8NSVXjN7pS/0PHxaWlxtCGk9WMaKiaBFvJr2TZi6rGVICTkz+JU+TQIf1DCh6Ya+4S2lY1mNneQH8MuMDZEogTSMbzDnIFjrsbvvKLpI=
Message-ID: <530468570602150822q4977f091v5fabb39c42e652e@mail.gmail.com>
Date: Wed, 15 Feb 2006 09:22:38 -0700
From: Jesse Allen <the3dfxdude@gmail.com>
To: =?ISO-8859-1?Q?Felix_K=FChling?= <fxkuehl@gmx.de>
Subject: Re: 2.6.16-rc3: more regressions
Cc: Linus Torvalds <torvalds@osdl.org>, Adrian Bunk <bunk@stusta.de>,
       Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Mauro Tassinari <mtassinari@cmanet.it>, airlied@linux.ie,
       dri-devel@lists.sourceforge.net
In-Reply-To: <1139873757.17357.32.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <Pine.LNX.4.64.0602121709240.3691@g5.osdl.org>
	 <20060213174658.GC23048@redhat.com>
	 <Pine.LNX.4.64.0602130952210.3691@g5.osdl.org>
	 <Pine.LNX.4.64.0602131007500.3691@g5.osdl.org>
	 <20060213183445.GA3588@stusta.de>
	 <Pine.LNX.4.64.0602131043250.3691@g5.osdl.org>
	 <20060213190907.GD3588@stusta.de>
	 <Pine.LNX.4.64.0602131115010.3691@g5.osdl.org>
	 <530468570602131527nbd17ddn262b92304adf4f86@mail.gmail.com>
	 <1139873757.17357.32.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/13/06, Felix Kühling <fxkuehl@gmx.de> wrote:
> Am Montag, den 13.02.2006, 16:27 -0700 schrieb Jesse Allen:
> >
> > Well a while back, I hacked in the pci id for my Xpress 200M (5955),
> > which is basically an RV370 with no dedicated vram.  I did the same
> > thing and claimed an RV350, which is the closest model.  This allowed
> > the radeon module to load.  When I startx'ed and DRI was allowed to
> > load on it, it locked up.  So I never sent in the patch.  I believe
> > the person who sent this one in originally seemed to indicate that it
> > worked, and I believed it if he had an X300 and my problem was having
> > the IGP version.  But now having this reported, I'm pretty sure it is
> > the same problem.  RV370 doesn't seem to work as an RV350.
>
> The Xpress200 chips have a completely different GART implementation.
> Thus the driver can't even send commands to the command processor and
> that's why X locked up on you when DRI was enabled. This has nothing to
> do with the Xpress200 being (almost) an RV370 or not.
>


Well, I did not know about the GART problem.  So this means that
RV370s and XPRESS will be listed both separately in the driver in the
future?  They certainly don't function as an RV350 and of course they
aren't quite compatable then.

Jesse
