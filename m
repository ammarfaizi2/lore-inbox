Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030291AbWBMXgE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030291AbWBMXgE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 18:36:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030294AbWBMXgE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 18:36:04 -0500
Received: from mail.gmx.net ([213.165.64.21]:57055 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1030291AbWBMXgC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 18:36:02 -0500
X-Authenticated: #7318305
Subject: Re: 2.6.16-rc3: more regressions
From: Felix =?ISO-8859-1?Q?K=FChling?= <fxkuehl@gmx.de>
To: Jesse Allen <the3dfxdude@gmail.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Adrian Bunk <bunk@stusta.de>,
       Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Mauro Tassinari <mtassinari@cmanet.it>, airlied@linux.ie,
       dri-devel@lists.sourceforge.net
In-Reply-To: <530468570602131527nbd17ddn262b92304adf4f86@mail.gmail.com>
References: <Pine.LNX.4.64.0602121709240.3691@g5.osdl.org>
	 <20060213170945.GB6137@stusta.de>
	 <Pine.LNX.4.64.0602130931221.3691@g5.osdl.org>
	 <20060213174658.GC23048@redhat.com>
	 <Pine.LNX.4.64.0602130952210.3691@g5.osdl.org>
	 <Pine.LNX.4.64.0602131007500.3691@g5.osdl.org>
	 <20060213183445.GA3588@stusta.de>
	 <Pine.LNX.4.64.0602131043250.3691@g5.osdl.org>
	 <20060213190907.GD3588@stusta.de>
	 <Pine.LNX.4.64.0602131115010.3691@g5.osdl.org>
	 <530468570602131527nbd17ddn262b92304adf4f86@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Date: Mon, 13 Feb 2006 18:35:57 -0500
Message-Id: <1139873757.17357.32.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 8BIT
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, den 13.02.2006, 16:27 -0700 schrieb Jesse Allen:
> On 2/13/06, Linus Torvalds <torvalds@osdl.org> wrote:
> >
> >
> > On Mon, 13 Feb 2006, Adrian Bunk wrote:
> > >
> > > The one thing I have not yet been proven wrong for is that this PCI id
> > > is the only one we have in this driver for an RV370.
> >
> > It definitely is an RV370, you're right in that. I'm too lazy to actually
> > see if the other entries that claim to be RV350's really are RV350's.
> >
> 
> Well a while back, I hacked in the pci id for my Xpress 200M (5955),
> which is basically an RV370 with no dedicated vram.  I did the same
> thing and claimed an RV350, which is the closest model.  This allowed
> the radeon module to load.  When I startx'ed and DRI was allowed to
> load on it, it locked up.  So I never sent in the patch.  I believe
> the person who sent this one in originally seemed to indicate that it
> worked, and I believed it if he had an X300 and my problem was having
> the IGP version.  But now having this reported, I'm pretty sure it is
> the same problem.  RV370 doesn't seem to work as an RV350.

The Xpress200 chips have a completely different GART implementation.
Thus the driver can't even send commands to the command processor and
that's why X locked up on you when DRI was enabled. This has nothing to
do with the Xpress200 being (almost) an RV370 or not.

Regards,
  Felix

-- 
| Felix Kühling <fxkuehl@gmx.de>                     http://fxk.de.vu |
| PGP Fingerprint: 6A3C 9566 5B30 DDED 73C3  B152 151C 5CC1 D888 E595 |

